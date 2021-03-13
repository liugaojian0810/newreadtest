//
//  HFIDCardInfo.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/12/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

struct HFIDCardInfoDetial: Mappable {

//    用于校验身份证号码、性别、出生是否一致，输出结果及其对应关系如下：
//    -1: 身份证正面所有字段全为空
//    0: 身份证证号识别错误
//    1: 身份证证号和性别、出生信息一致
//    2: 身份证证号和性别、出生信息都不一致
//    3: 身份证证号和出生信息不一致
//    4: 身份证证号和性别信息不一致

    var idcard_number_type = -1
//    normal-识别正常
//    reversed_side-身份证正反面颠倒
//    non_idcard-上传的图片中不包含身份证
//    blurred-身份证模糊
//    other_type_card-其他类型证照
//    over_exposure-身份证关键字段反光或过曝
//    over_dark-身份证欠曝（亮度过低）
//    unknown-未知状态
    var image_status       = ""
    var log_id       = 0 // 定位问题id
    var address      = ""   // 住址 南京市江宁区弘景大道3889号
    var idNumber     = ""   // 公民身份号码 13072319940432302302
    var birthday     = ""   // 出生 19940418
    var idName       = ""   // 姓名 XXX
    var idSex        = ""  // 性别 男
    var national     = "" // 民族 汉
    
    var signOrganization         = ""   // 签发机关
    var signDate                 = ""  // 签发日期
    var invalidDate              = "" // 无效日期
    
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        idcard_number_type <- map["idcard_number_type"]
        image_status <- map["image_status"]
        log_id <- map["log_id"]
        address <- map["words_result.住址.words"]
        idNumber <- map["words_result.公民身份号码.words"]
        birthday <- map["words_result.出生.words"]
        idName <- map["words_result.姓名.words"]
        idSex <- map["words_result.性别.words"]
        national <- map["words_result.民族.words"]
        
        signOrganization <- map["words_result.签发机关.words"]
        signDate <- map["words_result.签发日期.words"]
        invalidDate <- map["words_result.失效日期.words"]
    }   
}

