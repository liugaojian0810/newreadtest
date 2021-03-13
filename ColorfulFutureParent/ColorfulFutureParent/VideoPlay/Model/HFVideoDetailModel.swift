//
//  HFVideoDetailModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2021/2/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper


class HFVideo : Mappable {
    
    var urlType: String = ""
    var fluentUrl: String = ""
    var sdUrl: String = ""
    var hdPullUrl: String = ""
    var originUrl: String = ""
    var highUrl: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        urlType    <- map["urlType"]
        fluentUrl    <- map["fluentUrl"]
        sdUrl    <- map["sdUrl"]
        hdPullUrl    <- map["hdPullUrl"]
        originUrl    <- map["originUrl"]
        highUrl    <- map["highUrl"]
    }
}


class HFVideoDetailModel : Mappable {
    
    var encrypt: Int = 0
    var htmlCode: String = ""
    var swfCode: String = ""
    var autoCode: String = ""
    var tryWatchAutoCode: String = ""
    var videoId: String = ""
    var customCode: String = ""
    var videoUrl: [HFVideo]?
    var tryWatchVideoUrl: [HFVideo]?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        encrypt    <- map["encrypt"]
        htmlCode    <- map["htmlCode"]
        swfCode    <- map["swfCode"]
        autoCode    <- map["autoCode"]
        tryWatchAutoCode    <- map["tryWatchAutoCode"]
        videoId    <- map["videoId"]
        customCode    <- map["customCode"]
        videoUrl    <- map["videoUrl"]
        tryWatchVideoUrl    <- map["tryWatchVideoUrl"]
    }
}
