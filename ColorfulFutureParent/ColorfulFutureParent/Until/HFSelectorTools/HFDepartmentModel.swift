//
//  HFDepartmentModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/1.
//  Copyright © 2020 huifan. All rights reserved.
//
// 组织架构树部门数据模型

import Foundation
import ObjectMapper

class HFDepartmentModel: Mappable {
    
    var osId = "" // 业务主键id
    var osType = 0 // 应用类型0慧凡1幼儿园
    var title = "" { // 部分接口部门名称使用这个字段返回，需要将其复制给osName
        didSet {
            if !title.isEmptyStr() {
                self.osName = title
            }
        }
    }
    var osCode = "" // 部门编码
    var osName = "" // 部门名称
    var osPid = "" // 上级部门业务id
    var osLevel = 0 // 部门级别
    var osPersonNum = 0 // 部门人数(存储慧凡组织架构体系的部门人数，幼儿园的部门人数单独子表存储)
    var children:[HFDepartmentModel] // 下级列表
    var jobName = "" // 岗位名称
    
    var isOpen = false // 是否展开
    
    required init?(map: Map) {
        children = []
    }
    
    func mapping(map: Map) {
        osId <- map["osId"]
        osType <- map["osType"]
        title <- map["title"]
        osCode <- map["osCode"]
        osName <- map["osName"]
        osPid <- map["osPid"]
        osLevel <- map["osLevel"]
        osPersonNum <- map["osPersonNum"]
        children <- map["children"]
        jobName <- map["jobName"]
    }
}
