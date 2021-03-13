//
//  HFGrowthCampViewModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/27.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON


class HFGrowthCampViewModel: NSObject {

    /// 教育活动列表
    lazy var activitys = [HFGrowthCampEduActivityModel]()
    
    /// 教育活动列表
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getGrowUpActivitys( _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        /**
         kbId    选填    String    宝宝id
         */
        parameters["kbId"] =  HFBabyViewModel.shared.currentBaby?.ciId as AnyObject  as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.CancelWalletAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFGrowthCampEduActivityModel>>>().map(JSON: dic as! [String : Any] )
//            if responseBaseModel?.model?.pageNum == 1 {
                self.activitys.removeAll()
//            }
            self.activitys += responseBaseModel?.model?.list ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 小任务列表
    lazy var tasks = [HFInteractTaskModel]()
    
    /// 教育活动列表
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getGrowUpTasks( _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        /**
         kbId    选填    String    宝宝id
         */
        parameters["kbId"] = HFBabyViewModel.shared.currentBaby?.ciId as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.CancelWalletAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFInteractTaskModel>>>().map(JSON: dic as! [String : Any] )
            self.tasks.removeAll()
            self.tasks += responseBaseModel?.model?.list ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
}
