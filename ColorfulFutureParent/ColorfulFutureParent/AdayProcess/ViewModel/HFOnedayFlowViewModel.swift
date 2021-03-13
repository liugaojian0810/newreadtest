//
//  HFOnedayFlowViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class HFOnedayFlowViewModel: NSObject {
    
    
    var grId: String = "GR202011260330789503" //年级ID
    var kiId: String = HFBabyViewModel.shared.currentBaby?.baseKgInfo?.kiId ?? "" //幼儿园ID
    var dpckId: String = "" //适用年级业务ID
    
    
    /// 一日流程列表
    var dppafLists = [OnedayFlowDppafListModel]()
    
    /// 一日流程列表
    var dppaf: OnedayFlowDppafListModel?
    
    var outModel: HFOnedayFlowModel?
    
    func generateModel() -> OnedayFlowDppafListModel {
        
        let genModel = OnedayFlowDppafListModel()
        genModel.grId = grId
        genModel.dpkStartTime   = ""
        genModel.dpkEndTime     = ""
        genModel.pfList = nil
        return genModel
    }
    
    /// 获取一日流程列表
    func onedayFlowList(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["grId"] = grId as AnyObject
        parameters["kiId"] = kiId as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFADayProcessAPI.ADayProcessListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFOnedayFlowModel>>().map(JSON: dic as! [String : Any] )
            self.dpckId = responseBaseModel?.model?.dpckId ?? ""
            self.dppafLists.removeAll()
            self.dppafLists += responseBaseModel?.model?.dppafList ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 清空一日流程
    func clearOnedayFlow(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["grId"] = grId as AnyObject
        parameters["kiId"] = kiId as AnyObject
        /**
         grId    是    string    年级ID
         kiId    是    string    幼儿园ID
         */
        HFSwiftService.requestData(requestType: .Delete, urlString: HFADayProcessAPI.ClearADayProcessAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let success = dic["model"] as! Bool
            if success {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 一日流程恢复默认
    func restoreOnedayFlow(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["grId"] = grId as AnyObject
        parameters["kiId"] = kiId as AnyObject
        /**
         grId    是    string    年级ID
         kiId    是    string    幼儿园ID
         */
        HFSwiftService.requestData(requestType: .Post, urlString: HFADayProcessAPI.RestoreADayProcessAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let success = dic["model"] as! Bool
            if success {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 更改一日流程
    func updateOnedayFlow(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        var list = [[String: String]]()
        for (_, seg) in self.dppafLists.enumerated() {
            var dic = [String: String]()
            dic["dpkStartTime"] = seg.dpkStartTime
            dic["dpkEndTime"] = seg.dpkEndTime
            dic["dppId"] = seg.dppId
            dic["dpkId"] = seg.dpkId
            dic["grId"] = grId
            list.append(dic)
        }
        parameters["dpckId"] = self.dpckId as AnyObject
        parameters["kiId"] = kiId as AnyObject
        parameters["list"] = list as AnyObject

        HFSwiftService.requestData(requestType: .Put, urlString: HFADayProcessAPI.UpdateADayProcessAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let success = dic["model"] as! Bool
            if success {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 新建一日流程
    func createOnedayFlow(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["grId"] = grId as AnyObject
        parameters["kiId"] = kiId as AnyObject
        parameters["dppId"] = dppaf?.dppId as AnyObject //活动项目业务ID
        parameters["dpkEndTime"] = dppaf?.dpkEndTime as AnyObject
        parameters["dpkStartTime"] = dppaf?.dpkStartTime as AnyObject
        /**
         dpkStartTime    是    String    活动开始时间
         dpkEndTime    是    String    活动结束时间
         dppId    是    String    活动项目业务ID
         kiId    是    array    幼儿园ID
         grId    是    array    年级数组
         */
        HFSwiftService.requestData(requestType: .Post, urlString: HFADayProcessAPI.UpdateADayProcessAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let success = dic["model"] as! Bool
            if success {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 删除一日流程
    func deleteOnedayFlow(_ dpk_Id: String ,_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
//        parameters["dpkId"] = dppaf?.dpId as AnyObject
        parameters["dpkId"] = dpk_Id as AnyObject
        /**
         dpkId    是    String    活动项目业务ID
         */
        HFSwiftService.requestData(requestType: .Delete, urlString: HFADayProcessAPI.UpdateADayProcessAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let success = dic["model"] as! Bool
            if success {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 活动安排列表
    lazy var activitys = [OnedayFlowActivityModel]()
    func getOnedayFlowActivitys(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["grId"] = grId as AnyObject

        HFSwiftService.requestData(requestType: .Get, urlString: HFADayProcessAPI.CreateADayProcessAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<OnedayFlowActivityModel>>().map(JSON: dic as! [String : Any] )
            self.activitys += responseBaseModel?.model ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
}
