//
//  HFGemOrderModel.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/30.
//  Copyright © 2021 huifan. All rights reserved.
//
// 宝石订单数据模型

import Foundation
import ObjectMapper

class HFGemOrderModel : Mappable,HFOrdereItemModelProtocol {

    var giName: String = ""
    var boiTotalAmount: Int = 0
    var boiId: String = ""
    var boiStatus: Int = 0
    var giId: String = ""
    var giTeachingStartTime: String = ""
    var boiPayWay: Int = 0
    var giTeachingEndTime: String = ""
    var createTime: String = ""
    var boiCode: String = ""
    var boilastTotalAmount: Int = 0
    var giTeachingName: String = ""
    var boi_total_amount: Int = 0
    
    var itemModels: [HFOrdereItemModel] {
        get {
            var arr: [HFOrdereItemModel] = []
            
            let nameModel = HFOrdereItemModel.init()
            nameModel.title = "产品名称"
            nameModel.text = giName
            nameModel.showArrow = true
            arr.append(nameModel)
            
            let orderNoModel = HFOrdereItemModel.init()
            orderNoModel.title = "订单号"
            orderNoModel.text = boiCode
            arr.append(orderNoModel)
            
            let timeModel = HFOrdereItemModel.init()
            timeModel.title = "订单时间"
            timeModel.text = createTime.substring(to: 10)
            arr.append(timeModel)
            
            let payWayModel = HFOrdereItemModel.init()
            payWayModel.title = "支付方式"
            payWayModel.text = "五彩宝石"
            arr.append(payWayModel)
            
            let totalAmountModel = HFOrdereItemModel.init()
            totalAmountModel.title = "消耗宝石数量"
            let mAtb = NSMutableAttributedString.init(string: "\(boi_total_amount)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xFF844B),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .regular)])
            let a1tb = NSAttributedString.init(string: "枚", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x666666),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .regular)])
            mAtb.append(a1tb)
            totalAmountModel.attributedText = mAtb
            arr.append(totalAmountModel)
            
            return arr
        }
    }
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        giName    <- map["giName"]
        boiTotalAmount    <- map["boiTotalAmount"]
        boiId    <- map["boiId"]
        boiStatus    <- map["boiStatus"]
        giId    <- map["giId"]
        giTeachingStartTime    <- map["giTeachingStartTime"]
        boiPayWay    <- map["boiPayWay"]
        giTeachingEndTime    <- map["giTeachingEndTime"]
        createTime    <- map["createTime"]
        boiCode    <- map["boiCode"]
        boilastTotalAmount    <- map["boilastTotalAmount"]
        giTeachingName    <- map["giTeachingName"]
        boi_total_amount <- map["boi_total_amount"]
    }

}
