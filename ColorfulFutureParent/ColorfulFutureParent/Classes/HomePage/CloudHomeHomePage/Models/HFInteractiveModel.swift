//
//  HFInteractiveModel.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by DH Fan on 2021/2/8.
//  Copyright © 2021 huifan. All rights reserved.
//
// 互动营数据模型

import Foundation
import ObjectMapper


class HFKindergartenInteractionResultList : Mappable {

    var kindergartenInteractionResultList: [HFInteractiveModel] = []
    var startDate: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        kindergartenInteractionResultList    <- map["kindergartenInteractionResultList"]
        startDate    <- map["startDate"]
    }
    
}


class HFInteractiveModel : Mappable {
    /*
     string    互动类型业务主键
 model->gsId    string    科目业务主键
 model->kiiPlayStartTime    datetime    开始时间
 model->kiiPlayEndTime    datetime    结束时间
 model->ktId    string    教师id
 model->ktName    string    教师名称
 model->ktAvatarUrl    string    教师头像url
 model->gradeName    string    年级名称
 model->gradeId    string    年级id
 model->csName    string    科目名称
 model->ciName    string    互动类型名称
 model->ciStudentNum    int    学员数量
 model->alreadyJoinStudentNum    int    已报名学员数量
 model->refundGemStone    int    退回宝石
 model->paymentGemStone    int    实付宝石
 model->needGemStone    int    所需宝石
 model->actionStatus    int    活动状态；0：正常；1：异常；
 model->actionStatusContent    string    活动状态内容；
 model->csstName    string    科目阶段名称
 model->SignRecord->kisId    string    报名业务主键id
 model->SignRecord->kiiId    string    互动营业务主键id
 model->SignRecord->kpId    string    家长id
 model->SignRecord->kpName    string    家长名称
 model->SignRecord->kbId    string    kbName
 model->SignRecord->kbAvatarUrl    string    宝宝头像url
 model->SignRecord->parentReportId    string    家长报告id
 model->SignRecord->teacherReportId    string    教师报告id
 model->taskList->gatAttach    string    小任务附件url
 model->taskList->gatId    string    小任务id
 model->taskList->gatIntro    string    小任务简介
     */
    
    var ciId: String = ""
    var kiiPlayStartTime: String = ""
    var ktName: String = ""
    var csName: String = ""
    var kiiPlayStartDate: String = ""
    var ciName: String = ""
    var alreadyJoinStudentNum: Int = 0
    
    var needGemStone: Int = 0
    var paymentGemStone: Int = 0
    var refundGemStone: Int = 0
    // 0：正常；1：异常；
    var actionStatus: Int = 0
    // 活动状态内容；
    var actionStatusContent = ""
    
    var ciStudentNum: Int = 0
    var gradeName: String = ""
    var gsId: String = ""
    var kcId: String = ""
    var kiId: String = ""
    var kiName: String = ""
    var kiiPlayEndTime: String = ""
    var ktId: String = ""
    var ktAvatarUrl: String = ""
    var csstName: String = ""
    var gradeId: String = ""
    var kiiId: String = ""
    
    var systemDate: String = ""
    var ciTeacherNum: Int = 0
    var avgStar: Int = 0
    
    /// 互动报告详情返回字段
    var kbName: String = ""
    var kirpContent: String = ""
    // 教师报告发布状态；0：保存；1：发布；
    var kirtPublishStatus: Int = 0
    var kirtId: String = ""
    var kbId: String = ""
    var kbAvatarUrl: String = ""
    
    /// 我参与的互动营活动列表
    var kisId = ""
    var parentReportId = ""
    var teacherReportId = ""
    var isTeacherSendReport = 0
    var isParentsSendReport = 0
    
    // 预约的宝宝
    var signRecordList: [HFInteractBabyModel] = []
    // 小任务列表
    var taskList: [HFInteractTaskModel] = []
    
    // 即将开始
    var isAboutToStart = false
    var isToday = false
    var timeIntervalString = "00:00:00"
    var isCancel = false
    
    var interactiveType: CloudHomeInteractiveType{
        get {
            isAboutToStart = false
            let startTime = Date.string2Date(kiiPlayStartTime)
            let endTime = Date.string2Date(kiiPlayEndTime)
            let serverDate = Date.serverDate()
            let interval1 = startTime.timeIntervalSince(serverDate)
            isToday = startTime.isToday()
            if 0 < interval1 {
                isAboutToStart = interval1 < 15 * 60
                if isAboutToStart {
                    let hours = Int(interval1 / 3600)
                    let minute = Int((interval1.truncatingRemainder(dividingBy: 3600))/60)
                    let second = Int(interval1.truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60))
                    timeIntervalString = String.init(format: "%.2d:%.2d:%.2d", hours,minute,second)
                }else{
                    timeIntervalString = "00:00:00"
                }
                return .noBegin
            }
            let interval2 = endTime.timeIntervalSince(serverDate)
            if 0 < interval2 {
                return .being
            }
            return .end
        }
    }
    
    /// 是否已预约，默认为false
    var isSubscribe = false
    
    /// 是否评价
    var isSendReport = false
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ciId    <- map["ciId"]
        kiiPlayStartTime    <- map["kiiPlayStartTime"]
        ktName    <- map["ktName"]
        csName    <- map["csName"]
        kiiPlayStartDate    <- map["kiiPlayStartDate"]
        ciName    <- map["ciName"]
        alreadyJoinStudentNum    <- map["alreadyJoinStudentNum"]
        
        needGemStone    <- map["needGemStone"]
        paymentGemStone    <- map["paymentGemStone"]
        refundGemStone    <- map["refundGemStone"]
        actionStatus <- map["actionStatus"]
        
        ciStudentNum    <- map["ciStudentNum"]
        gradeName    <- map["gradeName"]
        gsId    <- map["gsId"]
        kcId    <- map["kcId"]
        kiId    <- map["kiId"]
        kiName    <- map["kiName"]
        kiiPlayEndTime    <- map["kiiPlayEndTime"]
        ktId    <- map["ktId"]
        ktAvatarUrl    <- map["ktAvatarUrl"]
        csstName    <- map["csstName"]
        gradeId    <- map["gradeId"]
        kiiId    <- map["kiiId"]
        
        systemDate    <- map["systemDate"]
        ciTeacherNum    <- map["ciTeacherNum"]
        avgStar    <- map["avgStar"]
        
        kbName    <- map["kbName"]
        kirpContent    <- map["kirpContent"]
        kirtPublishStatus <- map["kirtPublishStatus"]
        kirtId    <- map["kirtId"]
        kbId    <- map["kbId"]
        kbAvatarUrl    <- map["kbAvatarUrl"]
        
        kisId <- map["kisId"]
        parentReportId <- map["parentReportId"]
        teacherReportId <- map["teacherReportId"]
        isTeacherSendReport <- map["isTeacherSendReport"]
        isParentsSendReport <- map["isParentsSendReport"]
        
        signRecordList <- map["signRecordList"]
        taskList <- map["taskList"]
        
        isSendReport <- map["isSendReport"]
    }
    
}
