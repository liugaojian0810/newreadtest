//
//  HFSelectorTools.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/1.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation


// MARK: 公共字典选择
@objc enum HFSelectorPubType: Int {
    case PropProperty = 0 // 房产属性集合查询
    case KgGrade // 幼儿园档次类型
    case KgPayWay // 幼儿园租赁方式
    case KgType // 幼儿园类型
    case KgNatureA // 办园性质-经营性质
    case KgNatureB // 办园性质-惠普性质
    case KgNatureC // 办园性质-盈利性质
    case Education // 学历字典表查询
    case Country // 国籍字典
    case Childrels // 宝宝关系
    case BloodType // 血型字典数据
    case EmploymentTime // 从业年限数据字典
    case DocumentType // 证件类型数据字典
    case Nation // 民族
    case Area // 地区
    case BrotherSister // 宝宝与兄弟姐妹的关联关系
}



class HFSelectorTools: NSObject {
    
    // MARK: 样式配置
    /// 获取选择器公共样式
    static func getCustomStyle() -> BRPickerStyle {
        let customStyle = BRPickerStyle.init()
        customStyle.separatorColor = .colorSeperLine()
        customStyle.pickerTextFont = .systemFont(ofSize: 14)
        customStyle.selectRowTextFont = .systemFont(ofSize: 16)
        customStyle.doneTextColor = .hexColor(0xFF844B)
        customStyle.doneTextFont = .systemFont(ofSize: 16)
        customStyle.cancelTextColor = .hexColor(0xC0C0C0)
        customStyle.cancelTextFont = .systemFont(ofSize: 16)
        customStyle.rowHeight = 51
        customStyle.pickerHeight = 155
        customStyle.titleBarHeight = 52
        
        var cancelBtnFrame = customStyle.cancelBtnFrame
        cancelBtnFrame.origin.y = 0
        cancelBtnFrame.size.height = customStyle.titleBarHeight
        customStyle.cancelBtnFrame = cancelBtnFrame
        
        var doneBtnFrame = customStyle.doneBtnFrame
        doneBtnFrame.origin.y = 0
        doneBtnFrame.size.height = customStyle.titleBarHeight
        customStyle.doneBtnFrame = doneBtnFrame
        
        customStyle.titleLineColor = .colorSeperLine()
        customStyle.topCornerRadius = 12
        
        return customStyle
    }
    
    
    // MARK: 公共部门(弃用)
    /// 选择部门
    /// - Parameters:
    ///   - refresh: 本地有数据情况下是否刷新数据
    ///   - selectComplete: 选择完成回调
    /// - Returns: 无返回值
    static func selectorDepartment(refresh: Bool, _ selectComplete: @escaping (_ departments: [HFDepartmentModel]) -> ()) -> Void {
        
        var dataSource = HFSelectorDataManage.shared.departmentDataSource
        
        /// 选择部门执行展示
        func showDepartment() -> Void {
            
            if dataSource.count == 0 {
                return
            }
            
            let pickerView = BRStringPickerView.init()
            pickerView.pickerMode = .componentLinkage
            pickerView.dataSourceArr = dataSource
            pickerView.resultModelArrayBlock = { resultModelArr in
                var res: [HFDepartmentModel] = []
                for item in resultModelArr! {
                    let model = item as BRResultModel
                    if model.value != " " {
                        res.append(HFSelectorDataManage.shared.departmentIndexDataDic[model.key!]!)
                    }
                }
                selectComplete(res)
            }
            
            pickerView.pickerStyle = getCustomStyle()
            
            pickerView.show()
        }
        
        if dataSource.count == 0 || refresh {
            ShowHUD.showHUDLoading()
            HFSelectorDataManage.loadDepartmentDataSource ({
                ShowHUD.hiddenHUDLoading()
                
                dataSource = HFSelectorDataManage.shared.departmentDataSource
                showDepartment()
            }) {
                ShowHUD.hiddenHUDLoading()
            }
        }else{
            showDepartment()
        }
    }
    
    
    // MARK: 公共年级（已开启的年级）
    /// 选择年级
    /// - Parameters:
    ///   - refresh: 本地有数据情况下是否刷新数据
    ///   - selectComplete: 选择完成回调
    /// - Returns: 无返回值
//    static func selectorGrade(refresh: Bool, _ selectComplete: @escaping (_ gradeModel: HFGradeModel) -> ()) -> Void {
//
//        var dataSource = HFSelectorDataManage.gradeDataSource
//
//        /// 选择年级执行展示
//        func showGrade() -> Void {
//
//            if dataSource.0?.count == 0 {
//                return
//            }
//
//            let pickerView = BRStringPickerView.init()
//            pickerView.pickerMode = .componentSingle
//            pickerView.dataSourceArr = dataSource.1
//            pickerView.resultModelBlock = { resultModel in
//                let models: [HFGradeModel] = dataSource.0!
//                selectComplete(models[resultModel!.index])
//            }
//
//            pickerView.pickerStyle = getCustomStyle()
//
//            pickerView.show()
//        }
//
//        if dataSource.0?.count == 0 || refresh {
//            ShowHUD.showHUDLoading()
//            HFSelectorDataManage.loadGradeList ({
//                ShowHUD.hiddenHUDLoading()
//
//                dataSource = HFSelectorDataManage.gradeDataSource
//                showGrade()
//            }) {
//                ShowHUD.hiddenHUDLoading()
//            }
//        }else{
//            showGrade()
//        }
//    }
    
    
    
