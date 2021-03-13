//
//  HFBabyViewModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

let currentBabyId = "HFCurrentBabyID"

class HFBabyViewModel: NSObject {
    
    static let shared = HFBabyViewModel()
    
    // 当前选中的宝宝
    @objc dynamic var currentBaby: HFBabyModel? {
        didSet {
            // 将宝宝Id存储本地
            UserDefaults.standard.setValue(currentBaby?.ciId, forKey: currentBabyId)
        }
    }
    
    var babys: [HFBabyModel] = [] {
        didSet {
            if let ciId = UserDefaults.standard.value(forKey: currentBabyId) as? String {
                // 记录是否有当前选择的宝宝
                var haveCurrentBaby = false
                for babyModel in babys {
                    if babyModel.ciId == ciId {
                        // 更新当前选中宝宝数据
                        currentBaby = babyModel
                        haveCurrentBaby = true
                        break
                    }
                }
                if !haveCurrentBaby {
                    // 同步宝宝后没有了当前选中的宝宝
                    currentBaby = babys.first
                }
            }else{
                currentBaby = babys.first
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 同步宝宝列表
    static func syncChilds(successClosure: @escaping ()->(), failClosure: @escaping ()->()) -> Void {
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.GetCutChildListAPI, para: [:], successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFBabyModel>>().map(JSON: dic as! [String : Any] )
            
            let shared = HFBabyViewModel.shared
            shared.babys = responseBaseModel?.model ?? []
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
}
