//
//  HFBabyJoinViewModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class HFBabyJoinViewModel: NSObject {
    
    // 等待加入新学校的宝宝
    var waitBabyModel: HFBabyModel? {
        didSet {
            
            if waitBabyModel != nil {
                
                dataArr.removeAll()
                
                var parentInfoArr: [AnyObject] = []
                
                let model0 = HFFormTextInputCellModel.init()
                model0.title = "家长姓名"
                model0.placeholder = "请填写"
                model0.remarkKey = "usrFullName"
                model0.contentText = HFUserInformation.userInfo()?.usrFullName
                model0.onlyShow = true
                parentInfoArr.append(model0)
                
                let model1 = HFFormTextInputCellModel.init()
                model1.title = "与宝宝关系"
                model1.placeholder = "请选择"
                model1.remarkKey = "cprRelp"
                model1.contentText = waitBabyModel?.dicFieldName
                model1.onlyShow = true
                parentInfoArr.append(model1)
                
                let model2 = HFFormTextInputCellModel.init()
                model2.title = "手机号"
                model2.placeholder = "请填写"
                model2.remarkKey = "usrPhone"
                model2.maxLength = 11
                model2.onlyShow = true
                model2.contentText = HFUserInformation.userInfo()?.usrPhone
                parentInfoArr.append(model2)
                
                let model3 = HFFormTextInputCellModel.init()
                model3.title = "性别"
                model3.placeholder = "请选择"
                model3.remarkKey = "usrSex"
                model3.onlyShow = true
                model3.contentText = HFUserInformation.userInfo()?.ciSexDesc
                parentInfoArr.append(model3)
                
                dataArr.append(parentInfoArr)
                
                
                var babyInfoArr: [AnyObject] = []
                
                let model10 = HFFormTextInputCellModel.init()
                model10.title = "宝宝姓名"
                model10.placeholder = "请填写"
                model10.remarkKey = "ciName"
                model10.contentText = waitBabyModel?.ciName
                model10.onlyShow = true
                babyInfoArr.append(model10)
                
                let model11 = HFFormTextInputCellModel.init()
                model11.title = "出生日期"
                model11.placeholder = "请选择"
                model11.remarkKey = "ciBirth"
                model11.contentText = waitBabyModel?.ciBirth
                model11.onlyShow = true
                babyInfoArr.append(model11)
                
                if waitBabyModel!.ciSex == 0 {
                    waitBabyModel!.ciSex = 2
                }
                let model12 = HFFormTextInputCellModel.init()
                model12.title = "宝宝性别"
                model12.placeholder = "请选择"
                model12.remarkKey = "ciSex"
                model12.contentText = waitBabyModel?.ciSexDesc
                model12.onlyShow = true
                babyInfoArr.append(model12)
                
                let model13 = HFFormSelectCellModel.init()
                model13.title = "宝宝状态"
                model13.placeholder = "请选择"
                model13.remarkKey = "ciComeStatus"
                
                if waitBabyModel!.ciComeStatus == 0 {
                    model13.contentText = "新入园宝宝"
                }else{
                    model13.contentText = "已在园宝宝"
                }
                
                babyInfoArr.append(model13)
                
                dataArr.append(babyInfoArr)
            }
        }
    }
    
    var addBabyDataModel: HFAddBabyDataModel?
    
    var dataArr: [[AnyObject]] = []
    
    override init() {
        super.init()
        
        var parentInfoArr: [AnyObject] = []
        
        let model0 = HFFormTextInputCellModel.init()
        model0.title = "家长姓名"
        model0.placeholder = "请填写"
        model0.remarkKey = "usrFullName"
        model0.contentText = HFUserInformation.userInfo()?.usrFullName
        model0.onlyShow = true
        parentInfoArr.append(model0)
        
        let model1 = HFFormSelectCellModel.init()
        model1.title = "与宝宝关系"
        model1.placeholder = "请选择"
        model1.remarkKey = "cprRelp"
        parentInfoArr.append(model1)
        
        let model2 = HFFormTextInputCellModel.init()
        model2.title = "手机号"
        model2.placeholder = "请填写"
        model2.remarkKey = "usrPhone"
        model2.maxLength = 11
        model2.onlyShow = true
        model2.contentText = HFUserInformation.userInfo()?.usrPhone
        parentInfoArr.append(model2)
        
        let model3 = HFFormTextInputCellModel.init()
        model3.title = "性别"
        model3.placeholder = "请选择"
        model3.remarkKey = "usrSex"
        model3.onlyShow = true
        model3.contentText = HFUserInformation.userInfo()?.ciSexDesc
        parentInfoArr.append(model3)
        
        dataArr.append(parentInfoArr)
        
        
        var babyInfoArr: [AnyObject] = []
        
        let model10 = HFFormTextInputCellModel.init()
        model10.title = "宝宝姓名"
        model10.placeholder = "请填写"
        model10.remarkKey = "ciName"
        babyInfoArr.append(model10)
        
        let model11 = HFFormSelectCellModel.init()
        model11.title = "出生日期"
        model11.placeholder = "请选择"
        model11.remarkKey = "ciBirth"
        babyInfoArr.append(model11)
        
        let model12 = HFFormSelectCellModel.init()
        model12.title = "宝宝性别"
        model12.placeholder = "请选择"
        model12.remarkKey = "ciSex"
        babyInfoArr.append(model12)
        
        let model13 = HFFormSelectCellModel.init()
        model13.title = "宝宝状态"
        model13.placeholder = "请选择"
        model13.remarkKey = "ciComeStatus"
        babyInfoArr.append(model13)
        
        dataArr.append(babyInfoArr)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 选择的宝宝关系
    var relationModel: HFDictionaryInfoModel?
    // 选择的年级
    var selectGradeModel: HFGradeModel?
    // 选择的班级
    var selectClassModel: HFClassModel?
    
    /// 加入幼儿园
    /// - Parameters:
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func parentJoinKg(successClosure: @escaping ()->(), failClosure: @escaping ()->()) -> Void {
        let userInfo = HFUserInformation.userInfo()
        addBabyDataModel?.usrFullName = userInfo?.usrFullName ?? ""
        addBabyDataModel?.usrPhone = userInfo?.usrPhone ?? ""
        addBabyDataModel?.usrSex = userInfo?.usrSex ?? 0
        addBabyDataModel?.functionTypes = 2
        var parameters: [String : AnyObject] = addBabyDataModel?.toJSON() as! [String : AnyObject]
        if waitBabyModel != nil {
            parameters["ciId"] = waitBabyModel?.ciId as AnyObject
            
        }
        parameters["kiId"] = invitationInfoModel?.kiId as AnyObject
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AddChildAPI, para: parameters, successed: { (response) in
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 年级班级编辑状态： 0、新增 1、不变 2、修改
    var cgType = 1
    
    /// 编辑宝宝
    /// - Parameters:
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func editChild(successClosure: @escaping ()->(), failClosure: @escaping ()->()) -> Void {
        var parameters:[String:AnyObject] = addBabyDataModel?.toJSON() as! [String : AnyObject]
        parameters["type"] = cgType as AnyObject
        
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.ChildPrtlInfoAPI, para: parameters, successed: { (response) in
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    // 邀请码
    var invitationCode = ""
    
    // 邀请信息数据模型
    var invitationInfoModel: HFInvitationInfoModel?
    
    /// 是否选择年级，默认为可以选择
    var allowSelectGrade = true
    /// 是否允许选择班级，默认为可以选择
    var allowSelectClass = true
    
    /// 根据邀请码查询幼儿园信息
    func getInvitationInfo(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        var parameters = [String: AnyObject]()
        
        parameters["invitationCode"] = invitationCode as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFKgMgrAPI.GetInvitationInfoAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            if (dic["model"] as? [String:AnyObject]) != nil {
                self.invitationInfoModel = Mapper<HFInvitationInfoModel>().map(JSON: dic["model"] as! [String : Any] )
            }
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
}
