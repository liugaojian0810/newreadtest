//
//  HFKinderInfomation.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/12/29.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 "model":{
 "baseKgInfo": {
 "kiId":"" // 业务主键
 "kiName":"" // 幼儿园名称
 "kiNumber":"" // 幼儿园编号
 "kiHuifanCode":"" // 联盟园编号
 "wzId":"" // 所属战区
 "kiProvince":"" // 所属地区-省
 "kiProvinceCode":"" // 所属地区-省编码
 "kiCity":"" // 所属地区-市
 "kiCityCode":"" // 所属地区-市编码
 "kiCounty":"" // 所属地区-区县
 "kiCountyCode":"" // 所属地区-区县编码
 "kiAds":"" // 幼儿园详细地址
 "kiKgType":"" // 幼儿园类型-字典表业务id (kg =kindergarten)
 },
 "jobList": [
 { // 组织架构岗位信息
 "osId":"", //组织架构业务id
 "osName":"",  //部门名称
 "jobId":"", //岗位业务主键id
 "jobName":"", //岗位名称
 "osIds":"" //组织架构层级关系id串(逗号分隔)，前端回显数据使用
 }
 ],
 "baseEmployeeClass": {
 "kiId":"", //幼儿园业务id
 "eiId":"", //教职工信息业务ID
 "grId":"", //基础年级业务ID
 "clId":"" // 班级业务ID
 "clName":"小一班", //班级名称
 "kgrRemarkName":"一年级", //年级备注名称
 "grName":"",  // 年级名称
 "grRemark":"" //基础年级备注名
 }
 }
 */

// MARK: 教职工所在幼儿园信息

