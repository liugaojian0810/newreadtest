//
//  HFHomeModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/3/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

class HFHomeModel : Mappable {
    
    var homePageStatus: HFHomePageStatus = .notJoinKinder
    var todayKindergartenInteractionList: [HFInteractiveModel] = []
    var KindergartenInteractionList: [HFInteractiveModel] = []
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        homePageStatus    <- (map["homePageStatus"],EnumTransform<HFHomePageStatus>())
        todayKindergartenInteractionList    <- map["todayKindergartenInteractionList"]
        KindergartenInteractionList    <- map["KindergartenInteractionList"]
    }
}
