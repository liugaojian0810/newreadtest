//
//  HFInteractTaskViewModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by DH Fan on 2021/2/5.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class HFInteractTaskViewModel {
    
    /// 已经选择的小任务
    var selectedInteractTasks: [HFInteractTaskModel] = []
    
    /// 禁止选择小任务
    var disableInteractTasks: [HFInteractTaskModel] = []
    
    /// 选择完小任务回调
    var selectComplete: ((_ interactTaskModel: [HFInteractTaskModel]) -> ())?
    
    /// 互动活动数据源数组
    var eduActivitys: [HFEduActivity] = []
    
    // 选择的科目id
    var csId = ""
    
    // 选择的年级id
    var grId = ""
    
    /// 获取互动营小任务列表
    func getInteractTask(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        parameters["csId"] = csId as AnyObject
        parameters["grId"] = grId as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.getParentInteractTaskListAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFEduActivity>>().map(JSON: dic as! [String : Any] )
            
            self.eduActivitys = responseBaseModel?.model ?? []
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
}
