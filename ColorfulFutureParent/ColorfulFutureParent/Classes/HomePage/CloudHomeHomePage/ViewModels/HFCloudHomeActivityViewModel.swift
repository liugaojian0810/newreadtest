//
//  HFCloudHomeActivityViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/9.
//  Copyright © 2020 huifan. All rights reserved.
//
import UIKit
import SwiftyJSON
import ObjectMapper

/// 活动类型
enum CloudHomeActivityType {
    case begin //开始活动
    case prepare //准备活动
    case arrange //小班教育活动安排  看回放
}

/// 互动类型
enum CloudHomeInteractiveType: Int {
    case noBegin = 0 //未开始
    case being = 1 //进行中,预约
    case end = 2 //已结束
    case cancel = 3 // 已取消
    case interactiveCamps // 互动营
    case statisticeData // 数据统计
}

/// 课程类型： 成长营 互动赢营  展示课
@objc enum CloudHomeClassType: Int {
    case czy
    case hdy
    case zsk
}

/// 互动活动详情类型
enum HFInteractiveDetailType {
    case subscribe // 预约
    case myInteractive // 我的互动活动
}

/// 家长评价页类型
enum HFInteractiveEvaluateOperationType {
    case edit // 编辑评价
    case read // 查看评价
}

class HFCloudHomeActivityViewModel: NSObject {
    
    /// 互动类型
    var activityState: CloudHomeActivityType = .begin
    
    /// 活动类型
    var activityType: CloudHomeActivityType = .begin
    
    // 活动科目
    var subjects = ["宝贝学语言", "思维空间站", "独立阅读", "全速直呼", "能量数学", "动感写字", "艺术领域", "健康领域", "社会领域", "科学领域"]
    
    /// 互动类型
    var interactiveType: CloudHomeInteractiveType = .noBegin
    
    /// 日期
    var date: String = ""
    
    /// 科目分类业务主键
    var gsId: String = ""
    
    /// 获取服务器时间
    var timeInfo: HFCloudHomeUntilModel?
    
    /// 周信息
    var weekInfo: HFCloudHomeUntilModel?
    
    /// 年级列表
    var grades: [HFCloudHomeUntilModel]?
    
    /// 幼儿园年级列表
    var kiGrades: [HFCloudHomeUntilModel]?
    
    /// 幼儿园年级名称列表
    var kiGradeNames: [String]?
    
    /// 当前所选年级
    var curGrade: HFCloudHomeUntilModel?
    
    /// 班级信息列表
    var clInfoLists: [HFCloudHomeUntilModel]?
    
    /// 教育活动列表
    var activitys: [[HFEduActivitieListModel]]?
    
    /// 当前选中的年纪
    var curActivityIndex: Int = 0
    
