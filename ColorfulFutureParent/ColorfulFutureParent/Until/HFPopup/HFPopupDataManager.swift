//
//  HFPopupDataManager.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/14.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

@objc class HFPopupDataManager: NSObject {
    
    @objc static let shared = HFPopupDataManager()
    
    override init() {
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 教师邀请结果
    var joinResultModel: HFJoinResultModel?
    
    // 是否允许加载宝宝结果
    var allowloadBabyJoinResult = true
    
    /// 加载宝宝邀请结果（查询幼儿园园长或教师添加的宝宝）
    static func loadBabyJoinResult(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        if !shared.allowloadBabyJoinResult {
            return
        }
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.ParentPopwindows, para: [:], successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFJoinResultModel>>().map(JSON: dic as! [String : Any] )
            
            let joinResultModel = responseBaseModel?.model?.first
            shared.joinResultModel = joinResultModel
            
            if joinResultModel != nil {
                
            }
            shared.allowloadBabyJoinResult = false
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 加载指定宝宝邀请结果
    static func loadBabyJoinResult(ciId: String, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String:AnyObject]()
        parameters["ciId"] = ciId as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.ParentPopchildapplyAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFJoinResultModel>>().map(JSON: dic as! [String : Any] )
            
            let joinResultModel = responseBaseModel?.model
            shared.joinResultModel = joinResultModel
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 家长/教师 同意拒绝操作
    /// - Parameters:
    ///   - ilStatus: 邀请状态 3已接受;7拒绝
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    /// - Returns: 无返回值
    static func rejectJoinInvition(ilStatus: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["ilId"] = shared.joinResultModel?.ilId as AnyObject // 邀请记录ID
        parameters["ilStatus"] = ilStatus as AnyObject
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.RejectInvitionAPI, para: parameters) { (response) in
            
            successClosure()
            
        } failured: { (error) in
            
            failClosure()
        }
    }
}
