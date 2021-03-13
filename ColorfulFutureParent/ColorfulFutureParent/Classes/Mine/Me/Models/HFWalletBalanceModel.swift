//
//  HFWalletBalanceModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper


class HFWalletBalanceModel: Mappable {
    /**
     {
         "id": 10008,//钱包ID
         "balanceAmount": 100,// 钱包余额 = 可用金额+锁定金额
         "availableAmount": 60,// 可用金额
         "lockAmount": 40,// 冻结金额
         "status":1,// 0审核中 1已开通
         "hasPassword": true,// 是否设置过支付密码：true设置过 false未设置过
     },
     */
    var status: Int = 0
    var Id: Int = 0
    var balanceAmount: Int = 0
    var availableAmount: Int = 0
    var lockAmount: Int = 0
    var hasPassword: Bool = false
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status    <- map["status"]
        Id    <- map["id"]
        balanceAmount    <- map["balanceAmount"]
        availableAmount    <- map["availableAmount"]
        lockAmount    <- map["lockAmount"]
        hasPassword    <- map["hasPassword"]
    }
}
