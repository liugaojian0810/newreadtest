//
//  HFDictionaryInfoModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/15.
//  Copyright © 2020 huifan. All rights reserved.
//
// 公共选择器字典信息数据模型

import Foundation
import ObjectMapper

@objc class HFDictionaryInfoModel: NSObject, Mappable {

    @objc var dicFieldCode: String = ""
    @objc var dicFieldName: String = ""
    
    // 公用宝宝关系列表查询
    @objc var dicId: String = ""
    
    // 证件号长度
    @objc var dicRemark: String = ""
    
    @objc var naPinyin: String = ""
    @objc var naId: String = ""
    @objc var naName: String = ""
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    func mapping(map: Map) {
        dicFieldCode    <- map["dicFieldCode"]
        dicFieldName    <- map["dicFieldName"]
        
        dicId <- map["dicId"]
        
        dicRemark <- map["dicRemark"]
        
        naPinyin    <- map["naPinyin"]
        naId    <- map["naId"]
        naName    <- map["naName"]
    }

}
