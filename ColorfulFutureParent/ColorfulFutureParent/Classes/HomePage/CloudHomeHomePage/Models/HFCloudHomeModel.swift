//
//  HFCloudHomeModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/3/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

struct HFCloudHomeItem {
    var title = ""
    var data: Any?
}

class HFCloudHomeModel : Mappable {
    
    var reportTime: String = ""
    var todayKindergartenInteractionList: [HFInteractiveModel] = []
    var KindergartenInteractionList: [HFInteractiveModel] = []
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        reportTime    <- map["reportTime"]
        todayKindergartenInteractionList    <- map["todayKindergartenInteractionList"]
        KindergartenInteractionList    <- map["KindergartenInteractionList"]
    }
}
