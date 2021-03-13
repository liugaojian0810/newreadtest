//
//  HFGrowthCampEduActivityModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/27.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFGrowthCampEduActivity : Mappable {
    
    var gaName: String = ""
    var csName: String = ""
    var gaTeachTarget: String = ""
    var gaImgCoverUrl: String = ""
    var gaImgTempUrl: String = ""
    var csstName: String = ""
    var gaTeachFocus: String = ""
    var gaTeachDifficult: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gaName    <- map["gaName"]
        csName    <- map["csName"]
        gaTeachTarget    <- map["gaTeachTarget"]
        gaImgCoverUrl    <- map["gaImgCoverUrl"]
        gaImgTempUrl    <- map["gaImgTempUrl"]
        csstName    <- map["csstName"]
        gaTeachFocus    <- map["gaTeachFocus"]
        gaTeachDifficult    <- map["gaTeachDifficult"]
    }
}


class HFGrowthCampEduActivityModel : Mappable {
    
    var startDate: String = ""
    var grownActionList = [HFGrowthCampEduActivity]()
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        startDate    <- map["startDate"]
        grownActionList    <- map["grownActionList"]
    }
    
}
