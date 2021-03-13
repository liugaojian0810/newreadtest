//
//  HFAppVersionModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

@objc class HFAppVersionModel: NSObject,Mappable {
    
   /**
     {
         "versionCode":"", // 版本号
         "versionSn":0, // 版本序号
         "attach":"", // 附件
         "attachSize":0, // 附件大小
         "attachType":0, // 附件类型1:跳转应用商城，2：跳转下载链接地址3：跳转file
         "versionRemark":"", // 版本说明
         "terminalPlatform":0, // 终端平台(1Android 2ios)
         "productPlatform":0, // 产品平台(1家长端APP2园长端APP3教师APP端4家长端机器人)
         "updateStatus":0, // 是否强制更新，0不强制  ，1强制
     }
     */
    
    @objc var attach: String = ""
    @objc var productPlatform: Int = 0
    @objc var attachSize: Int = 0
    @objc var updateStatus: Int = 0
    @objc var versionSn: Int = 0
    @objc var attachType: Int = 0
    @objc var versionRemark: String = ""
    @objc var terminalPlatform: Int = 0
    @objc var versionCode: String = ""

    
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapping(map: Map) {
        
        attach <- map["attach"]
        productPlatform <- map["productPlatform"]
        attachSize <- map["attachSize"]
        updateStatus <- map["updateStatus"]
        versionSn <- map["versionSn"]
        attachType <- map["attachType"]
        versionRemark <- map["versionRemark"]
        terminalPlatform <- map["terminalPlatform"]
        versionCode <- map["versionCode"]

    }
}

class HFAccountSecurInfoModel: Mappable {
    
   /**
     {
         "usrId":"bu2020081700000120", // 用户ID
         "usrPhone":"15210090000", // 手机号
         "usrPwdLevel":1, // 密码安全等级 0低 1中 2高
         "weixinBindStatus":1 // 微信绑定状态 1已绑定 0未绑定
     }
     */
    
    var usrId: String = ""
    var usrPhone: String = ""
    var weixinBindStatus: Int = 0
    var usrPwdLevel: Int = 0
    var usrName: String = ""
    var usrUsrNameChange: Int = 0

    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        usrId <- map["usrId"]
        usrPhone <- map["usrPhone"]
        weixinBindStatus <- map["weixinBindStatus"]
        usrPwdLevel <- map["usrPwdLevel"]
        usrName <- map["usrName"]
        usrUsrNameChange <- map["usrUsrNameChange"]
    }
}