class HFBaseKgInfo : Mappable {
    /**
     "kiId":"" // 业务主键
     "kiName":"" // 幼儿园名称
     "kiNumber":"" // 幼儿园编号
     "kiHuifanCode":"" // 联盟园编号
     "wzId":"" // 所属战区
     "kiProvince":"" // 所属地区-省
     "kiProvinceCode":"" // 所属地区-省编码
     "kiCity":"" // 所属地区-市
     "kiCityCode":"" // 所属地区-市编码
     "kiCounty":"" // 所属地区-区县
     "kiCountyCode":"" // 所属地区-区县编码
     "kiAds":"" // 幼儿园详细地址
     "kiKgType":"" // 幼儿园类型-字典表业务id (kg =kindergarten)
     "kiTeamsNum":"" // 班级数量
     "kiTeamsNumInit":"" // 班级数量初始化（园长录入）
     "kiChildNum":"" // 幼儿园实时宝宝数量
     "kiQuotaTotal":"" // 幼儿园总容纳量(宝宝数量)
     "kiQuotaMini":"" // 班额-托班
     "kiQuotaMin":"" // 班额-小班
     "kiQuotaMid":"" // 班额-中班
     "kiQuotaBig":"" // 班额-大班
     "kiQuotaMax":"" // 班额-幼小衔接班
     "kiKgNatureA":"" // 办园性质A-经营性质-字典表-字段code
     "kiKgNatureB":"" // 办园性质B-惠普性质-字典表-字段code
     "kiKgNatureC":"" // 办园性质C-盈利性质-字典表-字段code
     "kiDirCert":"" // 是否有总园长证明书(dir = director）
     "kiLicence":"" // 是否有办园许可证
     "kiFoodSafeCert":"" // 是否有食品安全证
     "kiFireSafeCert":"" // 是否有消防安全证
     "kiAuthAccount":"" // 是否授权幼儿园账户(Authorized account)0否1是
     "kiStatus":"" // 幼儿园资料状态0待完善（保存-待提交）1审核失败（驳回）2审核中（已提交）3审核通过
     "kiAuditMark":""， // 最后审核备注（最后审核失败原因）
     "mlName":"金卡会员" // 会员登录名称
     */
    var wzId: String = ""
    var kiAds: String = ""
    var kiCityCode: String = ""
    var kiKgType: String = ""
    var kiProvince: String = ""
    var kiId: String = ""
    var kiProvinceCode: String = ""
    var kiNumber: String = ""
    var kiCity: String = ""
    var kiHuifanCode: String = ""
    var kiName: String = ""
    var kiCounty: String = ""
    var kiCountyCode: String = ""
    
    
    var kiFireSafeCert: String = ""
    var kiTeamsNum: String = ""
    var kiQuotaMid: String = ""
    var kiQuotaMini: String = ""
    var kiQuotaBig: String = ""
    var kiQuotaMax: String = ""
    var kiKgNatureB: String = ""
    var kiKgNatureC: String = ""
    var kiLicence: String = ""
    var kiFoodSafeCert: String = ""
    var kiAuthAccount: String = ""
    var mlName: String = ""
    var kiAuditMark: String = ""
    var kiDirCert: String = ""
    var kiStatus: String = ""
    var kiKgNatureA: String = ""
    var kiQuotaMin: String = ""
    var kiTeamsNumInit: String = ""
    var kiQuotaTotal: String = ""
    var kiChildNum: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        wzId    <- map["wzId"]
        kiAds    <- map["kiAds"]
        kiCityCode    <- map["kiCityCode"]
        kiKgType    <- map["kiKgType"]
        kiProvince    <- map["kiProvince"]
        kiId    <- map["kiId"]
        kiProvinceCode    <- map["kiProvinceCode"]
        kiNumber    <- map["kiNumber"]
        kiCity    <- map["kiCity"]
        kiHuifanCode    <- map["kiHuifanCode"]
        kiName    <- map["kiName"]
        kiCounty    <- map["kiCounty"]
        kiCountyCode    <- map["kiCountyCode"]
        kiHuifanCode    <- map["kiHuifanCode"]
        kiCityCode    <- map["kiCityCode"]
        kiFireSafeCert    <- map["kiFireSafeCert"]
        kiCounty    <- map["kiCounty"]
        kiCountyCode    <- map["kiCountyCode"]
        wzId    <- map["wzId"]
        kiProvince    <- map["kiProvince"]
        kiTeamsNum    <- map["kiTeamsNum"]
        kiQuotaMid    <- map["kiQuotaMid"]
        kiAds    <- map["kiAds"]
        kiQuotaMini    <- map["kiQuotaMini"]
        kiProvinceCode    <- map["kiProvinceCode"]
        kiQuotaBig    <- map["kiQuotaBig"]
        kiQuotaMax    <- map["kiQuotaMax"]
        kiName    <- map["kiName"]
        kiKgNatureB    <- map["kiKgNatureB"]
        kiKgNatureC    <- map["kiKgNatureC"]
        kiLicence    <- map["kiLicence"]
        kiFoodSafeCert    <- map["kiFoodSafeCert"]
        kiAuthAccount    <- map["kiAuthAccount"]
        mlName    <- map["mlName"]
        kiAuditMark    <- map["kiAuditMark"]
        kiDirCert    <- map["kiDirCert"]
        kiStatus    <- map["kiStatus"]
        kiKgNatureA    <- map["kiKgNatureA"]
        kiQuotaMin    <- map["kiQuotaMin"]
        kiTeamsNumInit    <- map["kiTeamsNumInit"]
        kiQuotaTotal    <- map["kiQuotaTotal"]
        kiChildNum    <- map["kiChildNum"]
        kiNumber    <- map["kiNumber"]
        kiKgType    <- map["kiKgType"]
        kiId    <- map["kiId"]
        kiCity    <- map["kiCity"]
    }
    
}

// 组织架构岗位信息
class HFJobList : Mappable {
    
    var osName: String = ""
    var osId: String = ""
    var jobId: String = ""
    var osIds: String = ""
    var jobName: String = ""
    /**
     { // 组织架构岗位信息
     "weId":"" //  工作经历业务ID
     "kiId":"" //  幼儿园业务id
     "weJobStatus":"" //  在职状态0未知1在职2离职
     "weCompyName":"" //  工作单位名称
     "weDepartment":"" //  所属部门
     "weJob":"" //  工作经历岗位
     "weJobType":"" //  岗位类型
     "weStartTime":"" //  工作开始时间
     "weEndTime":"" //  工作结束时间
     "weDescr":"" //  经历说明
     }
     */
    var weJobStatus: String = ""
    var weId: String = ""
    var weDepartment: String = ""
    var weCompyName: String = ""
    var weJobType: String = ""
    var weJob: String = ""
    var weStartTime: String = ""
    var weEndTime: String = ""
    var weDescr: String = ""
    var kiId: String = ""
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        osName    <- map["osName"]
        osId    <- map["osId"]
        jobId    <- map["jobId"]
        osIds    <- map["osIds"]
        jobName    <- map["jobName"]
        weJobStatus    <- map["weJobStatus"]
        weId    <- map["weId"]
        weDepartment    <- map["weDepartment"]
        weCompyName    <- map["weCompyName"]
        weJobType    <- map["weJobType"]
        weJob    <- map["weJob"]
        weStartTime    <- map["weStartTime"]
        weEndTime    <- map["weEndTime"]
        weDescr    <- map["weDescr"]
        kiId    <- map["kiId"]
        usrId    <- map["usrId"]
    }
}

