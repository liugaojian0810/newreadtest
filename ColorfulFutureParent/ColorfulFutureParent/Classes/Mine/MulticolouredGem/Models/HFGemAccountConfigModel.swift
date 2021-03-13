//
//  HFGemAccountConfigModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/3/8.
//  Copyright © 2021 huifan. All rights reserved.
//  虚拟币账户信息、商品列表id配置信息

import UIKit
import ObjectMapper

class HFGemAccount : Mappable {
    
    var gaStatus: Int = 0
    var gaTotal: Int = 0
    var gaBalance: Int = 0
    var gaFrozen: Int = 0
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gaStatus    <- map["gaStatus"]
        gaTotal    <- map["gaTotal"]
        gaBalance    <- map["gaBalance"]
        gaFrozen    <- map["gaFrozen"]
    }
    
}

class HFGemIdsConfig : Mappable {
    
    var gpGemNum: Int = 0
    var gpGemPrice: Int = 0
    var gpId: String = ""
    var gpName: String = ""
    var productId: String = ""

    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gpGemNum    <- map["gpGemNum"]
        gpGemPrice    <- map["gpGemPrice"]
        gpId    <- map["gpId"]
        gpName    <- map["gpName"]
        productId    <- map["productId"]
    }
    
}

class HFGemAccountConfigModel: Mappable {
    
    var gemAccount: HFGemAccount?
    var chooseList: [HFGemIdsConfig]?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gemAccount    <- map["gemAccount"]
        chooseList    <- map["chooseList"]
    }
}