    /// 获取服务器时间
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func getSystemTime(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.GetSystemTimeAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFCloudHomeUntilModel>>().map(JSON: dic as! [String : Any])
            self.timeInfo = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 根据日期获取月份周数
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func getWeek(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        /**
         date    string    日期    *
         */
        parameters["date"] = date as AnyObject
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.GetMonthWeekAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFCloudHomeUntilModel>>().map(JSON: dic as! [String : Any])
            self.weekInfo = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 获取年级列表
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func getGrade(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.GetGradeListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFCloudHomeUntilModel>>().map(JSON: dic as! [String : Any])
            self.grades?.removeAll()
            self.grades! += responseBaseModel?.model ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 获取幼儿园年级列表
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func getKiGrade(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.GetKiGradeListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFCloudHomeUntilModel>>().map(JSON: dic as! [String : Any])
            self.kiGrades?.removeAll()
            self.kiGrades! += responseBaseModel?.model ?? []
            let gradeNum = self.kiGrades?.count
            self.activitys?.removeAll()
            self.kiGradeNames?.removeAll()
            for index in 0..<(gradeNum ?? 0) {
                self.activitys?.append([HFEduActivitieListModel]())
                self.kiGradeNames?.append(self.kiGrades![index].grName)
            }
            if (self.kiGrades?.count ?? 0) > 0 {
                self.curGrade = self.kiGrades![0]
                self.curActivityIndex = 0
            }
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 班级信息列表
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func getClassInfoList(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.GetKiClassInfoAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFCloudHomeUntilModel>>().map(JSON: dic as! [String : Any])
            self.clInfoLists?.removeAll()
            self.clInfoLists! += responseBaseModel?.model ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 条件查询教育活动列表
    /// - Parameters:
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func getActivityList(_ page: Int, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        parameters["curPage"] = "\(page)" as AnyObject
        parameters["pageSize"] = "15" as AnyObject
        if !gsId.isEmptyStr() {
            parameters["gsId"] = gsId as AnyObject
        }
        parameters["gasGradeId"] = self.curGrade?.kgrId as AnyObject
        switch activityType {
        case .begin:
            parameters["dateType"] = "0" as AnyObject
        case .prepare:
            parameters["dateType"] = "1" as AnyObject
        default:
            parameters["dateType"] = "2" as AnyObject
        }
        HFSwiftService.requestData(requestType:.Get, urlString: HFCloudHomeAPI.TeacherGetActivityListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponsePageBaseModel<HFEduActivitieListModel>>().map(JSON: dic as! [String : Any])
            var tempArr = self.activitys?[self.curActivityIndex] ?? []
            if page == 1 {
                tempArr.removeAll()
            }
            tempArr += responseBaseModel?.list ?? []
            self.activitys![self.curActivityIndex] = tempArr
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 必选    string    业务主键
    @objc var bId = ""
    
    /// 课程类型
    @objc var courseType: CloudHomeClassType = .zsk
    
    // MARK: 教育活动详情
    
    /// 教育活动对象
    public var acticityDetail: HFEduActivitieDetailModel?
    
    @objc func quaryActicityDetail(_ successClosure:@escaping OptionClosure, _ failClosure:@escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["bId"] = bId as AnyObject
        var urlStr = ""
        switch courseType {
        case .czy:
            urlStr = HFCloudHomeAPI.KiGetActivityDetailAPI
        case .hdy:
            urlStr = HFCloudHomeAPI.KiGetActivityDetailAPI
        default:
            urlStr = HFCloudHomeAPI.KIGetDisPlayClassDetailAPI
        }
        HFSwiftService.requestData(requestType: .Get, urlString: urlStr, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFEduActivitieDetailModel>>().map(JSON: dic as! [String : Any])
            self.acticityDetail = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    // MARK: 视频地址
    
    /// 视频id
    @objc var vId1 = ""
    @objc var vId2 = ""
    
    /// 视频对象
    public var savType1VideoModel: HFVideoDetailModel?
    /// 视频对象
    public var savType2VideoModel: HFVideoDetailModel?
    
    /// 视频播放地址
    @objc var courseVideoURL: String{
        get{
            return savType1VideoModel?.videoUrl?.last?.originUrl ?? ""
        }
    }
    
    /// 视频播放地址
    @objc var liveVideoURL: String {
        get{
            return savType2VideoModel?.videoUrl?.last?.originUrl ?? ""
        }
    }
    
    /// 根据网宿视频id换视频信息
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    @objc func quaryActicityPlayUrl(_ savType1: Bool, _ successClosure:@escaping OptionClosure, _ failClosure:@escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        if savType1 {
            parameters["videoId"] = vId1 as AnyObject
        }else{
            parameters["videoId"] = vId2 as AnyObject
        }
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.GetPlayUrlAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFVideoDetailModel>>().map(JSON: dic as! [String : Any])
            if savType1 {
                self.savType1VideoModel = responseBaseModel?.model
            }else{
                self.savType2VideoModel = responseBaseModel?.model
            }
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 互动任务
    @objc var interactiveTasks = [HFInteractiveTasks]()
    
    /// 任务类型；0：教育活动互动任务；1：展示活动互动任务；
    @objc var actionType = "1"
    
    /// 获取互动任务列表
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    @objc func quaryActicityInteractiveTasks(_ successClosure:@escaping OptionClosure, _ failClosure:@escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        /**
         actionId    必选    string    活动业务id
         actionType    必选    int    任务类型；0：教育活动互动任务；1：展示活动互动任务；
         */
        parameters["actionType"] = actionType as AnyObject
        parameters["actionId"] = bId as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.GetInteractiveTasksAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFInteractiveTasks>>().map(JSON: dic as! [String : Any])
            self.interactiveTasks.removeAll()
            self.interactiveTasks += responseBaseModel?.model ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    // 数据模型数组
    // 互动活动列表数据模型数组
    var interactionModels: [HFKindergartenInteractionResultList] = []
    
    // 互动活动列表总数
    var interactionTotal = 0
    
    /// 加载互动活动列表
    func loadInteractiveList(pageNum: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["page"] = pageNum as AnyObject
        parameters["size"] = 20 as AnyObject
        
        var url = ""
        switch HFClientInfo.currentClientType {
        case .ClientTypeKindergarten:
            url = HFCloudHomeAPI.getKindergartenInteractionListAPI
        case .ClientTypeTeacher:
            url = HFCloudHomeAPI.getTeacherInteractionListAPI
        case .ClientTypeParent:
            url = HFCloudHomeAPI.getParentInteractionListAPI
        default:
            break
        }
        
        switch interactiveType {
        case .noBegin,.being,.end:
            parameters["dateType"] = interactiveType.rawValue as AnyObject
        default:
            break
        }
        parameters["kbId"] = HFBabyViewModel.shared.currentBaby?.ciId as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: url, para: parameters, successed: { (response) in
            
            self.handleInteractiveList(response: response)
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 加载互动营列表
    func loadInteractiveCampList(pageNum: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        var parameters = [String: AnyObject]()
        parameters["page"] = pageNum as AnyObject
        parameters["size"] = 20 as AnyObject
        parameters["kbId"] = HFBabyViewModel.shared.currentBaby?.ciId as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.getParentInteractionListAPI, para: parameters, successed: { (response) in
            
            self.handleInteractiveList(response: response)
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 加载我参与的互动营活动列表
    func loadJoinInteractiveList(pageNum: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        var parameters = [String: AnyObject]()
        parameters["page"] = pageNum as AnyObject
        parameters["size"] = 20 as AnyObject
        parameters["dateType"] = interactiveType.rawValue as AnyObject
        parameters["kbId"] = HFBabyViewModel.shared.currentBaby?.ciId as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.getParentJoinInteractionListAPI, para: parameters, successed: { (response) in
            
            self.handleInteractiveList(response: response)
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 处理互动列表数据
    private func handleInteractiveList(response: [String: Any]) -> Void {
        let dic = NSDictionary(dictionary: response as [String: AnyObject])
        let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFKindergartenInteractionResultList>>>().map(JSON: dic as! [String : Any] )
        
        if responseBaseModel?.model?.pageNum == 1 {
            self.interactionModels.removeAll()
        }
        // 处理同一日期截成两页的情况
        var list = responseBaseModel?.model?.list ?? []
        if self.interactionModels.count != 0 && list.count != 0 {
            let lastModel = self.interactionModels.last
            let firstModel = list.first
            if lastModel!.startDate == firstModel!.startDate {
                lastModel!.kindergartenInteractionResultList += firstModel!.kindergartenInteractionResultList
                list.removeFirst()
            }
        }
        self.interactionModels += list
        self.interactionTotal = responseBaseModel?.model?.total ?? 0
    }
    
    /// 互动活动详情
    var detailType: HFInteractiveDetailType = .subscribe
    
    /// 互动活动详情模型
    var interactiveDetailModel: HFInteractiveModel? {
        didSet {
            kiiId = interactiveDetailModel?.kiiId ?? ""
        }
    }
    
    /// 互动营业务id
    var kiiId = ""
    
    /// 加载互动活动详情
    func loadInteractiveDetail(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        var parameters = [String: AnyObject]()
        parameters["kiiId"] = kiiId as AnyObject
        parameters["kbId"] = HFBabyViewModel.shared.currentBaby?.ciId as AnyObject
        parameters["kisId"] = interactiveDetailModel?.kisId as AnyObject
        var url = ""
        switch HFClientInfo.currentClientType {
        case .ClientTypeKindergarten:
            url = HFCloudHomeAPI.getKindergartenInteractionDetailAPI
        case .ClientTypeTeacher:
            url = HFCloudHomeAPI.getTeacherInteractionDetailAPI
        case .ClientTypeParent:
            url = HFCloudHomeAPI.getParentInteractionDetailAPI
        default:
            break
        }
        
        HFSwiftService.requestData(requestType: .Get, urlString: url, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFInteractiveModel>>().map(JSON: dic as! [String : Any] )
            
            self.interactiveDetailModel = responseBaseModel?.model
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 宝石余额
    var gemBalance: Double = 0
    
    // TODO:获取宝石余额接口暂无
    /// 获取宝石余额
    func loadGemBalance(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
//        HFSwiftService.requestData(requestType: .Get, urlString: url, para: parameters, successed: { (response) in
//
//            let dic = NSDictionary(dictionary: response as [String: AnyObject])
//            let responseBaseModel = Mapper<HFResponseBaseModel<HFInteractiveModel>>().map(JSON: dic as! [String : Any] )
//
//            self.interactiveDetailModel = responseBaseModel?.model
            
            successClosure()
            
//        }) { (error) in
//
//            failClosure()
//        }
    }
    
    var interactCourseDetailItems: [[HFInteractCourseDetailItem]] {
        get {
            if let model = interactiveDetailModel {
                
                var firstItems: [HFInteractCourseDetailItem] = []
                firstItems.append(HFInteractCourseDetailItem.init(title: "互动活动", contetText: "\(model.ciTeacherNum)对\(model.ciStudentNum) 直播互动", contetAttributed: nil))
                firstItems.append(HFInteractCourseDetailItem.init(title: "互动时间", contetText: "\(model.kiiPlayStartDate.substring(from: 5)) \(model.kiiPlayStartTime.subString(rang: NSRange.init(location: 11, length: 5)))-\(model.kiiPlayEndTime.subString(rang: NSRange.init(location: 11, length: 5)))", contetAttributed: nil))
                firstItems.append(HFInteractCourseDetailItem.init(title: "互动教师", contetText: model.ktName, contetAttributed: nil))
                firstItems.append(HFInteractCourseDetailItem.init(title: "互动科目", contetText: "\(model.csName)-\(model.csstName)", contetAttributed: nil))
                firstItems.append(HFInteractCourseDetailItem.init(title: "互动人数", contetText: "\(interactiveDetailModel?.ciTeacherNum ?? 0)对\(interactiveDetailModel?.ciStudentNum ?? 0)", contetAttributed: nil))
                let alreadyJoinStudentNum = "\(model.alreadyJoinStudentNum)"
                let att = NSMutableAttributedString.init(string: "预约宝宝：\(alreadyJoinStudentNum)/\(model.ciStudentNum)")
                att.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x00B8FF)], range: NSRange.init(location: 5, length: alreadyJoinStudentNum.length()))
                firstItems.append(HFInteractCourseDetailItem.init(title: "预约宝宝", contetText: "", contetAttributed: att))
                
                var secondItems: [HFInteractCourseDetailItem] = []
                let suffixAttb = NSAttributedString.init(string: "枚", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x666666),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-BD", size: 13) ?? .systemFont(ofSize: 13)])
                if detailType == .subscribe {
                    let needGemStoneAttb = NSMutableAttributedString.init(string: "\(model.needGemStone)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xFF844B),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-BD", size: 18) ?? .systemFont(ofSize: 18)])
                    needGemStoneAttb.append(suffixAttb)
                    secondItems.append(HFInteractCourseDetailItem.init(title: "所需宝石", contetText: "", contetAttributed: needGemStoneAttb))
                    
                    let gemBalanceAttb = NSMutableAttributedString.init(string: "\(gemBalance)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x04BFF7),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-BD", size: 14) ?? .systemFont(ofSize: 14)])
                    gemBalanceAttb.append(suffixAttb)
                    secondItems.append(HFInteractCourseDetailItem.init(title: "宝石余额", contetText: "", contetAttributed: gemBalanceAttb))
                }else{
                    let needGemStoneAttb = NSMutableAttributedString.init(string: "\(model.needGemStone)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x999999),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-MD", size: 17) ?? .systemFont(ofSize: 17)])
                    needGemStoneAttb.append(suffixAttb)
                    secondItems.append(HFInteractCourseDetailItem.init(title: "所需宝石", contetText: "", contetAttributed: needGemStoneAttb))
                    
                    let paymentGemStoneAttb = NSMutableAttributedString.init(string: "\(model.paymentGemStone)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xFF844B),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-BD", size: 20) ?? .systemFont(ofSize: 20)])
                    paymentGemStoneAttb.append(suffixAttb)
                    secondItems.append(HFInteractCourseDetailItem.init(title: "实付宝石", contetText: "", contetAttributed: paymentGemStoneAttb))
                    
                    let refundGemStoneAttb = NSMutableAttributedString.init(string: "\(model.refundGemStone)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x00B8FF),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-MD", size: 20) ?? .systemFont(ofSize: 20)])
                    refundGemStoneAttb.append(suffixAttb)
                    secondItems.append(HFInteractCourseDetailItem.init(title: "退回宝石", contetText: "", contetAttributed: refundGemStoneAttb))
                }
                return [firstItems,secondItems]
            }else{
                return []
            }
        }
    }
    
    /// 预约选择的小任务
    var taskModels: [HFInteractTaskModel] = []
    
    /// 预约互动活动
    func subscribeInteractive(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        /*
         kiiId    必选    教育活动业务主键    *
         kpId    必选    string    家长id
         kbId    必选    string    宝宝id
         gatId    可选    string    小任务id
         */
        let parameters = [
            "kiiId":kiiId,
            "kpId":HFUserInformation.userInfo()?.usrId as Any,
            "kbId":HFBabyViewModel.shared.currentBaby?.ciId as Any,
            "gatId":taskModels.first?.gatId as Any
        ] as [String : AnyObject]
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.subscribeInteractiveAPI, para: parameters, successed: { (response) in
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 取消预约互动活动
    func cancelSubscribeInteractive(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        let parameters = [
            "kiiId":kiiId,
            "kbId":HFBabyViewModel.shared.currentBaby?.ciId as Any,
        ] as [String : AnyObject]
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.cancelSubscribeInteractiveAPI, para: parameters, successed: { (response) in
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    
    // MARK:家长评价
    
    
    var interactiveEvaluateOperationType: HFInteractiveEvaluateOperationType = .edit
    
    /// 评价平均分
    var kirpScoreAverage: Int {
        get {
            if interactiveEvaluateOperationType == .edit {
                var totalScore = 0
                evaluateDataArr.forEach { (model) in
                    totalScore += model.starNum
                }
                return totalScore / evaluateDataArr.count
            }else{
                return self.interactiveEvaluateDetailModel?.kirpScoreAverage ?? 0
            }
        }
    }
    /// 评价内容
    var kirpContent = ""
    /// 编辑评价是使用数据
    var evaluateDataArr: [HFInteractiveEvaluateItemModel] = [HFInteractiveEvaluateItemModel.init(ceId: 1, ceName: "吐字清晰"),
                                                             HFInteractiveEvaluateItemModel.init(ceId: 2, ceName: "课前预热"),
                                                             HFInteractiveEvaluateItemModel.init(ceId: 2, ceName: "善于互动"),
                                                             HFInteractiveEvaluateItemModel.init(ceId: 2, ceName: "备课充分")]
    
    var evaluateList: [HFInteractiveEvaluateItemModel] {
        get{
            if interactiveEvaluateOperationType == .edit {
                return evaluateDataArr
            }else{
                return self.interactiveEvaluateDetailModel?.evaluateList ?? []
            }
        }
    }
    
    /// 互动营报名信息业务主键
    var kisId = ""
    
    /// 家长评价
    func commitInteractionReport(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        let parameters = [
            "kbId":HFBabyViewModel.shared.currentBaby?.ciId as Any,
            "kisId":kisId,
            "kirpScoreAverage":kirpScoreAverage,
            "evaluateList":evaluateDataArr.toJSON(),
            "kirpContent":kirpContent
        ] as [String : AnyObject]
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.createParentInteractiveReportAPI, para: parameters, successed: { (response) in
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 评价详情
    var interactiveEvaluateDetailModel: HFInteractiveEvaluateDetailModel?
    
    /// 获取家长评价详情
    func getInteractiveReportDetail(_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        let parameters = [
            "kisId":kisId,
            "kpId":HFUserInformation.userInfo()?.usrId as Any,
            "kbId":HFBabyViewModel.shared.currentBaby?.ciId as Any
        ] as [String : AnyObject]
        HFSwiftService.requestData(requestType: .Get, urlString: HFCloudHomeAPI.getInteractiveParentReportDetailAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFInteractiveEvaluateDetailModel>>().map(JSON: dic as! [String : Any])
            
            self.interactiveEvaluateDetailModel = responseBaseModel?.model
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
}


