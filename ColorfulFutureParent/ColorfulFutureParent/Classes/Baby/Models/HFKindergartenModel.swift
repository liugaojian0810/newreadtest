//
//  HFKindergartenModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/19.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import ObjectMapper

/// 幼儿园状态
enum HFKindergartenStatus: Int {
    case waitSubmit = 0 // 待完善（保存-待提交）
    case rejected = 1 // 审核失败（驳回）
    case review = 2 // 审核中（已提交）
    case through = 3 // 通过
}

class HFKindergartenModel: Mappable {
    
    var kiId = "" // 幼儿园业务主键
    var kiNumber = "" // 幼儿园编号
    var kiName = "" //  幼儿园名称
    var kiProvince = "" //  所属地区-省
    var kiProvinceCode = "" //  所属地区-省编码
    var kiCity = "" //  所属地区-市
    var kiCityCode = "" //  所属地区-市编码
    var kiCounty = "" //  所属地区-区县
    var kiCountyCode = ""  //  所属地区-区县编码
    var kiAds = "" //  幼儿园详细地址
    var kiWarzone = 0 //  所属战区
    var kiKgType = ""  // 幼儿园类型-字典表-字段code (kg =kindergarten)
    var kiePcd = "" // 邮编
    var chUsrFullName = "" //  总园长-姓名
    var chUsrPhone = "" // 总园长-手机号
    var exeUsrFullName = "" //  执行园长-姓名
    var exeUsrPhone = "" // 执行园长-手机号
    var kiHuifanCode = "" //  联盟园编号
    var mlId = "" // 会员卡类型
    var memCode = "" // 幼儿园会员卡卡号
    var kiTeamsNumInit = 0 //  班级数量初始化
    var kiQuotaTotal = 0 //  幼儿园总容纳量
    var kiTeamsNum = 0  // 班级数量
    var kiQuotaMini = 0 // 班额-托班
    var kiQuotaMin = 0  // 班额-小班
    var kiQuotaMid = 0  // 班额-中班
    var kiQuotaBig = 0  // 班额-大班
    var kiQuotaMax = 0  // 班额-幼小衔接班
    var kiDirCert = 0  // 是否有总园长证明书(dir = director）
    var kiLicence = 0  // 是否有办园许可证
    var kieGrade = ""  // 幼儿园档次-字典表-字段code
    var kieIndoorArea = ""  // 室内面积（平米）
    var kieOutdoorArea = "" //  室外面积（平米）
    var kiePropProperty = "" //  房产属性-字典表-字段code
    var kieWebsite = "" //  幼儿园网站
    var kieTiktok = "" // 幼儿园抖音号
    var kieQq = "" // qq号
    var kiStatus: HFKindergartenStatus = .waitSubmit // 幼儿园资料状态0待完善（保存-待提交）1审核失败（驳回）2审核中（已提交）3审核通过
    var kiAuditMark = "" // 最后一次审核的驳回原因
    var muiEndTime = "" // 会员卡到期时间
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        kiId               <- map["kiId"]
        kiNumber           <- map["kiNumber"]
        kiName             <- map["kiName"]
        kiProvince         <- map["kiProvince"]
        kiProvinceCode     <- map["kiProvinceCode"]
        kiCity             <- map["kiCity"]
        kiCityCode         <- map["kiCityCode"]
        kiCounty           <- map["kiCounty"]
        kiCountyCode       <- map["kiCountyCode"]
        kiAds              <- map["kiAds"]
        kiWarzone          <- map["kiWarzone"]
        kiKgType           <- map["kiKgType"]
        kiePcd             <- map["kiePcd"]
        chUsrFullName      <- map["chUsrFullName"]
        chUsrPhone         <- map["chUsrPhone"]
        exeUsrFullName     <- map["exeUsrFullName"]
        exeUsrPhone        <- map["exeUsrPhone"]
        kiHuifanCode       <- map["kiHuifanCode"]
        mlId               <- map["mlId"]
        memCode            <- map["memCode"]
        kiTeamsNum         <- map["kiTeamsNum"]
        kiTeamsNumInit     <- map["kiTeamsNumInit"]
        kiQuotaTotal       <- map["kiQuotaTotal"]
        kiQuotaMini        <- map["kiQuotaMini"]
        kiQuotaMin         <- map["kiQuotaMin"]
        kiQuotaMid         <- map["kiQuotaMid"]
        kiQuotaBig         <- map["kiQuotaBig"]
        kiQuotaMax         <- map["kiQuotaMax"]
        kiDirCert          <- map["kiDirCert"]
        kiLicence          <- map["kiLicence"]
        kieGrade           <- map["kieGrade"]
        kieIndoorArea      <- map["kieIndoorArea"]
        kieOutdoorArea     <- map["kieOutdoorArea"]
        kiePropProperty    <- map["kiePropProperty"]
        kieWebsite         <- map["kieWebsite"]
        kieTiktok          <- map["kieTiktok"]
        kieQq              <- map["kieQq"]
        kiStatus           <- (map["kiStatus"],EnumTransform<HFKindergartenStatus>())
        kiAuditMark        <- map["kiAuditMark"]
        muiEndTime         <- map["muiEndTime"]
    }
}
