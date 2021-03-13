//
//  HFUserInfoModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/14.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFUserInfoModel : Mappable {
    
    var mlName: String = ""
    var piId: String = ""
    var piRmkName: String = ""
    var isYjy: Int = 0
    var mlId: String = ""
    var headImg: String = ""
    var usrPhone: String = ""
    var usrAuthStatus: Int = 0
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mlName    <- map["mlName"]
        piId    <- map["piId"]
        piRmkName    <- map["piRmkName"]
        isYjy    <- map["isYjy"]
        mlId    <- map["mlId"]
        headImg    <- map["headImg"]
        usrPhone    <- map["usrPhone"]
        usrAuthStatus    <- map["usrAuthStatus"]
        usrId    <- map["usrId"]
    }
}


class HFPersonCenterModel : Mappable {
    
    var usrSex: Int = 0
    var usrFullName: String = ""
    var cprRelp: String = ""
    var piId: String = ""
    var piRmkName: String = ""
    var dicFieldName: String = ""
    var headImg: String = ""
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        usrSex    <- map["usrSex"]
        usrFullName    <- map["usrFullName"]
        cprRelp    <- map["cprRelp"]
        piId    <- map["piId"]
        piRmkName    <- map["piRmkName"]
        dicFieldName    <- map["dicFieldName"]
        headImg    <- map["headImg"]
        usrId    <- map["usrId"]
    }
    
}
