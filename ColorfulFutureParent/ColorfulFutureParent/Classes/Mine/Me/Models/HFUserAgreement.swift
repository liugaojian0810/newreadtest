//
//  HFUserAgreement.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFUserAgreement : Mappable {
    
    var agreeVersion: Int = 0
    var gmtCreate: String = ""
    var Id: Int = 0
    var agreeUrl: String = ""
    var clientType: Int = 0
    var agreeName: String = ""
    var gmtModified: String = ""
    var isDelete: Int = 0
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        agreeVersion  <- map["agreeVersion"]
        gmtCreate    <- map["gmtCreate"]
        Id    <- map["id"]
        agreeUrl    <- map["agreeUrl"]
        clientType    <- map["clientType"]
        agreeName    <- map["agreeName"]
        gmtModified    <- map["gmtModified"]
        isDelete    <- map["isDelete"]
    }
}
