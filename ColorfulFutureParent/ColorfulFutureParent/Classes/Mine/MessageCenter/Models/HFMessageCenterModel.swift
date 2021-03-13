//
//  HFMessageCenterModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

enum HFMessageType {
    case todo // 待办事项
    case audit // 审批消息
    case system // 系统消息
    case wallet // 钱包消息
    case internalNotice // 园内消息
    case publicRecord // 发布记录
}

class HFMessageCenterModel : Mappable {
    /**
     msgTypeCode    String    消息类型code码
     msgTypeName    String    消息类型名称
     lateMsg    String    最近一条消息内容
     noReadCnt    int    未读数量
     */
    var msgTypeCode: String = ""
    var noReadCnt: Int = 0
    var msgTypeName: String = ""
    var lateMsg: String = ""
    var msgTypeImg: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        msgTypeCode    <- map["msgTypeCode"]
        noReadCnt    <- map["noReadCnt"]
        msgTypeName    <- map["msgTypeName"]
        lateMsg    <- map["lateMsg"]
        msgTypeImg    <- map["msgTypeImg"]
    }
}


class HFMessageListModel : Mappable {
    /**
     　ㄴplId    String    消息业务ID
     　ㄴmsgType    int    消息类型
     　ㄴmsgTitle    String    消息标题
     　ㄴmsgContent    String    消息内容
     　ㄴurlAddress    String    链接地址
     　ㄴmsgImg    String    图片
     　ㄴpushTime    String    推送时间
     　ㄴmsgReadState    int    是否阅读 0否；1是
     */
    var msgType: Int = 0
    var urlAddress: String = ""
    var msgImg: String = ""
    var msgReadState: Int = 0
    var msgTitle: String = ""
    var plId: String = ""
    var msgContent: String = ""
    var pushTime: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        msgType    <- map["msgType"]
        urlAddress    <- map["urlAddress"]
        msgImg    <- map["msgImg"]
        msgReadState    <- map["msgReadState"]
        msgTitle    <- map["msgTitle"]
        plId    <- map["plId"]
        msgContent    <- map["msgContent"]
        pushTime    <- map["pushTime"]
    }
    
}

class HFMessagePubRecordModel : Mappable {
    
    /**
     　ㄴplId    String    消息业务ID
     　ㄴmsgTitle    String    消息标题
     　ㄴmsgContent    String    消息内容
     　ㄴurlAddress    String    链接地址
     　ㄴpushTime    String    推送时间
     　ㄴpushStatus    int    是否推送 0否；1是
     */
    var plId: String = ""
    var pushTime: String = ""
    var msgTitle: String = ""
    var pushStatus: Int = 0
    var msgContent: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        plId    <- map["plId"]
        pushTime    <- map["pushTime"]
        msgTitle    <- map["msgTitle"]
        pushStatus    <- map["pushStatus"]
        msgContent    <- map["msgContent"]
    }
    
}

