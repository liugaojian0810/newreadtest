//
//  HFInteractTaskModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by DH Fan on 2021/2/5.
//  Copyright © 2021 huifan. All rights reserved.
//
// 小任务数据模型

import Foundation
import ObjectMapper


class HFGrownActionTaskList : Mappable {
    
    var gatId: Int = 0
    var gatIntro: String = ""
    var gaImgTempUrl: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gatId    <- map["gatId"]
        gatIntro    <- map["gatIntro"]
        gaImgTempUrl    <- map["gaImgTempUrl"]
    }
}


class HFInteractTaskModel : Mappable, Equatable {
    
    ///成长营小任务列表
    var grownActionTaskTime: String = ""
    var grownActionTaskList: [HFGrownActionTaskList]?
    
    
    var updateUid: String = ""
    var delStatus: Int = 0
    var createName: String = ""
    var gatIntro: String = ""
    var deleteName: String = ""
    var gatAttach: String = ""
    var createTime: String = ""
    var gaId: String = ""
    var createUid: String = ""
    var deleteUid: String = ""
    var deleteTime: String = ""
    var enableStatus: Int = 0
    var gatId: String = ""
    var sort: Int = 0
    var updateName: String = ""
    var updateTime: String = ""
    
    /// 是否已选择
    var isSelected = false
    /// 是否禁用
    var isDisable = false
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        updateUid    <- map["updateUid"]
        delStatus    <- map["delStatus"]
        createName    <- map["createName"]
        gatIntro    <- map["gatIntro"]
        deleteName    <- map["deleteName"]
        gatAttach    <- map["gatAttach"]
        createTime    <- map["createTime"]
        gaId    <- map["gaId"]
        createUid    <- map["createUid"]
        deleteUid    <- map["deleteUid"]
        deleteTime    <- map["deleteTime"]
        enableStatus    <- map["enableStatus"]
        gatId    <- map["gatId"]
        sort    <- map["sort"]
        updateName    <- map["updateName"]
        updateTime    <- map["updateTime"]
        grownActionTaskTime    <- map["grownActionTaskTime"]
        grownActionTaskList    <- map["grownActionTaskList"]
    }
    
    static func == (lhs: HFInteractTaskModel, rhs: HFInteractTaskModel) -> Bool{
        return lhs.gatId == rhs.gatId
    }
}