    // MARK: 班级选择
    /// 选择班级
    /// - Parameters:
    ///   - grId: 年级业务id
    ///   - refresh: 本地有数据情况下是否刷新数据
    ///   - selectComplete: 选择完成回调
    /// - Returns: 无返回值
//    static func selectorClass(grId: String, refresh: Bool, _ selectComplete: @escaping (_ classModel: HFClassModel) -> ()) -> Void {
//
//        if grId.isEmpty {
//            return
//        }
//
//        var dataSource = HFSelectorDataManage.classDataSource(grId: grId)
//
//        /// 选择班级执行展示
//        func showGrade() -> Void {
//
//            if dataSource.0?.count == 0 {
//                return
//            }
//
//            let pickerView = BRStringPickerView.init()
//            pickerView.pickerMode = .componentSingle
//            pickerView.dataSourceArr = dataSource.1
//            pickerView.resultModelBlock = { resultModel in
//                let models: [HFClassModel] = dataSource.0!
//                selectComplete(models[resultModel!.index])
//            }
//
//            pickerView.pickerStyle = getCustomStyle()
//
//            pickerView.show()
//        }
//
//        if dataSource.0?.count == 0 || refresh {
//            ShowHUD.showHUDLoading()
//            HFSelectorDataManage.loadClassList ({
//                ShowHUD.hiddenHUDLoading()
//
//                dataSource = HFSelectorDataManage.classDataSource(grId: grId)
//                showGrade()
//            }) {
//                ShowHUD.hiddenHUDLoading()
//            }
//        }else{
//            showGrade()
//        }
//    }
    
