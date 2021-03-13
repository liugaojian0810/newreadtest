//
//  HFRegionModel.swift
//  ColorfulFuturePrincipal
//
//  Created by DH Fan on 2020/12/6.
//  Copyright © 2020 huifan. All rights reserved.
//
// 省市县数据模型

import Foundation
import ObjectMapper

@objc class HFRegionModel: NSObject, Mappable {
    
    @objc var diId = "" // 地区业务id
    @objc var diName = "" // 行政区名称
    @objc var naPinyin = "" // 行政区拼音
    @objc var diPid = "" // 父级行政区编码
    @objc var wzId = "" // 战区ID
    @objc var wzName = "" // 战区名称
    var children: [HFRegionModel] = [] // 行政区下级市/县
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapping(map: Map) {
        diId <- map["diId"]
        diName <- map["diName"]
        naPinyin <- map["naPinyin"]
        diPid <- map["diPid"]
        children <- map["children"]
        wzId <- map["wzId"]
        wzName <- map["wzName"]
    }
}
