//
//  HFInvitationInfoModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/11.
//  Copyright © 2021 huifan. All rights reserved.
//
// 邀请信息数据模型

import Foundation
import ObjectMapper

class HFInvitationInfoModel : Mappable {
    
    var kiId: String = ""
    var clName: String = ""
    var grId: String = ""
    var kgrId: String = ""
    var clId: String = ""
    var kgrRemarkName: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        kiId    <- map["kiId"]
        clName    <- map["clName"]
        grId    <- map["grId"]
        kgrId    <- map["kgrId"]
        clId    <- map["clId"]
        kgrRemarkName    <- map["kgrRemarkName"]
    }
}