//班级年级
class HFBaseEmployeeClass : Mappable {
    /**
     {   //班级年级
     "kiId":"", //幼儿园业务id
     "eiId":"", //教职工信息业务ID
     "grId":"", //基础年级业务ID
     "clId":"" // 班级业务ID
     "clName":"小一班", //班级名称
     "kgrRemarkName":"一年级", //年级备注名称
     "grName":"",  // 年级名称
     "grRemark":"" //基础年级备注名
     }
     */
    var grId: String = ""
    var clName: String = ""
    var grName: String = ""
    var grRemark: String = ""
    var kgrRemarkName: String = ""
    var clId: String = ""
    var eiId: String = ""
    var kiId: String = ""
    var kgrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        grId    <- map["grId"]
        clName    <- map["clName"]
        grName    <- map["grName"]
        grRemark    <- map["grRemark"]
        kgrRemarkName    <- map["kgrRemarkName"]
        clId    <- map["clId"]
        eiId    <- map["eiId"]
        kiId    <- map["kiId"]
        kgrId    <- map["kgrId"]
        
    }
    
}


// MARK: 教职工详情信息

// 用户信息
class HFBaseUser : Mappable {
    
    var usrSex: Int = 0
    var usrFullName: String = ""
    var usrHeadImg: String = ""
    var uaiIdCard: String = ""
    var usrName: String = ""
    var usrPhone: String = ""
    var usrBirthday: String = ""
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        usrSex    <- map["usrSex"]
        usrFullName    <- map["usrFullName"]
        usrHeadImg    <- map["usrHeadImg"]
        uaiIdCard    <- map["uaiIdCard"]
        usrName    <- map["usrName"]
        usrPhone    <- map["usrPhone"]
        usrBirthday    <- map["usrBirthday"]
        usrId    <- map["usrId"]
    }
    
}

// 教育经历
class HFEduBaseEducationalExpList : Mappable {
    
    //    "eeId":""  //* 教育经历业务ID
    //    "usrId":""  //* 用户业务ID
    //    "kiId":""  //* 幼儿园业务id
    //    "eeJobStatus":""  //* 在职状态0未知1在职2离职
    //    "eeSchool":""  //* 学校名称
    //    "eeMajor":""  //* 专业名称
    //    "eeEducation":""  //* 学历(字典表中获取)
    //    "eeEducationTitle":"" // 字段数据转义后的学历名称
    //    "eeStartTime":""  //* 教育开始时间
    //    "eeEndTime":""  //* 教育结束时间
    //    "eeDescription":""  //* 教育经历说明
    
    var eeJobStatus: String = ""
    var eeMajor: String = ""
    var eeEducation: String = ""
    var eeEducationTitle: String = ""
    var eeStartTime: String = ""
    var eeSchool: String = ""
    var eeId: String = ""
    var eeEndTime: String = ""
    var eeDescription: String = ""
    var kiId: String = ""
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        eeJobStatus    <- map["eeJobStatus"]
        eeMajor    <- map["eeMajor"]
        eeEducation    <- map["eeEducation"]
        eeEducationTitle    <- map["eeEducationTitle"]
        eeStartTime    <- map["eeStartTime"]
        eeSchool    <- map["eeSchool"]
        eeId    <- map["eeId"]
        eeEndTime    <- map["eeEndTime"]
        eeDescription    <- map["eeDescription"]
        kiId    <- map["kiId"]
        usrId    <- map["usrId"]
    }
    
}

