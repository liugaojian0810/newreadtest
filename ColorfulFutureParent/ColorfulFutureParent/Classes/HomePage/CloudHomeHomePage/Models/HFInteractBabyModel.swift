//
//  HFInteractBabyModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/2/22.
//  Copyright © 2021 huifan. All rights reserved.
//
// 互动营已预约宝宝数据模型

import Foundation
import ObjectMapper

class HFInteractBabyModel : Mappable {
    
    var kbName: String = ""
    var kisId: String = ""
    var kpName: String = ""
    var kpId: String = ""
    var parentReportId: String = ""
    var kbId: String = ""
    var kiiId: String = ""
    var teacherReportId: String = ""
    /// 教师报告发布状态；0：保存；1：发布；
    var teacherReportPublishStatus = 0
    var kbAvatarUrl: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        kbName    <- map["kbName"]
        kisId    <- map["kisId"]
        kpName    <- map["kpName"]
        kpId    <- map["kpId"]
        parentReportId    <- map["parentReportId"]
        kbId    <- map["kbId"]
        kiiId    <- map["kiiId"]
        teacherReportId    <- map["teacherReportId"]
        teacherReportPublishStatus <- map["teacherReportPublishStatus"]
        kbAvatarUrl    <- map["kbAvatarUrl"]
    }
    
}
