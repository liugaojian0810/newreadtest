//
//  HFEduActivitiesModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2021/1/30.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper


// MARK: 课表

class HFEduActivitiesDataList : Mappable {
    
    var introduction: String = ""
    var xLocation: Int = 0
    var name: String = ""
    var colorRandom: String = ""
    var yLocation: Int = 0
    var show: Bool = false // 默认不显示

    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        introduction    <- map["introduction"]
        xLocation    <- map["xLocation"]
        name    <- map["name"]
        colorRandom    <- map["colorRandom"]
        yLocation    <- map["yLocation"]
    }
    
}


class HFEduActivitiesXAxisData : Mappable {
    
    var date: String = ""
    var sign: Int = 0
    var week: Int = 0
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        date    <- map["date"]
        sign    <- map["sign"]
        week    <- map["week"]
    }
}

class HFEduActivitiesYAxisData : Mappable {
    
    var sign: Int = 0
    var thisStartDate: String = ""
    var endDate: String = ""
    var markDate: String = ""
    var startDate: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        sign    <- map["sign"]
        thisStartDate    <- map["thisStartDate"]
        endDate    <- map["endDate"]
        markDate    <- map["markDate"]
        startDate    <- map["startDate"]
    }
}


class HFEduActivitiesCurriculumType : Mappable {
    
    var curriculumType: String = ""
    
    var dataList: [HFEduActivitiesDataList]?
    var xAxisData: [HFEduActivitiesXAxisData]?
    var yAxisData: [HFEduActivitiesYAxisData]?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        curriculumType    <- map["curriculumType"]
        dataList    <- map["dataList"]
        xAxisData    <- map["xAxisData"]
        yAxisData    <- map["yAxisData"]
    }
    
}

class HFEduActivitiesModel : Mappable {
    
    var curriculumName: String = ""
    var curriculumType: HFEduActivitiesCurriculumType?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        curriculumName    <- map["curriculumName"]
        curriculumType    <- map["curriculumType"]
    }
}


// MARK: 成长营教育活动安排管理 活动列表

class HFEduActivity: Mappable {
    
    var gaName: String = ""
    var gasId: String = ""
    var gasStartTime: String = ""
    var gasdId: String = ""
    var gasEndTime: String = ""
    var cssName: String = ""
    var gasDate: String = ""
    var gaImgCoverUrl: String = ""
    var gaTeachFocus: String = ""
    var gaId: String = ""
    var grownActionTaskList: [HFInteractTaskModel] = []
    
    // 互动营选择小任务时是否展开
    var isOpen = false
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gaName    <- map["gaName"]
        gasId    <- map["gasId"]
        gasStartTime    <- map["gasStartTime"]
        gasdId    <- map["gasdId"]
        gasEndTime    <- map["gasEndTime"]
        cssName    <- map["cssName"]
        gasDate    <- map["gasDate"]
        gaImgCoverUrl    <- map["gaImgCoverUrl"]
        gaTeachFocus    <- map["gaTeachFocus"]
        gaId    <- map["gaId"]
        grownActionTaskList <- map["grownActionTaskList"]
    }
}

class HFEduActivitieListModel : Mappable {
    
    var gasDate: String = ""
    var grownActionScheduleResult: [HFEduActivity]?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        gasDate    <- map["gasDate"]
        grownActionScheduleResult    <- map["grownActionScheduleResult"]
    }
    
}

// MARK: 教育活动详情

class HFEduActivitieInteractionModel : Mappable {
    
    /**
     成长营部分
     */
    var deleteUid: String = ""
    var gaiWaitTime: Int = 0
    var grownAction: String = ""
    var grownSubject: String = ""
    var updateUid: String = ""
    var gaiImgAnswerUrl: String = ""
    var gaiImgAnswerTrueIndex: Int = 0
    var sort: Int = 0
    var delStatus: Int = 0
    var enableStatus: Int = 0
    var updateName: String = ""
    var updateTime: String = ""
    var gaiType: Int = 0
    var configSubject: String = ""
    var id: Int = 0
    var deleteName: String = ""
    var deleteTime: String = ""
    var configSubjectStage: String = ""
    var gaId: String = ""
    var createName: String = ""
    var createTime: String = ""
    var createUid: String = ""
    var gaiId: String = ""
    var gaiName: String = ""
    var gaiStartTime: Int = 0
    
