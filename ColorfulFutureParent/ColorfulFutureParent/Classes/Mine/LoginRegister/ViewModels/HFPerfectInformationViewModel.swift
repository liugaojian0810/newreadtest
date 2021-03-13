//
//  HFPerfectInformationViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by wzz on 2020/11/3.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPerfectInformationViewModel: NSObject {
    
    var perfectInformationArr = [AnyObject]()
    
    override init() {
        super.init()
        
        let model0 = HFFormTextInputCellModel.init()
        model0.title = "备注名"
        model0.placeholder = "请输入备注名"
        model0.serverKey = "diRemarkName"
        perfectInformationArr.append(model0)
        
        let model1 = HFFormTextInputCellModel.init()
        model1.title = "姓名（必填）"
        model1.placeholder = "请输入您的真实姓名"
        model1.serverKey = "usrFullName"
        perfectInformationArr.append(model1)
        
        let model2 = HFFormRadioBoxCellModel.init()
        model2.title = "性别（必填）"
        model2.leftRadioName = "女"
        model2.rightRadioName = "男"
        model2.serverKey = "usrSex"
        perfectInformationArr.append(model2)
        
        let model3 = HFFormSelectCellModel.init()
        model3.title = "出生日期（必填）"
        model3.placeholder = ""
        perfectInformationArr.append(model3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var parameters = [String: AnyObject]()
    
    ///保存园长详细信息
    func saveInfo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.ImproveUserInfoAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 用户信息
    var userInfo: HFAccountInfoModel?
    
    /// 获取园长完整个人信息
    func getFullUserInfo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.DirInfoAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            self.userInfo = HFAccountInfoModel(JSON: dic["model"] as! [String : Any])
            self.parameters = self.parameters.merging(dic["model"] as! [String : AnyObject]) { (current, _) in current }
            self.handleData()
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    func handleData() -> Void {
        for (index,item) in perfectInformationArr.enumerated() {
            if let radioBoxModel = item as? HFFormRadioBoxCellModel {
                // 性别
                if userInfo?.usrSex == 1 {
                    radioBoxModel.selectedIndex = 1
                }else if userInfo?.usrSex == 2 {
                    radioBoxModel.selectedIndex = 0
                }else{
                    radioBoxModel.selectedIndex = 0
                }
            }
            if let inputModel = item as? HFFormTextInputCellModel {
                if index == 0 && userInfo?.diRemarkName != "" {
                    // 备注名
                    inputModel.contentText = userInfo?.diRemarkName
                }
                if index == 1 && userInfo?.usrFullName != "" {
                    // 用户名
                    inputModel.contentText = userInfo?.usrFullName
                }
            }
            if let selectModel = item as? HFFormSelectCellModel {
                if index == 3 && userInfo?.usrBirthday != "" {
                    // 出生日期
                    selectModel.contentText = userInfo?.usrBirthday
                }
            }
        }
    }
}
