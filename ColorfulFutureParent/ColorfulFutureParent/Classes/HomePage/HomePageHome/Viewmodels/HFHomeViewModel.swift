//
//  HFHomeViewModel.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/3/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

enum HFHomePageStatus: Int {
    case notJoinKinder = 0
    case notOpenCloud = 1
    case overdue = 2
    case normal = 3
}

class HFHomeViewModel {
    
    //单例创建
    static let shared = HFHomeViewModel()
    
    init() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 首页聚合数据
    var homeModel: HFHomeModel?
    
    /// 获取首页聚合数据
    func getHomeDate(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.getParentHomeAPI, para: [:], successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            
            let responseBaseModel = Mapper<HFResponseBaseModel<HFHomeModel>>().map(JSON: dic as! [String : Any] )
            
            self.homeModel = responseBaseModel?.model
            
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 云家园首页聚合数据
    var cloudHomeModel: HFCloudHomeModel?
    
    var cloudHomeDataSource: [Any] = []
    
    /// 获取云家园首页聚合数据
    func getCloudHomeDate(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.getParentCloudHomeAPI, para: [:], successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            
            let responseBaseModel = Mapper<HFResponseBaseModel<HFCloudHomeModel>>().map(JSON: dic as! [String : Any] )
            
            self.cloudHomeModel = responseBaseModel?.model
            
            if self.cloudHomeModel != nil {
                self.handleCloudHomeData()
            }
            
            successClosure()
        }) { (error) in
            
            // TODO:调试数据
            let dic = [
              "code":70200,
              "message":"成功",
              "model":[
                "reportTime":"2月8日",
                "todayKindergartenInteractionList":[
                  [
                    "kiName":"互动名称",
                    "csName":"宝贝学语言",
                    "csstName":"启蒙阶段",
                    "gradeName":"小班",
                    "kiiPlayStartTime":"开始时间",
                    "kiiPlayEndTime":"结束时间"
                  ],
                  [
                    "kiName":"互动名称",
                    "csName":"宝贝学语言",
                    "csstName":"启蒙阶段",
                    "gradeName":"小班",
                    "kiiPlayStartTime":"开始时间",
                    "kiiPlayEndTime":"结束时间"
                  ]
                ],
                "KindergartenInteractionList":[
                  [
                    "ciName":"1对5",
                    "ciStudentNum":5,
                    "joinStudentNum":2,
                    "csName":"宝贝学语言",
                    "csstName":"启蒙阶段",
                    "kiiPlayStartTime":"开始时间",
                    "kiiPlayEndTime":"结束时间",
                    "ktName":"张多多",
                    "ktAvatarUrl":"教师头像"
                  ],
                  [
                    "ciName":"1对5",
                    "ciStudentNum":5,
                    "joinStudentNum":2,
                    "csName":"宝贝学语言",
                    "csstName":"启蒙阶段",
                    "kiiPlayStartTime":"开始时间",
                    "kiiPlayEndTime":"结束时间",
                    "ktName":"张多多",
                    "ktAvatarUrl":"教师头像"
                  ]
                ]
              ],
              "success":true
            ] as [String: AnyObject]
            let responseBaseModel = Mapper<HFResponseBaseModel<HFCloudHomeModel>>().map(JSON: dic as! [String : Any] )
            
            self.cloudHomeModel = responseBaseModel?.model
            
            if self.cloudHomeModel != nil {
                self.handleCloudHomeData()
            }
            
            successClosure()
            
//            failClosure()
        }
    }
    
    private func handleCloudHomeData() -> Void {
        cloudHomeDataSource.removeAll()
        if !cloudHomeModel!.reportTime.isEmptyStr() {
            cloudHomeDataSource.append(HFCloudHomeItem.init(title: "", data: cloudHomeModel!.reportTime))
        }
        cloudHomeDataSource.append(HFCloudHomeItem.init(title: "今日互动活动", data: cloudHomeModel!.todayKindergartenInteractionList))
        cloudHomeDataSource.append(HFCloudHomeItem.init(title: "推荐互动活动", data: cloudHomeModel!.KindergartenInteractionList))
    }
}
