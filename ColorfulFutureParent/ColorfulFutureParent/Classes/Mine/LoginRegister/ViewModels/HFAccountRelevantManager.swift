//
//  HFAccountRelevantManager.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/12/29.
//  Copyright © 2020 huifan. All rights reserved.
//  

import UIKit
import ObjectMapper
import SwiftyJSON

class HFAccountRelevantManager {

    //单例创建
    static let shared = HFAccountRelevantManager()
    init() {}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var kinder: HFKinderInfomation?
    var employeeInfo: HFEmployeeInfomation?
    
    /// 查询教师用户信息
    func getEmployeInfo( _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        let parameters = [String : AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.UserPersonalInfoAPI, para: parameters) { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFEmployeeInfomation>>().map(JSON: dic as! [String : Any])
            self.employeeInfo = responseBaseModel?.model
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 查询当前教师所在幼儿园信息
    func getKinderInfo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure)  {
        let parameters = [String : AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.KingdInfoAPI, para: parameters) { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFKinderInfomation>>().map(JSON: dic as! [String : Any])
            self.kinder = responseBaseModel?.model
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    
    var userDataNameArr = ["消息中心", "我的钱包", "幼儿园招生二维码", "我的订单", "我的认证","设置"]
    
    var userDataIconArr = ["wd_icon_xiaoxizhongxin", "mine_Mypage_icon_rzzx", "mine_icon_saomiaoerweima", "mine_wd_icon_order", "mine_icon_renzheng", "icon-shezhi"]
    
}
