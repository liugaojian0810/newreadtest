//
//  HFPopupDataModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/14.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

/// 邀请结果数据模型
class HFJoinResultModel : Mappable {
    
    /*
     kiName    String    幼儿园名称
     kiId    String    幼儿园业务ID
     ilId    String    邀请业务ID
     ilWay    Integer    邀请方式0被邀请1主动申请
     ilStatus    String    邀请状态0未读;1已读;3已接受;5未接受;7拒绝
     ilAuditMark    String    被拒绝原因
     ciComeStatus    Integer    宝宝状态0已在园1新入园
     ciId    String    宝宝业务ID
     */
    
    var kiName: String = ""
    var ilWay: Int = 0
    var ciName: String = ""
    var ciComeStatus: Int = 0
    var kiId: String = ""
    var ilStatus: Int = 0
    var ciId: String = ""
    var ilId: String = ""
    var ilAuditMark: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        kiName    <- map["kiName"]
        ilWay    <- map["ilWay"]
        ciName    <- map["ciName"]
        ciComeStatus    <- map["ciComeStatus"]
        kiId <- map["kiId"]
        ilStatus    <- map["ilStatus"]
        ciId    <- map["ciId"]
        ilId    <- map["ilId"]
        ilAuditMark    <- map["ilAuditMark"]
    }

}
