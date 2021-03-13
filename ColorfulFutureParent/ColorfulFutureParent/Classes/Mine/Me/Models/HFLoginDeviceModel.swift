//
//  HFLoginDeviceModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFLoginDeviceModel : Mappable {
    
    /**
     {
                     "ullId":"ul2020081700000120", // 记录ID
                     "ullDeviceName":"IPhone7Plus", // 设备名称
                     "ullDeviceNo":"xxxxxxx", // 设备唯一编号
                     "ucClientType":"园长端", // 客户端类型：园长端，教师端，家长端，慧凡saas，幼儿园saas
                     "loginTime":"2020-11-10 10:24:00", // 登录时间
                     "loginOutTime":"2020-11-10 10:55:36",// 退出登录时间
     }
     */
    
    var ullId: String = ""
    var loginTime: String = ""
    var loginOutTime: String = ""
    var ullDeviceName: String = ""
    var ullDeviceType: String = ""
    var ullDeviceNo: String = ""
    var ucClientType: String = ""
    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ullId    <- map["ullId"]
        loginTime    <- map["loginTime"]
        loginOutTime    <- map["loginOutTime"]
        ullDeviceName    <- map["ullDeviceName"]
        ullDeviceType <- map["ullDeviceType"]
        ullDeviceNo    <- map["ullDeviceNo"]
        ucClientType    <- map["ucClientType"]
    }
    
}
