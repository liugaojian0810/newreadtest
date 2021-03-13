//
//  HFBusOrderModel.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/30.
//  Copyright © 2021 huifan. All rights reserved.
//
// 业务订单数据模型

import Foundation
import ObjectMapper

class HFBusOrderModel : Mappable,HFOrdereItemModelProtocol {
    
    var giName: String = ""
    var giValidit: Int = 0
    var boiId: String = ""
    var boiStatus: Int = 0
    var giId: String = ""
    var boiClassification: String = ""
    var remainAmount: Int = 0
    var boiTime: String = ""
    var boiPayWay: Int = 0
    var boiCode: String = ""
    var boilastTotalAmount: Int = 0
    var boitotalAmount: Int = 0
    
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
            timeModel.text = boiTime.substring(to: 10)
            arr.append(timeModel)
            
            let payWayModel = HFOrdereItemModel.init()
            payWayModel.title = "支付方式"
            payWayModel.text = "未知"
            if boiPayWay == 1 {
                payWayModel.text = "一次性支付"
            }
            if boiPayWay == 2 {
                payWayModel.text = "分笔支付"
            }
            arr.append(payWayModel)
            
            if boiPayWay == 2 {
                let didPayAmountModel = HFOrdereItemModel.init()
                didPayAmountModel.title = "已支付"
                let string: String = String(format: "¥%.2f", Double(boilastTotalAmount) * 0.01)
                let didPayAmountAt = NSMutableAttributedString(string: "\(string)元")
                let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold),.foregroundColor: UIColor.hexColor(0xFF844B)]
                didPayAmountAt.addAttributes(attr, range: NSRange(location: 0, length: didPayAmountAt.length))
                didPayAmountModel.attributedText = didPayAmountAt
                arr.append(didPayAmountModel)
            }
            
            let totalAmountModel = HFOrdereItemModel.init()
            let string: String = String(format: "¥%.2f", Double(boitotalAmount) * 0.01)
            let totalAmountAt = NSMutableAttributedString(string: "￥\(string)")
            let attr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold),.foregroundColor: UIColor.hexColor(0xFF844B)]
            totalAmountAt.addAttributes(attr, range: NSRange(location: 0, length: totalAmountAt.length))
            totalAmountModel.attributedText = totalAmountAt
            arr.append(totalAmountModel)
            
            return arr
        }
    }
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        giName    <- map["giName"]
        giValidit    <- map["giValidit"]
        boiId    <- map["boiId"]
        boiStatus    <- map["boiStatus"]
        giId    <- map["giId"]
        boiClassification    <- map["boiClassification"]
        remainAmount    <- map["remainAmount"]
        boiTime    <- map["boiTime"]
        boiPayWay    <- map["boiPayWay"]
        boiCode    <- map["boiCode"]
        boilastTotalAmount    <- map["boilastTotalAmount"]
        boitotalAmount    <- map["boitotalAmount"]
    }
    
}
