//
//  HFMessageCenterViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

/// 消息列表类型
enum MsgListType {
    
    case submitRecord //发布记录列表
    case msgList //具体类型消息列表
}

class HFMessageCenterViewModel: NSObject {
        
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 消息类型集合
    var dataArr = [HFMessageCenterModel]()
    
    /// 获取消息类型
    /// - Returns: 消息类型数组
    func getMsgCategorys(_ successClosure: @escaping OptionClosure,  _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFMsgAPI.MsgTypeAPI , para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFMessageCenterModel>>().map(JSON: dic as! [String : Any] )
            self.dataArr = responseBaseModel?.model ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 消息类型
    var msgListType: MsgListType = .submitRecord
    
    /// 消息类型model
    var msgModel: HFMessageCenterModel?

    /// 列表数据请求
    /// - Parameters:
    ///   - page: 请求页面
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func getDatas(_ page: Int, _ successClosure: @escaping OptionClosure,  _ failClosure: @escaping OptionClosure) -> Void {
        self.getMsgs(page, successClosure, failClosure)
    }
    
    /// 指定消息类型列表集合
    var msgs = [HFMessageListModel]()
    
    /// 获取指定类型的消息列表
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    /// - Returns: 无
    func getMsgs(_ page: Int, _ successClosure: @escaping OptionClosure,  _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["msgTypeCode"] = self.msgModel?.msgTypeCode as AnyObject
        parameters["pageNum"] = page as AnyObject
        parameters["pageSize"] = "15"  as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFMsgAPI.MsgListAPI , para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFMessageListModel>>>().map(JSON: dic as! [String : Any])
            if page == 1 {
                self.msgs.removeAll()
            }
            let arr = responseBaseModel?.model?.list ?? []
            self.msgs += arr
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    var msgList: HFMessageListModel?
    
    /// 接收-获取消息详情
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func getMsgDetail(_ plId: String, _ successClosure: @escaping OptionClosure,  _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["plId"] = plId as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFMsgAPI.MsgDetailAPI , para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFMessageListModel>>().map(JSON: dic as! [String : Any])
            self.msgList = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    /// 设置一键已读
    /// - Returns: 无
    func readAll(_ successClosure: @escaping OptionClosure,  _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["msgTypeCode"] = self.msgModel?.msgTypeCode as AnyObject
        HFSwiftService.requestData(requestType: .Put, urlString: HFMsgAPI.MsgSetReadedAPI , para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 删除消息列表
    /// - Parameters:
    ///   - index: 下标位置
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func deleteItems(at index: Int, _ successClosure: @escaping OptionClosure,  _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["plId"] = self.msgs[index].plId as AnyObject
        HFSwiftService.requestData(requestType: .Delete, urlString: HFMsgAPI.MsgDeleteAPI , para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 开启消息推送
    var isOpenNotify: Bool = false
    
    /// 消息通知开关
    func notifySwitch(_ on: Bool, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["ucPushOn"] = ((on == true) ? "1" : "0") as AnyObject
        parameters["ucPushDevice"] = HFClientInfo.deviceType as AnyObject //推送设备类型
        parameters["ucPushDeviceNo"] = HFClientInfo.getPushDeviceToken() as AnyObject //推送设备唯一编号
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.NoticeSwitchAPI, para: parameters, successed: { (response) in
            self.isOpenNotify = true
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
}


// MARK: 未读消息数量管理

class MsgNumberViewModel {
    
    //单例创建
    static let shared = MsgNumberViewModel()
    
    init() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 未读数量
    var unReadNum: Int = 0
    
    /// 未读消息数量查询
    func unReadNum(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        /**
         kiId    是    string    园所ID
         */
        HFSwiftService.requestData(requestType: .Get, urlString: HFMsgAPI.MsgUnReadNumAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            self.unReadNum = dic["model"] as! Int
//            self.unReadNum = 10
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
}

