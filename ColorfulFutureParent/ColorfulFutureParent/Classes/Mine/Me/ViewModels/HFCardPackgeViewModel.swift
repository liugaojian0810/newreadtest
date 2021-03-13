//
//  HFCardPackgeViewModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/3/2.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class HFCardPackgeViewModel: NSObject {

    
    /// 卡包列表
    var cards = [HFMemCardPackageList]()
    
    /// 卡包列表数据请求
    func getCards(_ page: Int, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["pageNum"] = page as AnyObject
        parameters["pageSize"] = 20 as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFMemAPI.CardpackageAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponsePageBaseModel<HFMemCardPackageList>>().map(JSON: dic["model"] as! [String : Any])
            if page == 1 {
                self.cards.removeAll()
            }
            self.cards += responseBaseModel?.list ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 卡使用
    func useCard(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFMemAPI.UseCardpackageAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
}
