//
//  HFSelectorDataManage.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/1.
//  Copyright © 2020 huifan. All rights reserved.
//
// 选择器数据管理者

import Foundation
import ObjectMapper
import SwiftyJSON

class HFSelectorDataManage {
    
    static let shared = HFSelectorDataManage()
    
    init() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: 公共部门
    // 部门选择器数据源数组
    var departmentDataSource: Array<BRResultModel> = []
    
    // 部门索引字典
    var departmentIndexDataDic: [String: HFDepartmentModel] = [:]
    
    /// 加载部门数据
    static func loadDepartmentDataSource(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["osType"] = 1 as AnyObject // 应用类型0慧凡1幼儿园
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFPublicAPI.PubStructureAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFDepartmentModel>>().map(JSON: dic as! [String : Any] )
            
            if responseBaseModel?.model != nil {
                let dataArr = responseBaseModel?.model ?? []
                self.handelDepartmentDataSource(departmentModel: dataArr.first!)
                
                successClosure()
            }else{
                
                failClosure()
            }
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 处理部门数据
    private static func handelDepartmentDataSource(departmentModel: HFDepartmentModel) -> Void {
        
        if departmentModel.osLevel > 3 {
            return
        }
        
        if departmentModel.osLevel == 0 {
            shared.departmentDataSource.removeAll()
            shared.departmentIndexDataDic.removeAll()
        }
        
        if departmentModel.children.count == 0 {
            // 空数据，防止该部门下无数据
            let map = ["osId":"\(departmentModel.osId)\(departmentModel.osLevel)",
                       "osName":" ",
                       "osPid":departmentModel.osId,
                       "osLevel":departmentModel.osLevel + 1] as [String: AnyObject]
            let model = HFDepartmentModel.init(JSON: map)
            departmentModel.children.append(model!)
        }
        
        for item in departmentModel.children {
            let model = BRResultModel.init()
            model.parentKey = departmentModel.osLevel == 0 ? "-1" : departmentModel.osId
            model.parentValue = departmentModel.osName
            model.key = item.osId
            model.value = item.osName
            shared.departmentDataSource.append(model)
            
            shared.departmentIndexDataDic[model.key!] = item
            
            handelDepartmentDataSource(departmentModel: item)
        }
    }
    
    
    // MARK: 选择年级
    // 元组类型（年级选择数据数组，选择器数据数据源数组）
    static var gradeDataSource: ([HFGradeModel]?,[BRResultModel]?) {
        get {
            let models: [HFGradeModel] = shared.gradeIndexDataDic[kiId!] ?? []
            var tempModels: [HFGradeModel] = []
            var arr: [BRResultModel] = []
            for item in models {
                if item.enableStatus == 1 {
                    let model = BRResultModel.init()
                    model.value = item.kgrRemarkName
                    tempModels.append(item)
                    arr.append(model)
                }
            }
            return (tempModels,arr)
        }
    }
    
    // 年级索引数据
    private var gradeIndexDataDic: [String:[HFGradeModel]] = [:]
    
    // 幼儿园业务id
    private static var kiId = HFBabyViewModel.shared.currentBaby?.kiId
    
    /// 获取开启的年级列表
    static func loadGradeList(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {

        var parameters = [String: AnyObject]()
        parameters["kiId"] = kiId as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFKgMgrAPI.GetKggradesAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFGradeModel>>().map(JSON: dic as! [String : Any] )

            shared.gradeIndexDataDic[kiId!] = responseBaseModel?.model

            successClosure()
        }) { (error) in

            failClosure()
        }
    }
    // MARK：关系选择
    // 元组类型（关系选择数据数组，选择器数据数据源数组）
    static func classDataSource() -> ([HFChildrenRelationship]?,[BRResultModel]?) {
        var models: [HFChildrenRelationship] = []
        var arr: [BRResultModel] = []
        for model in shared.allShips {
            let resModel = BRResultModel.init()
            resModel.value = model.dicFieldName
            arr.append(resModel)
            models.append(model)
        }
        return (models,arr)
    }
    // 班级索引数据
    private var allShips: [HFChildrenRelationship] = []
    // 关系选择器数据源数组
    var shipDataSource: Array<HFChildrenRelationship> = []
     /// 加载宝宝关系列表
    static func loadChildrenRelationship(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) {

        HFSwiftService.requestData(requestType: .Get, urlString: HFPublicAPI.BabyRelationshipAPI, para: [:]) { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let response = Mapper<HFResponseArrayBaseModel<HFChildrenRelationship>>().map(JSON: dic as! [String : Any])
            if response?.model != nil {
                shared.allShips = response?.model ?? []
                shared.shipDataSource = shared.allShips
                successClosure()
            }else{
                
                failClosure()
            }
        } failured: { (error) in
            failClosure()
        }

    }
    
