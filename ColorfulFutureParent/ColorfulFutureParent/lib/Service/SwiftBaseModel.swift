//
//  SwiftBaseModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

/// 响应数据model为字典类型
class HFResponseBaseModel<T: Mappable>: Mappable {
    var success: Bool = false
    var errorMessage: String?
    var errorCode: Int = 0
    var model: T?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        model  <- map["model"]
        success  <- map["success"]
        errorMessage  <- map["errorMessage"]
        errorCode  <- map["errorCode"]
    }
}

/// 响应数据model为数组类型
class HFResponseArrayBaseModel<T: Mappable>: Mappable {
    var success: Bool = false
    var errorMessage: String?
    var errorCode: Int = 0
    var model: [T]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        model  <- map["model"]
        success  <- map["success"]
        errorMessage  <- map["errorMessage"]
        errorCode  <- map["errorCode"]
    }
}

// 分页返回后model数据基类
class HFResponsePageBaseModel<T: Mappable>: Mappable {
    var pageNum = 0 // 分页
    var pageSize = 0 // 分页步长
    var total = 0 // 总数
    var pages = 0 // 总页数
    var list: [T]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pageNum <- map["pageNum"]
        pageSize <- map["pageSize"]
        total <- map["total"]
        pages <- map["pages"]
        list <- map["list"]
    }
    
    func canRefresh() -> (Bool) {
        return self.pageNum < self.pages
    }
}


// 图片上传结果数据模型
@objc class HFImageUploadResultModel: NSObject, Mappable {
    
    @objc var fiId: String = "" // 文件业务id
    @objc var fiAccessPath: String = "" // 图片访问路径
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mapping(map: Map) {
        fiId  <- map["fiId"]
        fiAccessPath  <- map["fiAccessPath"]
    }
}


struct HFSwiftBaseModel<T: Mappable>: Mappable {
    
    var errorCode: Int = 0 //编码
    var errorMessage: String = ""
    var success: Bool = false
    var model: Any?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        errorCode <- map["errorCode"]
        errorMessage <- map["errorMessage"]
        success <- map["success"]
        model <- map["model"]
    }
}

struct HFNormalModel: Mappable {
    
    init?(map: Map) {
    }
    init() {
    }
    mutating func mapping(map: Map) {
        
    }
}

