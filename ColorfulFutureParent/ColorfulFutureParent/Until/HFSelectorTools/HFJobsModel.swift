//
//  HFJobsModel.swift
//  ColorfulFuturePrincipal
//
//  Created by DH Fan on 2020/12/6.
//  Copyright © 2020 huifan. All rights reserved.
//
// 岗位数据模型

import Foundation
import ObjectMapper

class HFJobsModel: Mappable {
    
    var jobId = "" // 业务主键id
    var jobName = "" // 岗位名称
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        jobId <- map["jobId"]
        jobName <- map["jobName"]
    }
}