    // MARK：班级选择
    // 元组类型（班级选择数据数组，选择器数据数据源数组）
    static func classDataSource(grId: String) -> ([HFClassModel]?,[BRResultModel]?) {
        var models: [HFClassModel] = []
        var arr: [BRResultModel] = []
        for model in shared.allClass {
            if model.grId == grId {
                let resModel = BRResultModel.init()
                resModel.value = model.clName
                arr.append(resModel)
                models.append(model)
            }
        }
        return (models,arr)
    }
    
    // 班级索引数据
    private(set) var allClass: [HFClassModel] = []
    
    // 获取班级列表
    static func loadClassList(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {

        var parameters = [String: AnyObject]()
        parameters["kiId"] = kiId as AnyObject //幼儿园业务id

        HFSwiftService.requestData(requestType: .Get, urlString: HFKgMgrAPI.GetPublicClassesListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFClassModel>>().map(JSON: dic as! [String : Any] )

            shared.allClass = responseBaseModel?.model ?? []

            successClosure()
        }) { (error) in

            failClosure()
        }
    }
    
    
    // MARK：岗位选择
    // 元组类型（岗位选择数据数组，选择器数据数据源数组）
    static func jobsDataSource(osId: String) -> ([HFJobsModel]?,[BRResultModel]?) {
        let models: [HFJobsModel] = shared.cacheJobs["\(osId)"] ?? []
        var arr: [BRResultModel] = []
        for model in models {
            let resModel = BRResultModel.init()
            resModel.value = model.jobName
            arr.append(resModel)
        }
        return (models,arr)
    }
    
    // 岗位索引字典
    private var cacheJobs: [String:[HFJobsModel]] = [:]
    
    // 部门业务主键id
    var osId = "部门业务主键id"
    