// 工作经历
class HFEduBaseWorkExpList : Mappable {
    /**
     {  // 工作经历
     "weId":"" //  工作经历业务ID
     "usrId":"" //  用户业务ID
     "kiId":"" //  幼儿园业务id
     "weJobStatus":"" //  在职状态0未知1在职2离职
     "weCompyName":"" //  工作单位名称
     "weDepartment":"" //  所属部门
     "weJob":"" //  工作经历岗位
     "weJobType":"" //  岗位类型
     "weStartTime":"" //  工作开始时间
     "weEndTime":"" //  工作结束时间
     "weDescr":"" //  经历说明
     }
     */
    var weJobStatus: String = ""
    var weId: String = ""
    var weDepartment: String = ""
    var weCompyName: String = ""
    var weJobType: String = ""
    var weJob: String = ""
    var weStartTime: String = ""
    var weEndTime: String = ""
    var weDescr: String = ""
    var kiId: String = ""
    var usrId: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        weJobStatus    <- map["weJobStatus"]
        weId    <- map["weId"]
        weDepartment    <- map["weDepartment"]
        weCompyName    <- map["weCompyName"]
        weJobType    <- map["weJobType"]
        weJob    <- map["weJob"]
        weStartTime    <- map["weStartTime"]
        weEndTime    <- map["weEndTime"]
        weDescr    <- map["weDescr"]
        kiId    <- map["kiId"]
        usrId    <- map["usrId"]
    }
}

class HFAuthentication : Mappable {
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
    }
    
}

// 档案信息
class HFBaseEmployeeInfo : Mappable {
    
    var eiId: String = ""
    var eiRemark: String = ""
    var eiNativeCountyCode: String = ""
    var eiNhomAds: String = ""
    var eiHealthCertificateUrl: String = ""
    var eiHrCountyCode: String = ""
    var eiNativeProvince: String = ""
    var eiFillInTime: String = ""
    var usrId: String = ""
    var eiProbationEndTime: String = ""
    var eiBecomeTime: String = ""
    var naName: String = ""
    var eiHeight: String = ""
    var headImg: String = ""
    var eiDepartureTime: String = ""
    var eiNhomProvinceCode: String = ""
    var eiWeight: String = ""
    var eiMajor: String = ""
    var eiWorkingYears: String = ""
    var eiEducation: String = ""
    var eiCredentialsUrl: String = ""
    var eiNhomCity: String = ""
    var eiHrCity: String = ""
    var eiHrCounty: String = ""
    var eiNativeCounty: String = ""
    var eiGrSchool: String = ""
    var eiNhomCountyCode: String = ""
    var eiNhomCounty: String = ""
    var eiEntryTime: String = ""
    var eiMaritalStatus: String = ""
    var eiAcceptStatus: String = ""
    var eiProbationStartTime: String = ""
    var dirJobStatus: String = ""
    var bloodName: String = ""
    var eiNativeCity: String = ""
    var enableStatus: String = ""
    var eiEmail: String = ""
    var eiEducationTitle: String = ""
    var eiBloodTypeId: String = ""
    var eiHrAdd: String = ""
    var eiNativeCityCode: String = ""
    var eiHrProvince: String = ""
    var eiOld: String = ""
    var eiNativeProvinceCode: String = ""
    var eiRmkName: String = ""
    var eiHrProvinceCode: String = ""
    var eiHrCityCode: String = ""
    var eiSpeciality: String = ""
    var eiSelfEvaluation: String = ""
    var createTime: String = ""
    var naId: String = ""
    var eiProbation: String = ""
    var eiNhomCityCode: String = ""
    var eiNhomProvince: String = ""
    var certificates: HFCertificates?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        eiId    <- map["eiId"]
        eiRemark    <- map["eiRemark"]
        eiNativeCountyCode    <- map["eiNativeCountyCode"]
        eiNhomAds    <- map["eiNhomAds"]
        eiHealthCertificateUrl    <- map["eiHealthCertificateUrl"]
        eiHrCountyCode    <- map["eiHrCountyCode"]
        eiNativeProvince    <- map["eiNativeProvince"]
        eiFillInTime    <- map["eiFillInTime"]
        usrId    <- map["usrId"]
        eiProbationEndTime    <- map["eiProbationEndTime"]
        eiBecomeTime    <- map["eiBecomeTime"]
        naName    <- map["naName"]
        eiHeight    <- map["eiHeight"]
        headImg    <- map["headImg"]
        eiDepartureTime    <- map["eiDepartureTime"]
        eiNhomProvinceCode    <- map["eiNhomProvinceCode"]
        eiWeight    <- map["eiWeight"]
        eiMajor    <- map["eiMajor"]
        eiWorkingYears    <- map["eiWorkingYears"]
        eiEducation    <- map["eiEducation"]
        eiCredentialsUrl    <- map["eiCredentialsUrl"]
        eiNhomCity    <- map["eiNhomCity"]
        eiHrCity    <- map["eiHrCity"]
        eiHrCounty    <- map["eiHrCounty"]
        eiNativeCounty    <- map["eiNativeCounty"]
        eiGrSchool    <- map["eiGrSchool"]
        eiNhomCountyCode    <- map["eiNhomCountyCode"]
        eiNhomCounty    <- map["eiNhomCounty"]
        eiEntryTime    <- map["eiEntryTime"]
        eiMaritalStatus    <- map["eiMaritalStatus"]
        eiAcceptStatus    <- map["eiAcceptStatus"]
        eiProbationStartTime    <- map["eiProbationStartTime"]
        dirJobStatus    <- map["dirJobStatus"]
        bloodName    <- map["bloodName"]
        eiNativeCity    <- map["eiNativeCity"]
        enableStatus    <- map["enableStatus"]
        eiEmail    <- map["eiEmail"]
        eiEducationTitle    <- map["eiEducationTitle"]
        eiBloodTypeId    <- map["eiBloodTypeId"]
        eiHrAdd    <- map["eiHrAdd"]
        eiNativeCityCode    <- map["eiNativeCityCode"]
        eiHrProvince    <- map["eiHrProvince"]
        eiOld    <- map["eiOld"]
        eiNativeProvinceCode    <- map["eiNativeProvinceCode"]
        eiRmkName    <- map["eiRmkName"]
        eiHrProvinceCode    <- map["eiHrProvinceCode"]
        eiHrCityCode    <- map["eiHrCityCode"]
        eiSpeciality    <- map["eiSpeciality"]
        eiSelfEvaluation    <- map["eiSelfEvaluation"]
        createTime    <- map["createTime"]
        naId    <- map["naId"]
        eiProbation    <- map["eiProbation"]
        eiNhomCityCode    <- map["eiNhomCityCode"]
        eiNhomProvince    <- map["eiNhomProvince"]
        certificates    <- map["certificates"]
        
    }
}

