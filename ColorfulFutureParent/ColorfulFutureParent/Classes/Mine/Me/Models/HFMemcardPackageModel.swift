//
//  HFMemcardPackageModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/20.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: 卡包列表

class HFMemCardPackageList : Mappable {
    
    /**
     参数    类型    描述    备注
     mcpiId    string    卡包ID
     mccId    string    卡组合id
     mcpiType    Integer    类型（0单个，1组合）
     mcpiCourceType    Integer    来源类型（0:购买，1赠送，2会员权益）
     mcpiCourceTime    date    来源时间
     mcpiStatus    int    0未使用，1已使用，2已作废
     mcpiInvalidTime    date    作废时间
     mcpiCompleteTime    date    使用完成时间
     memCardPackageList->mcName    string    卡名称
     memCardPackageList->mcName    string    卡号
     memCardPackageList->mcTermValidity    int    有效期
     memCardPackageList->mcRoleId    string    会员卡所属角色（园长：ROLE_0987_DIRECTOR，教师：ROLE_3845_TEACHER，家长：ROLE_5749_PATRIARCH，幼儿园：ROLE_5748_KINDERGARTEN）
     memCardPackageList->mcImg    string    会员卡图片
     */
    var mcpiId: String = ""
    var mcpiInvalidTime: String = ""
    var mcpiStatus: Int = 0
    var mcpiType: Int = 0
    var mcpiCompleteTime: String = ""
    var mcpiCourceType: Int = 0
    var mcpiCourceTime: String = ""
    var memCardPackageDetailList: [HFMemCardPackageItem]?
    var mccId: String = ""
    var mcpiGivingUserId: String = ""
    var mccName: String = ""
    var mcpiGivingUserName: String = ""
    var mcpiSource: Int = 0
    var mcpiSourceTime: String = ""
    
    
    
    
    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mcpiId    <- map["mcpiId"]
        mcpiInvalidTime    <- map["mcpiInvalidTime"]
        mcpiStatus    <- map["mcpiStatus"]
        mcpiType    <- map["mcpiType"]
        mcpiCompleteTime    <- map["mcpiCompleteTime"]
        mcpiCourceType    <- map["mcpiCourceType"]
        mcpiCourceTime    <- map["mcpiCourceTime"]
        memCardPackageDetailList    <- map["memCardPackageDetailList"]
        mccId    <- map["mccId"]
        mcpiGivingUserId    <- map["mcpiGivingUserId"]
        mccName    <- map["mccName"]
        mcpiGivingUserName    <- map["mcpiGivingUserName"]
        mcpiSource    <- map["mcpiSource"]
        mcpiSourceTime    <- map["mcpiSourceTime"]
    }
    
}


class HFMemCardPackageItem : Mappable {
    
    var mcId: String = ""
    var mcpdId: String = ""
    var mcpdActivationStatus: Int = 0
    var mcpiId: String = ""
    var mcTermValidity: Int = 0
    var memCode: String = ""
    var mcpdUseStatus: Int = 0
    var mcRoleId: String = ""
    var mtId: String = ""
    var mlId: String = ""
    var mcpdActivationStartTime: String = ""
    var mcpdUseTime: String = ""
    var mcName: String = ""
    var mcUnit: String = ""
    var mcpdActivationTermTime: String = ""
    var mcpdActivationEndTime: String = ""
    var mcImg: String = ""
    var rightsBatch: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mcId    <- map["mcId"]
        mcpdId    <- map["mcpdId"]
        mcpdActivationStatus    <- map["mcpdActivationStatus"]
        mcpiId    <- map["mcpiId"]
        mcTermValidity    <- map["mcTermValidity"]
        memCode    <- map["memCode"]
        mcpdUseStatus    <- map["mcpdUseStatus"]
        mcRoleId    <- map["mcRoleId"]
        mtId    <- map["mtId"]
        mlId    <- map["mlId"]
        mcpdActivationStartTime    <- map["mcpdActivationStartTime"]
        mcpdUseTime    <- map["mcpdUseTime"]
        mcName    <- map["mcName"]
        mcUnit    <- map["mcUnit"]
        mcpdActivationTermTime    <- map["mcpdActivationTermTime"]
        mcpdActivationEndTime    <- map["mcpdActivationEndTime"]
        mcImg    <- map["mcImg"]
        rightsBatch    <- map["rightsBatch"]

        
    }
    
}








