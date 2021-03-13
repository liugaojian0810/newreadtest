//
//  HFSchduleClass.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

class SchduleItem: Mappable {
    /*
     {
     "courseDetails": "",  //课程详情
     "courseIntroduction": "图文识字第一节", //课程简介
     "courseName": "识字课堂",  //课程名称
     "courseStudy": "1", // 0：未开始学习 1：已结束学习，app图片右上角图标当值是0 是加锁状态
     "studyDate": "2020-06-22",  // 上课日期
     "studyTime": "08:30",     //  上课时间
     "week":"星期一"          // 周几
     "thisCourseStudy": "1"   // 当前课程是否展示在屏幕中间位置 0：不是 1：是
     "backgImage": "1"，   // 背景图片地址
     "backgColor": "1",   // 背景颜色
     },
     */
    
    var courseDetails : String? = ""
    var courseIntroduction : String? = ""
    var courseName : String? = ""
    var courseStudy : Int? = 1
    var studyDate : String?  = ""
    var studyTime : String?  = ""
    var studyEndTime : String?  = ""
    var birthday : String?  = ""
    var week : String?  = ""
    var thisCourseStudy : Int?  = 0
    var backgImage : String?  = ""
    var backgColor : String?  = ""

    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        courseDetails  <- map["courseDetails"]
        courseIntroduction  <- map["courseIntroduction"]
        courseName  <- map["courseName"]
        courseStudy  <- map["courseStudy"]
        studyDate  <- map["studyDate"]
        studyTime  <- map["studyTime"]
        birthday  <- map["birthday"]
        week  <- map["week"]
        backgImage  <- map["backgImage"]
        backgColor  <- map["backgColor"]
        studyEndTime  <- map["studyEndTime"]
    }
    
}


class SchduleClass: Mappable {
    
    
    var errorMessage : String?
    var errorCode : Int?
    var success : Bool?
    
    /// 存放课表的数组
    var model: [SchduleItem]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        errorMessage  <- map["errorMessage"]
        errorCode  <- map["errorCode"]
        success  <- map["success"]
        model  <- map["model"]
    }
    
}