// 证书
class HFCertificateInfo : Mappable {
    
    var fiId: String = ""
    var typeName: String = "" //证书类型
    var fiAccessPath: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        fiId    <- map["fiId"]
        typeName   <- map["typeName"]
        fiAccessPath    <- map["fiAccessPath"]
    }
    
}

// 证书集
class HFCertificates : Mappable {
    
    var diplomas: [HFCertificateInfo] //毕业证
    var academicDegrees: [HFCertificateInfo]//学位证
    var monitoringCertificates: [HFCertificateInfo]//健康证
    var otherCertificates: [HFCertificateInfo]//其他证书
    
    required init?(map: Map) {
        diplomas = []
        academicDegrees = []
        monitoringCertificates = []
        otherCertificates = []
    }
    
    func mapping(map: Map) {
        diplomas <- map["diplomas"]
        academicDegrees <- map["academicDegrees"]
        monitoringCertificates <- map["monitoringCertificates"]
        otherCertificates <- map["otherCertificates"]
    }
}




class HFKinderInfomation: Mappable {
    
    var jobList: [HFJobList]
    var baseEmployeeClass: HFBaseEmployeeClass?
    var baseKgInfo: HFBaseKgInfo?
    
    /// 教职工详情信息
    var baseUser: HFBaseUser?
    var baseEmployeeInfo: HFBaseEmployeeInfo?
    var authentication: HFAuthentication?
    var eduBaseEducationalExpList: [HFEduBaseEducationalExpList]
    var baseWorkExpList: [HFEduBaseWorkExpList]
    
    
    required init?(map: Map) {
        jobList = []
        eduBaseEducationalExpList = []
        baseWorkExpList = []
    }
    
    func mapping(map: Map) {
        jobList <- map["jobList"]
        baseEmployeeClass <- map["baseEmployeeClass"]
        baseKgInfo <- map["baseKgInfo"]
        baseUser <- map["baseUser"]
        baseEmployeeInfo <- map["baseEmployeeInfo"]
        authentication <- map["authentication"]
        eduBaseEducationalExpList <- map["eduBaseEducationalExpList"]
        baseWorkExpList <- map["baseWorkExpList"]
    }
    
}
