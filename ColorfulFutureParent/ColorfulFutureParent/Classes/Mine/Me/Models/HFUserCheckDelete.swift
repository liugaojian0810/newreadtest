//
//  HFUserCheckDelete.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/12/23.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
class HFUserCheckDelete: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        allow <- map["allow"]
        verifyTimes <- map["verifyTimes"]
        verifyStatus <- map["verifyStatus"]
        message <- map["message"]
    }
    

    var allow: Bool = false
    var verifyTimes: Int = 0
    var verifyStatus: Int = 0
    var message: String = ""
}
