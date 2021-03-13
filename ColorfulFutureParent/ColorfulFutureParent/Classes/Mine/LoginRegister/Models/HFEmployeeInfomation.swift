//
//  HFEmployeeInfomation.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/12/29.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFEmployeeInfomation : Mappable {
    /**
     {
             "usrName":""  // 用户名（可用于登录）
             "usrNo":""  // 用户编号（前端显示的用户ID）
             "usrPwdLevel":""  // 密码等级0低1中2高
             "usrFullName":""  // 姓名
             "usrSex":""  // 性别0未知1男2女
             "usrPhone":""  // 手机号
             "usrBirthday":"" // 出生日期
             "uaiIdCard":""  // 身份证号
             "usrAuthStatus":""  // 是否实名认证0否1是
             "usrRegisterStatus":""  // 注册状态0未注册1已注册
             "usrRegisterTime":""  // 注册时间
             "usrUsrNameChange":""  // 是否允许更用户名0否1是
             "usrNeedChangePwd":""  // 是否需要强制修改密码0否1是
             "enableStatus":""  // 是否启用0否1是
         }
     */
    var usrRegisterStatus: String = ""
    var usrSex: Int = 0
    var usrAuthStatus: String = ""
    var usrPwdLevel: String = ""
    var usrBirthday: String = ""
    var usrNo: String = ""
    var usrPhone: String = ""
    var usrNeedChangePwd: String = ""
    var usrName: String = ""
    var enableStatus: String = ""
    var uaiIdCard: String = ""
    var usrUsrNameChange: Int = 0
    var usrFullName: String = ""
    var usrRegisterTime: String = ""
    var usrId: String = ""
    var headImg: String = ""
    var mainClassTeacher: Int = 0
    var percentage: String = ""
    var eiRmkName: String = ""
    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        usrRegisterStatus    <- map["usrRegisterStatus"]
        usrSex    <- map["usrSex"]
        usrAuthStatus    <- map["usrAuthStatus"]
        usrPwdLevel    <- map["usrPwdLevel"]
        usrBirthday    <- map["usrBirthday"]
        usrNo    <- map["usrNo"]
        usrPhone    <- map["usrPhone"]
        usrNeedChangePwd    <- map["usrNeedChangePwd"]
        usrName    <- map["usrName"]
        enableStatus    <- map["enableStatus"]
        uaiIdCard    <- map["uaiIdCard"]
        usrUsrNameChange    <- map["usrUsrNameChange"]
        usrFullName    <- map["usrFullName"]
        usrRegisterTime    <- map["usrRegisterTime"]
        usrId    <- map["usrId"]
        headImg    <- map["headImg"]
        mainClassTeacher    <- map["mainClassTeacher"]
        percentage    <- map["percentage"]
        eiRmkName    <- map["eiRmkName"]
    }
    
}