    static func loadJobsList(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["osId"] = shared.osId as AnyObject //部门业务主键id
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFPublicAPI.JobsAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFJobsModel>>().map(JSON: dic as! [String : Any] )
            
            shared.cacheJobs[shared.osId] = responseBaseModel?.model
            
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    // MARK: 省市县
    // 省市县选择器数据源数组
    var regionDataSource: Array<BRResultModel> = []
    
    // 省市县区域索引字典
    var regionIndexDataDic: [String: HFRegionModel] = [:]
    
    /// 加载省市县数据
    static func loadRegionDataSource(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFPublicAPI.DistrictsAPI, para: [:], successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFRegionModel>>().map(JSON: dic as! [String : Any] )
            
            if responseBaseModel?.model != nil {
                
                self.handelRegionDataSource(regionModels: responseBaseModel!.model!)
                
                successClosure()
            }else{
                
                failClosure()
            }
            
        }) { (error) in
            failClosure()
        }
    }
    
    /// 处理省市县数据
    private static func handelRegionDataSource(regionModels: [HFRegionModel]) -> Void {
        
        if regionModels.count == 0 {
            return
        }
        
        shared.regionDataSource.removeAll()
        shared.regionIndexDataDic.removeAll()
        
        // 省
        for provinceModel in regionModels {
            let model = BRResultModel.init()
            model.parentKey = "-1"
            model.parentValue = ""
            model.key = provinceModel.diId
            model.value = provinceModel.diName
            shared.regionDataSource.append(model)
            
            shared.regionIndexDataDic[model.key!] = provinceModel
            
            // 市
            for cityModel in provinceModel.children {
                let model = BRResultModel.init()
                model.parentKey = provinceModel.diId
                model.parentValue = ""
                model.key = cityModel.diId
                model.value = cityModel.diName
                shared.regionDataSource.append(model)
                
                shared.regionIndexDataDic[model.key!] = cityModel
                
                // 县
                for countyModel in cityModel.children {
                    let model = BRResultModel.init()
                    model.parentKey = cityModel.diId
                    model.parentValue = ""
                    model.key = countyModel.diId
                    model.value = countyModel.diName
                    shared.regionDataSource.append(model)
                    
                    shared.regionIndexDataDic[model.key!] = countyModel
                }
            }
        }
    }
    
    
    // MARK: 公共字典选择
    // 元组类型（公共字典选择数据数组，选择器数据数据源数组）
    static func pubDictDataSource(type: HFSelectorPubType) -> ([HFDictionaryInfoModel]?,[BRResultModel]?) {
        let models: [HFDictionaryInfoModel] = shared.pubDictCache["\(type.rawValue)"] ?? []
        var arr: [BRResultModel] = []
        for model in models {
            let resModel = BRResultModel.init()
            if type == .Nation {
                resModel.value = model.naName
            }else{
                resModel.value = model.dicFieldName
            }
            arr.append(resModel)
        }
        return (models,arr)
    }
    
    // 公共字典数据集
    private var pubDictCache: [String:[HFDictionaryInfoModel]] = [:]
    
    static var pathDic:[String:String] = ["\(HFSelectorPubType.PropProperty.rawValue)" : "\(HFPublicAPI.PubDictAPI)/prop_property",
                                          "\(HFSelectorPubType.KgGrade.rawValue)" : "\(HFPublicAPI.PubDictAPI)/kg_grade",
                                          "\(HFSelectorPubType.KgPayWay.rawValue)" : "\(HFPublicAPI.PubDictAPI)/kg_pay_way",
                                          "\(HFSelectorPubType.KgType.rawValue)" : "\(HFPublicAPI.PubDictAPI)/kg_type",
                                          "\(HFSelectorPubType.KgNatureA.rawValue)" : "\(HFPublicAPI.PubDictAPI)/kg_nature_a",
                                          "\(HFSelectorPubType.KgNatureB.rawValue)" : "\(HFPublicAPI.PubDictAPI)/kg_nature_b",
                                          "\(HFSelectorPubType.KgNatureC.rawValue)" : "\(HFPublicAPI.PubDictAPI)/kg_nature_c",
                                          "\(HFSelectorPubType.Education.rawValue)" : "\(HFPublicAPI.PubDictAPI)/education",
                                          "\(HFSelectorPubType.Country.rawValue)" : "\(HFPublicAPI.PubDictAPI)/country",
                                          "\(HFSelectorPubType.Childrels.rawValue)" : HFPublicAPI.BabyRelationshipAPI,
                                          "\(HFSelectorPubType.BloodType.rawValue)" : "\(HFPublicAPI.PubDictAPI)/blood_type",
                                          "\(HFSelectorPubType.EmploymentTime.rawValue)" : "\(HFPublicAPI.PubDictAPI)/employment_time",
                                          "\(HFSelectorPubType.DocumentType.rawValue)" : "\(HFPublicAPI.PubDictAPI)/document_type",
                                          "\(HFSelectorPubType.Nation.rawValue)" : HFPublicAPI.NationalPublicListAPI,
                                          "\(HFSelectorPubType.BrotherSister.rawValue)":"\(HFPublicAPI.PubDictAPI)/brother_sister",]
    
    /// 家长公共字典信息
    static func loadPubDict(type: HFSelectorPubType ,_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        let urlPath: String = pathDic["\(type.rawValue)"] ?? ""
        HFSwiftService.requestData(requestType: .Get, urlString: urlPath, para: [:], successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFDictionaryInfoModel>>().map(JSON: dic as! [String : Any] )
            
            shared.pubDictCache["\(type.rawValue)"] = responseBaseModel?.model
            
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
}