    /// 选择班级（第一个元素为幼儿园信息，用于邀请教师，宝宝）
//    static func selectorClass(refresh: Bool, _ selectComplete: @escaping (_ classModel: HFClassModel?) -> ()) -> Void {
//
//        var allClass = HFSelectorDataManage.shared.allClass
//
//        /// 选择班级执行展示
//        func showClass() -> Void {
//
//            if allClass.count == 0 {
//                return
//            }
//
//            var models: [BRResultModel] = []
//
//            let kindergartenModel = BRResultModel.init()
////            kindergartenModel.value = HFKindergartenViewModel.shared.curKinderg?.kiName
//            models.append(kindergartenModel)
//
//            for model in HFSelectorDataManage.shared.allClass {
//                let resModel = BRResultModel.init()
//                resModel.value = model.kgrRemarkName + (model.kgrRemarkName.isEmptyStr() ? "" : "-") + model.clName
//                models.append(resModel)
//            }
//
//            let pickerView = BRStringPickerView.init()
//            pickerView.pickerMode = .componentSingle
//            pickerView.dataSourceArr = models
//            pickerView.resultModelBlock = { resultModel in
//                if resultModel?.index == 0 {
//                    selectComplete(nil)
//                }else{
//                    let models: [HFClassModel] = allClass
//                    selectComplete(models[resultModel!.index - 1])
//                }
//            }
//
//            pickerView.pickerStyle = getCustomStyle()
//
//            pickerView.show()
//        }
//
//        if allClass.count == 0 || refresh {
//            ShowHUD.showHUDLoading()
//            HFSelectorDataManage.loadClassList ({
//                ShowHUD.hiddenHUDLoading()
//
//                allClass = HFSelectorDataManage.shared.allClass
//                showClass()
//            }) {
//                ShowHUD.hiddenHUDLoading()
//            }
//        }else{
//            showClass()
//        }
//    }
    
    
    // MARK: 岗位选择
    /// 选择岗位
    /// - Parameters:
    ///   - osId: 部门业务主键id
    ///   - refresh: 本地有数据情况下是否刷新数据
    ///   - selectComplete: 选择完成回调
    /// - Returns: 无返回值
    static func selectorJobs(osId: String, refresh: Bool, _ selectComplete: @escaping (_ jobsModel: HFJobsModel) -> ()) -> Void {
        
        if osId.isEmpty {
            return
        }
        
        var dataSource = HFSelectorDataManage.jobsDataSource(osId: osId)
        
        /// 选择岗位执行展示
        func showJobs() -> Void {
            
            if dataSource.0?.count == 0 {
                return
            }
            
            let pickerView = BRStringPickerView.init()
            pickerView.pickerMode = .componentSingle
            pickerView.dataSourceArr = dataSource.1
            pickerView.resultModelBlock = { resultModel in
                let models: [HFJobsModel] = dataSource.0!
                selectComplete(models[resultModel!.index])
            }
            
            pickerView.pickerStyle = getCustomStyle()
            
            pickerView.show()
        }
        
        if dataSource.0?.count == 0 || refresh {
            ShowHUD.showHUDLoading()
            HFSelectorDataManage.shared.osId = osId
            HFSelectorDataManage.loadJobsList ({
                ShowHUD.hiddenHUDLoading()
                
                dataSource = HFSelectorDataManage.jobsDataSource(osId: osId)
                showJobs()
            }) {
                ShowHUD.hiddenHUDLoading()
            }
        }else{
            showJobs()
        }
    }
    
    
    // MARK: 省市县
    /// 选择省市县
    /// - Parameters:
    ///   - refresh: 本地有数据情况下是否刷新数据
    ///   - level: 行政区级别1-省，2-省市，3-省市县
    ///   - selectComplete: 选择完成回调
    /// - Returns: 无返回值
    @objc static func selectorRegion(refresh: Bool, level: Int , _ selectComplete: @escaping (_ regionModel: [HFRegionModel]) -> ()) -> Void {
        
        var level = level
        if level <= 0 {
            level = 1
        }
        if level > 3 {
            level = 3
        }
        
        var dataSource = HFSelectorDataManage.shared.regionDataSource
        
        /// 选择省市县执行展示
        func showRegion() -> Void {
            
            if dataSource.count == 0 {
                return
            }
            
            let pickerView = BRStringPickerView.init()
            pickerView.pickerMode = .componentLinkage
            pickerView.dataSourceArr = dataSource
            pickerView.numberOfComponents = level
            pickerView.resultModelArrayBlock = { resultModelArr in
                var res: [HFRegionModel] = []
                for item in resultModelArr! {
                    let model = item as BRResultModel
                    if model.value != " " {
                        res.append(HFSelectorDataManage.shared.regionIndexDataDic[model.key!]!)
                    }
                }
                selectComplete(res)
            }
            
            pickerView.pickerStyle = getCustomStyle()
            
            pickerView.show()
        }
        
        if dataSource.count == 0 || refresh {
            ShowHUD.showHUDLoading()
            HFSelectorDataManage.loadRegionDataSource ({
                ShowHUD.hiddenHUDLoading()
                
                dataSource = HFSelectorDataManage.shared.regionDataSource
                showRegion()
            }) {
                ShowHUD.hiddenHUDLoading()
            }
        }else{
            showRegion()
        }
    }
    
