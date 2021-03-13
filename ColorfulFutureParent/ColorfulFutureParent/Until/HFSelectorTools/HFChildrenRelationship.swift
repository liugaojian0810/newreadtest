//
//  HFChildrenRelationship.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/12/22.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

/// 宝宝与家长关系模型
class HFChildrenRelationship: Mappable {
    
    var dicId = ""
    var dicFieldName = ""
    var dicFieldCode = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dicId <- map["dicId"]
        dicFieldName <- map["dicFieldName"]
        dicFieldCode <- map["dicFieldCode"]
    }
}
