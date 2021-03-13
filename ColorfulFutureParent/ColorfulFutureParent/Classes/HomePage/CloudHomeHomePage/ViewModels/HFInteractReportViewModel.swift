//
//  HFInteractReportViewModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/2/23.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

enum HFInteractReportType {
    case readOnly // 只读，对应园长端
    case edit // 编辑，对应教师端
    case share // 分享，对应家长端
}

class HFInteractReportViewModel {
    
    var type: HFInteractReportType = .readOnly
    
    /// 互动营业务id
    var kiiId = ""
    /// 报告id
    var kirtId = ""
    
    /// 互动活动
    var interactiveModel: HFInteractiveModel? {
        didSet {
            if interactiveReportDetailModel == nil {
                interactiveReportDetailModel = interactiveModel
            }
        }
    }
    
    /// 互动报告详情
    var interactiveReportDetailModel: HFInteractiveModel?
    
    /// 加载互动报告详情
    func loadInteractReportDetail(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        /*
         kiiId    必选    string    互动营业务id
         kirtId    可选    string    报告id
         */
        let parameters = [
            "kiiId": kiiId,
            "kirtId": kirtId
        ] as [String : AnyObject]
        var url = ""
        switch HFClientInfo.currentClientType {
        case .ClientTypeKindergarten:
            url = HFCloudHomeAPI.getKindergartenReportDetailAPI
        case .ClientTypeTeacher:
            url = HFCloudHomeAPI.getTeacherReportDetailAPI
        case .ClientTypeParent:
            url = HFCloudHomeAPI.getParentReportDetailAPI
        default:
            break
        }
        HFSwiftService.requestData(requestType: .Get, urlString: url, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFInteractiveModel>>().map(JSON: dic as! [String : Any] )
            
            self.interactiveReportDetailModel = responseBaseModel?.model
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 预约的宝宝
    var interactBabyModel: HFInteractBabyModel? {
        didSet {
            kiiId = interactBabyModel?.kiiId ?? ""
            kirtId = interactBabyModel?.teacherReportId ?? ""
        }
    }
    
    /// 报告内容
    var kirpContent = ""
    /// 是否发布；0：保存；1：发布；
    var publishStatus = 0
    
    /// 发送互动报告
    func sendTeacherReport(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        /*
         kisId    必选    string    报名记录主键id
         kirpContent    必选    string    报告内容
         */
        let parameters = [
            "kisId": interactBabyModel?.kisId as Any,
            "kirpContent": kirpContent,
            "publishStatus": publishStatus
        ] as [String : AnyObject]
        HFSwiftService.requestData(requestType: .Post, urlString: HFCloudHomeAPI.SendTeacherReportAPI, para: parameters, successed: { (response) in
            self.interactBabyModel?.teacherReportPublishStatus = self.publishStatus
            self.interactiveModel?.kirtPublishStatus = self.publishStatus
            self.interactiveModel?.kirpContent = self.kirpContent
            self.interactiveReportDetailModel?.kirtPublishStatus = self.publishStatus
            self.interactiveReportDetailModel?.kirpContent = self.kirpContent
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
}
