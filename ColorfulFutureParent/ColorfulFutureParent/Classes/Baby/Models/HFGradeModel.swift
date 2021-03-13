//
//  HFGradeModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/20.
//  Copyright © 2020 huifan. All rights reserved.
//
// 幼儿园年级数据模型

import Foundation
import ObjectMapper

class HFGradeModel: Mappable {
    
    var kgrId: String = "" // 幼儿园年级业务id
    var grId: String = "" // 年级基础业务id
    var grName: String = "" { // 年级基础业务名称
        didSet {
            if !grName.isEmptyStr() && kgrRemarkName.isEmptyStr() {
                // 备注名称为空
                self.kgrRemarkName = grName
            }
        }
    }
    var kiId: String = "" // 幼儿园业务id
    var kgrRemarkName: String = "" // 年级备注名称
    var kgrRemark: String = "" // 备注
    var enableStatus = 0 // 是否启用
    var kgrSort = 0 // 是否启用
    var classNum = 0 // 班级数量

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        kgrId <- map["kgrId"]
        grId <- map["grId"]
        grName <- map["grName"]
        kiId <- map["kiId"]
        kgrRemarkName <- map["kgrRemarkName"]
        kgrRemark <- map["kgrRemark"]
        enableStatus <- map["enableStatus"]
        kgrSort <- map["kgrSort"]
        classNum <- map["classNum"]
    }
}
