//
//  HFClassModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/20.
//  Copyright © 2020 huifan. All rights reserved.
//
// 班级数据模型

import Foundation
import ObjectMapper

class HFClassModel: Mappable {
    
    var clId: String = "" // 班级业务id
    var clName: String = "" // 班级名称
    var childNum: Int = 0 // 宝宝数量
    var childList: [HFBabyModel] // 宝宝信息
    
    //班级列表特有字段
    var kiId: String = "" // 幼儿园业务id
    var eiId: String = "" // 主班教师ID
    var clCapacity: Int = 0 // 班级人数
    var grId: String = "" // 年级业务id
    var kgrId: String = "" // 幼儿园年级业务id
    var kgrRemarkName: String = "" // 年级备注名称
    var clRemark: String = "" // 备注
    var enableStatus: Int = 0 // 是否启用
    var eiName: String = "" // 主班教师名称
    
    // 以下字典服务端不会返回，仅用于本地操作使用
    var select: Bool = false // 是否选中
    
    required init?(map: Map) {
        childList = []
    }
    
    func mapping(map: Map) {
        clId <- map["clId"]
        clName <- map["clName"]
        childNum <- map["childNum"]
        childList <- map["childList"]
        
        kiId <- map["kiId"]
        eiId <- map["eiId"]
        clCapacity <- map["clCapacity"]
        grId <- map["grId"]
        kgrId <- map["kgrId"]
        kgrRemarkName <- map["kgrRemarkName"]
        clRemark <- map["clRemark"]
        enableStatus <- map["enableStatus"]
        
        eiName <- map["eiName"]

        
    }
}
