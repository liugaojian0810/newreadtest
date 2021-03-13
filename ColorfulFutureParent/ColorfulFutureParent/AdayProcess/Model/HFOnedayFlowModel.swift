//
//  HFOnedayFlowModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/1.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 dpckId    String
 grName    String    年级业务ID
 dppName    string    活动安排名称
 dpId    String    一日流程业务ID
 dpStartTime    String    流程开始时间
 dpEndTime    String    流程结束时间
 pfList    List    具体流程
 pfName    string    具体流程名称
 pfInfo    string    具体流程详情
 */

class HFOnedayFlowModel : Mappable {
    
    var dppafList: [OnedayFlowDppafListModel]?
    var dpckId: String = "" //适用年级业务ID
    var grName: String = "" //年级名称
    var grId: String = "" //年级业务ID

    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        dppafList    <- map["dppafList"]
        dpckId       <- map["dpckId"]
        grName       <- map["grName"]
        grId         <- map["grId"]
    }
    
}

class OnedayFlowDppafListModel : Mappable {
    
    var dpkId: String = ""
    var dppId: String = ""
    var dppName: String = ""
    var dpkStartTime: String = ""
    var dpkEndTime: String = ""
    var grName: String = ""
    var grId: String = ""
    var pfList: [OnedayFlowPfListModel]?
    var isChange: Bool = false

    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        dpkId    <- map["dpkId"]
        dppId    <- map["dppId"]
        dpkEndTime    <- map["dpkEndTime"]
        dppName    <- map["dppName"]
        dpkStartTime    <- map["dpkStartTime"]
        pfList    <- map["pfList"]
        grName    <- map["grName"]
        grId    <- map["grId"]
    }
    
}

class OnedayFlowPfListModel : Mappable {
    
    var pfInfo: String = ""
    var pfName: String = ""
    var pfId: String = ""
    var dppId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        pfInfo    <- map["pfInfo"]
        pfName    <- map["pfName"]
        pfId    <- map["pfId"]
        dppId    <- map["dppId"]
    }
    
}


// MARK: 活动安排下拉框
class OnedayFlowActivityModel : Mappable {
    
    /**
     dppName    string    活动安排名称
     dppId    String    活动安排业务ID
     grId    String    年级业务ID
     dppRemark    String    活动安排备注
     createUid    String    创建人业务ID
     */
    
    var projectFlowGetResultList: [OnedayFlowPfListModel]?
    var grId: String = ""
    var grName: String = ""
    var usrName: String = ""
    var updateTime: String = ""
    var dppId: String = ""
    var dppRemark: String = ""
    var dppName: String = ""
    var createUid: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        projectFlowGetResultList    <- map["projectFlowGetResultList"]
        grId    <- map["grId"]
        dppId    <- map["dppId"]
        dppRemark    <- map["dppRemark"]
        dppName    <- map["dppName"]
        createUid    <- map["createUid"]
        grName    <- map["grName"]
        usrName    <- map["usrName"]
        updateTime    <- map["updateTime"]
    }
    
}

class ActivityStepsModel : Mappable {
    
    /**
     id    Long    主键ID
     pfId    String    流程项目业务ID
     dppId    String    活动安排业务ID
     pfName    String    流程项目名称
     pfInfo    String    流程项目详情
     */
    var pfInfo: String = ""
//    var ID: Int = 0 去掉
    var dppId: String = ""
    var pfId: String = ""
    var pfName: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        pfInfo    <- map["pfInfo"]
//        ID    <- map["id"]
        dppId    <- map["dppId"]
        pfId    <- map["pfId"]
        pfName    <- map["pfName"]
    }
}