    /**
     展示课部分
     */
    var saiName: String = ""
    var saiAuditStatus: Int = 0
    var saiImgCoverUrl: String = ""
    var saiTarget: String = ""
    var saiYear: String = ""
    var saiMonth: String = ""
    var saiImgThumbUrl: String = ""
    var saiId: String = ""
//    var createTime: String = ""
    var saiGradeId: String = ""

    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        deleteUid    <- map["deleteUid"]
        gaiWaitTime    <- map["gaiWaitTime"]
        grownAction    <- map["grownAction"]
        grownSubject    <- map["grownSubject"]
        updateUid    <- map["updateUid"]
        gaiImgAnswerUrl    <- map["gaiImgAnswerUrl"]
        gaiImgAnswerTrueIndex    <- map["gaiImgAnswerTrueIndex"]
        sort    <- map["sort"]
        delStatus    <- map["delStatus"]
        enableStatus    <- map["enableStatus"]
        updateName    <- map["updateName"]
        updateTime    <- map["updateTime"]
        gaiType    <- map["gaiType"]
        configSubject    <- map["configSubject"]
        id    <- map["id"]
        deleteName    <- map["deleteName"]
        deleteTime    <- map["deleteTime"]
        configSubjectStage    <- map["configSubjectStage"]
        gaId    <- map["gaId"]
        createName    <- map["createName"]
        createTime    <- map["createTime"]
        createUid    <- map["createUid"]
        gaiId    <- map["gaiId"]
        gaiName    <- map["gaiName"]
        gaiStartTime    <- map["gaiStartTime"]
        
        /**
         展示课部分
         */
        saiName    <- map["saiName"]
        saiAuditStatus    <- map["saiAuditStatus"]
        saiImgCoverUrl    <- map["saiImgCoverUrl"]
        saiTarget    <- map["saiTarget"]
        saiYear    <- map["saiYear"]
        saiMonth    <- map["saiMonth"]
        saiImgThumbUrl    <- map["saiImgThumbUrl"]
        saiId    <- map["saiId"]
//        createTime    <- map["createTime"]
        saiGradeId    <- map["saiGradeId"]

    }
    
}

class HFEduActivitieTaskModel : Mappable {
    
    var deleteUid: String = ""
    var updateUid: String = ""
    var gatAttach: String = ""
    var gatId: String = ""
    var sort: Int = 0
    var updateName: String = ""
    var delStatus: Int = 0
    var enableStatus: Int = 0
    var updateTime: String = ""
    var id: Int = 0
    var deleteName: String = ""
    var deleteTime: String = ""
    var configSubjectStage: String = ""
    var gaId: String = ""
    var gatIntro: String = ""
    var createName: String = ""
    var createTime: String = ""
    var createUid: String = ""
    var grownAction: String = ""
    var grownSubject: String = ""
    
    /**
     展示课部分
     */
    var satImgAnswerTrueIndex: Int = 0
    var satName: String = ""
    var satType: Int = 0
    var satImgAnswerUrl: String = ""
    var satStartTime: Int = 0
    var satWaitTime: Int = 0
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        deleteUid    <- map["deleteUid"]
        updateUid    <- map["updateUid"]
        gatAttach    <- map["gatAttach"]
        gatId    <- map["gatId"]
        sort    <- map["sort"]
        updateName    <- map["updateName"]
        delStatus    <- map["delStatus"]
        enableStatus    <- map["enableStatus"]
        updateTime    <- map["updateTime"]
        id    <- map["id"]
        deleteName    <- map["deleteName"]
        deleteTime    <- map["deleteTime"]
        configSubjectStage    <- map["configSubjectStage"]
        gaId    <- map["gaId"]
        gatIntro    <- map["gatIntro"]
        createName    <- map["createName"]
        createTime    <- map["createTime"]
        createUid    <- map["createUid"]
        grownAction    <- map["grownAction"]
        grownSubject    <- map["grownSubject"]
        
        /**
         展示课部分
         */
        satImgAnswerTrueIndex    <- map["satImgAnswerTrueIndex"]
        satName    <- map["satName"]
        satType    <- map["satType"]
        satImgAnswerUrl    <- map["satImgAnswerUrl"]
        satStartTime    <- map["satStartTime"]
        satWaitTime    <- map["satWaitTime"]
    }
    
}

class HFEduActivitieVideoModel : Mappable {
    
    var deleteUid: String = ""
    var gavId: String = ""
    var gavType: Int = 0
    var updateUid: String = ""
    var bindGavId: String = ""
    var updateName: String = ""
    var sort: Int = 0
    var updateTime: String = ""
    var delStatus: Int = 0
    var enableStatus: Int = 0
    var gavVideoUrl: String = ""
    var id: Int = 0
    var deleteName: String = ""
    var deleteTime: String = ""
    var gaId: String = ""
    var createName: String = ""
    var createTime: String = ""
    var createUid: String = ""
    var grownAction: String = ""
    var grownSubject: String = ""
    
