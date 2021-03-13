//
//  HFBabyParentModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/21.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFBabyParentModel : Mappable {
    
    /**
     参数名    类型    说明
     piId    String    家长业务ID
     naName    String    民族名称
     piWorkPlace    String    工作单位
     piVocation    String    职业
     usrFullName    String    家长姓名
     usrPhone    String    手机号
     usrBirthday    String    出生日期
     cprDef    Integer    是否是第一联系人 0否 1是
     cprRelp    String    家长与宝宝关系（字典表业务id)
     dicFieldName    String    家长与宝宝关系
     */
    var naName: String = ""
    var usrFullName: String = ""
    var cprRelp: String = ""
    var cprDef: String = ""
    var piId: String = ""
    var piVocation: String = ""
    var dicFieldName: String = ""
    var piWorkPlace: String = ""
    var usrPhone: String = ""
    var usrBirthday: String = ""
    var headImg: String = ""
    var usrSex: Int = 2

    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        naName    <- map["naName"]
        usrFullName    <- map["usrFullName"]
        cprRelp    <- map["cprRelp"]
        cprDef    <- map["cprDef"]
        piId    <- map["piId"]
        piVocation    <- map["piVocation"]
        dicFieldName    <- map["dicFieldName"]
        piWorkPlace    <- map["piWorkPlace"]
        usrPhone    <- map["usrPhone"]
        usrBirthday    <- map["usrBirthday"]
        usrSex    <- map["usrSex"]
        headImg    <- map["headImg"]
    }
    
}