     // MARK: 选择孩子和父母关系
    static func selectorChildernShip( _ selectComplete: @escaping (_ gradeModel: HFChildrenRelationship) -> ()) {

        var dataSource = HFSelectorDataManage.classDataSource()

        func showRegion() -> Void {

            if dataSource.0?.count == 0 {
                return
            }
            let pickerView = BRStringPickerView.init()
            pickerView.pickerMode = .componentSingle
            pickerView.dataSourceArr = dataSource.1
            pickerView.resultModelBlock = { resultModel in
                let models: [HFChildrenRelationship] = dataSource.0!
                selectComplete(models[resultModel!.index])
            }

            pickerView.pickerStyle = getCustomStyle()

            pickerView.show()
        }
        
        if dataSource.0?.count == 0 {
            ShowHUD.showHUDLoading()
            HFSelectorDataManage.loadChildrenRelationship {
                ShowHUD.hiddenHUDLoading()
                dataSource = HFSelectorDataManage.classDataSource()
                showRegion()
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
        }else{
            showRegion()
        }
    }
    
    // MARK: 公共字典选择
    @objc static func selectorPubDict(type: HFSelectorPubType, refresh: Bool, _ selectComplete: @escaping (_ model: HFDictionaryInfoModel) -> ()) -> Void {
        
        var dataSource = HFSelectorDataManage.pubDictDataSource(type: type)
        
        /// 选择公共字典信息执行展示
        func showPubDict() -> Void {
            
            if dataSource.0?.count == 0 {
                return
            }
            
            let pickerView = BRStringPickerView.init()
            pickerView.pickerMode = .componentSingle
            pickerView.dataSourceArr = dataSource.1
            pickerView.resultModelBlock = { resultModel in
                let models: [HFDictionaryInfoModel] = dataSource.0!
                selectComplete(models[resultModel!.index])
            }
            
            pickerView.pickerStyle = getCustomStyle()
            
            pickerView.show()
        }
        
        if dataSource.0?.count == 0 || refresh {
            ShowHUD.showHUDLoading()
            HFSelectorDataManage.loadPubDict(type: type, {
                ShowHUD.hiddenHUDLoading()
                
                dataSource = HFSelectorDataManage.pubDictDataSource(type: type)
                showPubDict()
            }) {
                ShowHUD.hiddenHUDLoading()
            }
        }else{
            showPubDict()
        }
    }
    
}

// 日期、时间
extension HFSelectorTools {
    
    // MARK: 选择YMD格式日期
    @objc static func selectorYMD(_ selectComplete: @escaping (_ data: Date, _ value: String) -> ()) ->Void {
        self.selectorYMD(minDateIsToDay: false, selectComplete)
    }
    
    @objc static func selectorYMD(maxDateIsToDay: Bool, _ selectComplete: @escaping (_ data: Date, _ value: String) -> ()) ->Void {
        let datePickerView = BRDatePickerView.init()
        datePickerView.pickerMode = .YMD
        if maxDateIsToDay {
            datePickerView.maxDate = Date.init()
        }
        datePickerView.selectDate = Date.init()
        datePickerView.resultBlock = { selectDate, selectValue in
            selectComplete(selectDate!,selectValue!)
        }
        datePickerView.pickerStyle = HFSelectorTools.getCustomStyle()
        datePickerView.show()
    }
    
    @objc static func selectorYMD(minDateIsToDay: Bool, _ selectComplete: @escaping (_ data: Date, _ value: String) -> ()) ->Void {
        let datePickerView = BRDatePickerView.init()
        datePickerView.pickerMode = .YMD
        if minDateIsToDay {
            datePickerView.minDate = Date.init()
        }
        datePickerView.selectDate = Date.init()
        datePickerView.resultBlock = { selectDate, selectValue in
            selectComplete(selectDate!,selectValue!)
        }
        datePickerView.pickerStyle = HFSelectorTools.getCustomStyle()
        datePickerView.show()
    }
    
    // MARK: 选择HM格式时间
    @objc static func selectorHM(_ selectComplete: @escaping (_ data: Date, _ value: String) -> ()) ->Void {
        let datePickerView = BRDatePickerView.init()
        datePickerView.pickerMode = .HM
        datePickerView.selectDate = Date.init()
        datePickerView.resultBlock = { selectDate, selectValue in
            selectComplete(selectDate!,selectValue!)
        }
        datePickerView.pickerStyle = HFSelectorTools.getCustomStyle()
        datePickerView.show()
    }
}

public protocol HFSelectorToolsProtocol {
    var selectorToolTitleValue: String {get}
}

extension HFSelectorTools {
    // 传入字符数组
    static func selectorItem(_ dataSource:[String], _ selectComplete: @escaping (_ selectIndex: Int) -> ()) ->Void {
        let pickerView = BRStringPickerView.init()
        pickerView.pickerMode = .componentSingle
        pickerView.dataSourceArr = dataSource
        pickerView.resultModelBlock = { resultModel in
            selectComplete(resultModel!.index)
        }
        
        pickerView.pickerStyle = getCustomStyle()
        
        pickerView.show()
    }
    
    // 传入遵循HFSelectorToolsProtocol协议的数组
    static func selectorItem<T: HFSelectorToolsProtocol>(_ dataSource:[T], _ selectComplete: @escaping (_ selectIndex: Int) -> ()) ->Void {
        var values: [String] = []
        for item in dataSource {
            values.append(item.selectorToolTitleValue)
        }
        HFSelectorTools.selectorItem(values, selectComplete)
    }
}
