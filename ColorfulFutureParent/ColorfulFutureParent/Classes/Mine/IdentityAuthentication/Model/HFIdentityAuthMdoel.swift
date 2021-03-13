//
//  HFIdentityAuthMdoel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by HUIFAN on 2021/1/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

struct HFAuthCancelInfoModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        usrPhone <- map["usrPhone"]
        cancelDate <- map["cancelDate"]
        restCancelDate <- map["restCancelDate"]
        clientType <- map["clientType"]
    }
    
    var usrPhone: String = ""
    var cancelDate: Int = 0
    var restCancelDate: Int = 0
    var clientType: String = ""
    
    
}

class HFIdentityAuthMdoel: Mappable {
    var uaiId: String?
    var uaiIdCard: String?
    var uaiAuthority: String?
    var authenticationStatus: String?
    var uaiValidity: String?
    var uaiPhoto: String?
    var uaiRealName: String?
    var usrId: String?


    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        uaiId <- map["uaiId"]
        uaiIdCard <- map["uaiIdCard"]
        uaiAuthority <- map["uaiAuthority"]
        authenticationStatus <- map["authenticationStatus"]
        uaiValidity <- map["uaiValidity"]
        uaiPhoto <- map["uaiPhoto"]
        uaiRealName <- map["uaiRealName"]
        usrId <- map["usrId"]

    }
    

}
