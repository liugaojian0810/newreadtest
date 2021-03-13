//
//  HFInteractiveEvaluateItemModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/2/28.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

class HFInteractiveEvaluateItemModel : NSObject, Mappable {
    
    var starNum: Int = 0
    var ceId: Int = 0
    var ceName: String = ""
    
    init(ceId: Int = 0, ceName: String = "") {
        super.init()
        self.ceId = ceId
        self.ceName = ceName
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapping(map: Map) {
        starNum    <- map["starNum"]
        ceId    <- map["ceId"]
        ceName    <- map["ceName"]
    }
    
}

/// 评价详情
class HFInteractiveEvaluateDetailModel : Mappable {
    
    var kirpContent: String = ""
    var kirpScoreAverage: Int = 0
    var evaluateList: [HFInteractiveEvaluateItemModel] = []
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        kirpContent    <- map["kirpContent"]
        evaluateList    <- map["evaluateList"]
        kirpScoreAverage    <- map["kirpScoreAverage"]
    }
    
}
