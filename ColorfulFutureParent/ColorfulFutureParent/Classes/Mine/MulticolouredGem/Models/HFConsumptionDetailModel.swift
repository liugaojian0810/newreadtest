//
//  HFConsumptionDetailModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//  消费明细

import UIKit
import ObjectMapper


class HFConsumptionDetailModel : Mappable {
    /**
     "galId": "GAL202102241395293057",
     "galHandleType": 1,
     "galGemNum": 98,
     "galTitle": "互动营-买入",
     "createTime": "2021-02-27 11:49:36"
     */
    var galGemNum: Int = 0
    var galTitle: String = ""
    var createTime: String = ""
    var galHandleType: Int = 0
    var galId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        galGemNum    <- map["galGemNum"]
        galTitle    <- map["galTitle"]
        createTime    <- map["createTime"]
        galHandleType    <- map["galHandleType"]
        galId    <- map["galId"]
    }
    
}

//class HFConsumptionDetailModel : Mappable {
//
//    var gmtCreate: String = ""
//    var agreeName: String = ""
//    var gmtModified: String = ""
//
//    init(){}
//
//    required init?(map: Map) {}
//
//    func mapping(map: Map) {
//        gmtCreate  <- map["gmtCreate"]
//        agreeName  <- map["agreeName"]
//        gmtModified  <- map["gmtModified"]
//    }
//}
