//
//  HFParentModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/20.
//  Copyright © 2020 huifan. All rights reserved.
//
// 宝宝亲属数据模型

import Foundation
import ObjectMapper

class HFParentModel: Mappable {

    var cprRelp = "" // 亲属关系/
    var cprRelpName = ""
    var usrFullName = "" // 亲属姓名/
    var piWrkPlace = "" // 工作单位/
    var usrPhone = "" // 手机号/
    var piVocation = "" // 职业/
    var cprDef = 2 // 是否是第一联系人0否，1是，2未选择/
    var piNationality = ""  // 家长国籍/
    var piNationalityName = ""
    var usrBirthday = ""  // 出生日期/
    var usrAge = ""  // 年龄/
    var piEducation = ""  // 学历/
    var piNativeProvince = ""  // 籍贯-省/
    var piNativeProvinceCode = ""  // 籍贯-省业务ID/
    var piHrProvince = ""  // 户籍-省/
    var piHrProvinceCode = ""  // 户籍-省业务ID/
    var piHrCity = ""  // 户籍-市/
    var piHrCityCode = ""  // 户籍-市业务ID/
    var piHrCounty = ""  // 户籍-县/
    var piHrCountyCode = ""  // 户籍-县业务id/
    var piHrAdd = ""  // 户籍详细地址/
    var piNhomAdd = ""  // 现居住地址/
    
    var baseParentInfoResult: HFBaseParentInfoResult? // 档案信息
    var baseParentUserResult: HFBaseParentUserResult? // 用户基本信息
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cprRelp <- map["cprRelp"]
        cprRelpName <- map["cprRelpName"]
        usrFullName <- map["usrFullName"]
        piWrkPlace <- map["piWrkPlace"]
        usrPhone <- map["usrPhone"]
        piVocation <- map["piVocation"]
        cprDef <- map["cprDef"]
        piNationality <- map["piNationality"]
        piNationalityName <- map["piNationalityName"]
        usrBirthday <- map["usrBirthday"]
        usrAge <- map["usrAge"]
        piEducation <- map["piEducation"]
        piNativeProvince <- map["piNativeProvince"]
        piNativeProvinceCode <- map["piNativeProvinceCode"]
        piHrProvince <- map["piHrProvince"]
        piHrProvinceCode <- map["piHrProvinceCode"]
        piHrCity <- map["piHrCity"]
        piHrCityCode <- map["piHrCityCode"]
        piHrCounty <- map["piHrCounty"]
        piHrCountyCode <- map["piHrCountyCode"]
        piHrAdd <- map["piHrAdd"]
        piNhomAdd <- map["piNhomAdd"]
        baseParentInfoResult <- map["baseParentInfoResult"]
        baseParentUserResult <- map["baseParentUserResult"]
    }
}

/// 家长档案信息
class HFBaseParentInfoResult : Mappable {
    
    var piRmkName: String = ""
    var piEducation: String = ""
    var eiEducationTitle: String = ""
    var updateUid: String = ""
    var piAcceptStatus: Int = 0
    var piHrCounty: String = ""
    var piWorkPlace: String = ""
    var piNativeCity: String = ""
    var headImg: String = ""
    var piHrProvinceCode: String = ""
    var piHrAdd: String = ""
    var piHrCountyCode: String = ""
    var piHrProvince: String = ""
    var piSchool: String = ""
    var piNativeCityCode: String = ""
    var piNativeCounty: String = ""
    var piNativeCountyCode: String = ""
    var piWorkNear: Int = 0
    var piVocation: String = ""
    var piNativeProvinceCode: String = ""
    var naId: String = ""
    var piNhomAdd: String = ""
    var piNationality: String = ""
    var piNationalityName: String = ""
    var piNativeProvince: String = ""
    var piHrCity: String = ""
    var piId: String = ""
    var piHrCityCode: String = ""
    var piWrkPlace: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        piRmkName    <- map["piRmkName"]
        piEducation    <- map["piEducation"]
        eiEducationTitle <- map["eiEducationTitle"]
        updateUid    <- map["updateUid"]
        piAcceptStatus    <- map["piAcceptStatus"]
        piHrCounty    <- map["piHrCounty"]
        piWorkPlace    <- map["piWorkPlace"]
        piNativeCity    <- map["piNativeCity"]
        headImg    <- map["headImg"]
        piHrProvinceCode    <- map["piHrProvinceCode"]
        piHrAdd    <- map["piHrAdd"]
        piHrCountyCode    <- map["piHrCountyCode"]
        piHrProvince    <- map["piHrProvince"]
        piSchool    <- map["piSchool"]
        piNativeCityCode    <- map["piNativeCityCode"]
        piNativeCounty    <- map["piNativeCounty"]
        piNativeCountyCode    <- map["piNativeCountyCode"]
        piWorkNear    <- map["piWorkNear"]
        piVocation    <- map["piVocation"]
        piNativeProvinceCode    <- map["piNativeProvinceCode"]
        naId    <- map["naId"]
        piNhomAdd    <- map["piNhomAdd"]
        piNationality    <- map["piNationality"]
        piNationalityName <- map["piNationalityName"]
        piNativeProvince    <- map["piNativeProvince"]
        piHrCity    <- map["piHrCity"]
        piId    <- map["piId"]
        piHrCityCode    <- map["piHrCityCode"]
        piWrkPlace    <- map["piWrkPlace"]
        
    }
}

/// 家长基本信息
class HFBaseParentUserResult : Mappable {

    var usrSex: Int = 0
    var usrFullName: String = ""
    var usrAuthStatus: Int = 0
    var usrName: String = ""
    var usrPhone: String = ""
    var usrNo: String = ""
    var usrBirthday: String = ""
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        usrSex    <- map["usrSex"]
        usrFullName    <- map["usrFullName"]
        usrAuthStatus    <- map["usrAuthStatus"]
        usrName    <- map["usrName"]
        usrPhone    <- map["usrPhone"]
        usrNo    <- map["usrNo"]
        usrBirthday    <- map["usrBirthday"]
        usrId    <- map["usrId"]
    }
}