    /**
     展示课部分
     */
    var savType: Int = 0
    var savVideoUrl: String = ""
    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        deleteUid    <- map["deleteUid"]
        gavId    <- map["gavId"]
        gavType    <- map["gavType"]
        updateUid    <- map["updateUid"]
        bindGavId    <- map["bindGavId"]
        updateName    <- map["updateName"]
        sort    <- map["sort"]
        updateTime    <- map["updateTime"]
        delStatus    <- map["delStatus"]
        enableStatus    <- map["enableStatus"]
        gavVideoUrl    <- map["gavVideoUrl"]
        id    <- map["id"]
        deleteName    <- map["deleteName"]
        deleteTime    <- map["deleteTime"]
        gaId    <- map["gaId"]
        createName    <- map["createName"]
        createTime    <- map["createTime"]
        createUid    <- map["createUid"]
        grownAction    <- map["grownAction"]
        grownSubject    <- map["grownSubject"]
        
        /**
         展示课部分
         */
        savType    <- map["savType"]
        savVideoUrl    <- map["savVideoUrl"]
    }
    
}




class HFEduActivitieDetailModel : Mappable {
    
    var gaTeachDifficult: String = ""
    var gaName: String = ""
    var gaImgThumbUrl: String = ""
    var cssName: String = ""
    var gaTeachFocus: String = ""
    var gaImgCoverUrl: String = ""
    var gaTeachTarget: String = ""
    var gaId: String = ""
    var gsId: String = ""
    var gaUnitNo: Int = 0
    var csgId: String = ""
    var gaBookNo: Int = 0
    var gaTechNo: Int = 0
    var gsName: String = ""
    var grownActionInteractionList: [HFEduActivitieInteractionModel]?
    var grownActionTaskList: [HFEduActivitieTaskModel]?
    var grownActionVideoList: [HFEduActivitieVideoModel]?


    /**
     展示课部分
     */
    var saiName: String = ""
    var saiAuditStatus: Int = 0
    var saiImgCoverUrl: String = ""
    var saiTarget: String = ""
    var saiGradeName: String = ""
    var saiYear: Int = 0
    var saiMonth: Int = 0
    var saiImgThumbUrl: String = ""
    var saiId: String = ""
    var createTime: String = ""
    var saiGradeId: String = ""
    
    var showActionVideoList: [HFEduActivitieVideoModel]?
    var showActionTaskList: [HFEduActivitieVideoModel]?
    var showActionAuthHistoryList: [String]?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        gaTeachDifficult    <- map["gaTeachDifficult"]
        gaName    <- map["gaName"]
        gaImgThumbUrl    <- map["gaImgThumbUrl"]
        cssName    <- map["cssName"]
        gaTeachFocus    <- map["gaTeachFocus"]
        gaImgCoverUrl    <- map["gaImgCoverUrl"]
        gaTeachTarget    <- map["gaTeachTarget"]
        gaId    <- map["gaId"]
        gsId    <- map["gsId"]
        gaUnitNo    <- map["gaUnitNo"]
        csgId    <- map["csgId"]
        gaBookNo    <- map["gaBookNo"]
        gaTechNo    <- map["gaTechNo"]
        gsName    <- map["gsName"]
        grownActionInteractionList    <- map["grownActionInteractionList"]
        grownActionTaskList    <- map["grownActionTaskList"]
        grownActionVideoList    <- map["grownActionVideoList"]
        
        /**
         展示课部分
         */
        saiName    <- map["saiName"]
        saiAuditStatus    <- map["saiAuditStatus"]
        saiImgCoverUrl    <- map["saiImgCoverUrl"]
        saiTarget    <- map["saiTarget"]
        saiGradeName    <- map["saiGradeName"]
        saiYear    <- map["saiYear"]
        saiMonth    <- map["saiMonth"]
        saiImgThumbUrl    <- map["saiImgThumbUrl"]
        saiId    <- map["saiId"]
        createTime    <- map["createTime"]
        saiGradeId    <- map["saiGradeId"]
        
        showActionVideoList    <- map["showActionVideoList"]
        showActionTaskList    <- map["showActionTaskList"]
        showActionAuthHistoryList    <- map["showActionAuthHistoryList"]
    }
    
}
