//
//  HFBabyModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/20.
//  Copyright © 2020 huifan. All rights reserved.
//
// 宝宝数据模型

import Foundation
import ObjectMapper

class HFBaseChildInfo : Mappable {
    
    var ciNaId: String = ""
    var ciNationalityName: String = ""
    var ciSelfEat: Int = 0
    var ciInterest: String = ""
    var id: Int = 0
    var ciRegisteredCountyCode: String = ""
    var ciNativeProvince: String = ""
    var ciCharacter: String = ""
    var ciDislikeFood: String = ""
    var ciOnlyChild: Int = 0
    var naName: String = ""
    var ciSchooledStatus: Int = 0
    var ciHasIll: Int = 0
    var ciCardNo: String = ""
    var ciSelf: String = ""
    var headImg: String = ""
    var ciHeight: Int = 0
    var ciFavoriteFood: String = ""
    var ciCardType: String = ""
    var ciLeftEyeVision: String = ""
    var ciNativeCity: String = ""
    var ciWeight: Int = 0
    var ciNativeProvinceCode: String = ""
    var ciFatStatus: Int = 0
    var ciBeCareBy: String = ""
    var ciBeCareByName: String = ""
    var ciComeStatus: Int = 0
    var ciAds: String = ""
    var enableStatus: Int = 0
    var ciRegisteredCityCode: String = ""
    var ciAdmissionDate: String = ""
    var ciHasAllergy: Int = 0
    var ciNationality: String = ""
    var ciNativeCityCode: String = ""
    var ciProvinceId: String = ""
    var ciRegisteredResidence: String = ""
    var ciHealthy: String = ""
    var ciRegisteredProvinceCode: String = ""
    var ciCountyId: String = ""
    var ciCityId: String = ""
    var ciHadIll: Int = 0
    var ciRegisteredCounty: String = ""
    var ciHadIllName: String = ""
    var ciSelfDefecation: Int = 0
    var ciSex: Int = 0
    var ciRegisteredCity: String = ""
    var ciMyopiaStatus: Int = 0
    var ciNickname: String = ""
    var ciVaccinationStatus: Int = 0
    var ciName: String = ""
    var ciId: String = ""
    var ciCardTypeName: String = ""
    var ciRightEyeVision: String = ""
    var ciAllergyInfo: String = ""
    var ciVaccination: String = ""
    var ciSelfDress: Int = 0
    var ciBirth: String = ""
    var ciRemarks: String = ""
    var ciDistClass: Int = 0
    var ciRegisteredProvince: String = ""
    var ciHasIllName: String = ""

    
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ciNaId    <- map["ciNaId"]
        ciNationalityName    <- map["ciNationalityName"]
        ciSelfEat    <- map["ciSelfEat"]
        ciInterest    <- map["ciInterest"]
        id    <- map["id"]
        ciRegisteredCountyCode    <- map["ciRegisteredCountyCode"]
        ciNativeProvince    <- map["ciNativeProvince"]
        ciCharacter    <- map["ciCharacter"]
        ciDislikeFood    <- map["ciDislikeFood"]
        ciOnlyChild    <- map["ciOnlyChild"]
        naName    <- map["naName"]
        ciSchooledStatus    <- map["ciSchooledStatus"]
        ciHasIll    <- map["ciHasIll"]
        ciCardNo    <- map["ciCardNo"]
        ciSelf    <- map["ciSelf"]
        headImg    <- map["headImg"]
        ciHeight    <- map["ciHeight"]
        ciFavoriteFood    <- map["ciFavoriteFood"]
        ciCardType    <- map["ciCardType"]
        ciLeftEyeVision    <- map["ciLeftEyeVision"]
        ciNativeCity    <- map["ciNativeCity"]
        ciWeight    <- map["ciWeight"]
        ciNativeProvinceCode    <- map["ciNativeProvinceCode"]
        ciFatStatus    <- map["ciFatStatus"]
        ciBeCareBy    <- map["ciBeCareBy"]
        ciBeCareByName    <- map["ciBeCareByName"]
        ciComeStatus    <- map["ciComeStatus"]
        ciAds    <- map["ciAds"]
        enableStatus    <- map["enableStatus"]
        ciRegisteredCityCode    <- map["ciRegisteredCityCode"]
        ciAdmissionDate    <- map["ciAdmissionDate"]
        ciHasAllergy    <- map["ciHasAllergy"]
        ciNationality    <- map["ciNationality"]
        ciNativeCityCode    <- map["ciNativeCityCode"]
        ciProvinceId    <- map["ciProvinceId"]
        ciRegisteredResidence    <- map["ciRegisteredResidence"]
        ciHealthy    <- map["ciHealthy"]
        ciRegisteredProvinceCode    <- map["ciRegisteredProvinceCode"]
        ciCountyId    <- map["ciCountyId"]
        ciCityId    <- map["ciCityId"]
        ciHadIll    <- map["ciHadIll"]
        ciRegisteredCounty    <- map["ciRegisteredCounty"]
        ciHadIllName    <- map["ciHadIllName"]
        ciSelfDefecation    <- map["ciSelfDefecation"]
        ciSex    <- map["ciSex"]
        ciRegisteredCity    <- map["ciRegisteredCity"]
        ciMyopiaStatus    <- map["ciMyopiaStatus"]
        ciNickname    <- map["ciNickname"]
        ciVaccinationStatus    <- map["ciVaccinationStatus"]
        ciName    <- map["ciName"]
        ciId    <- map["ciId"]
        ciCardTypeName    <- map["ciCardTypeName"]
        ciRightEyeVision    <- map["ciRightEyeVision"]
        ciAllergyInfo    <- map["ciAllergyInfo"]
        ciVaccination    <- map["ciVaccination"]
        ciSelfDress    <- map["ciSelfDress"]
        ciBirth    <- map["ciBirth"]
        ciRemarks    <- map["ciRemarks"]
        ciDistClass    <- map["ciDistClass"]
        ciRegisteredProvince    <- map["ciRegisteredProvince"]
        ciHasIllName    <- map["ciHasIllName"]
        
    }
    
}



class HFBabyModel: NSObject, Mappable {
    
    @objc var ciId = "" // 学员业务id
    @objc var ciName = "" // 宝宝姓名
    @objc var ciSex = 0 // 0未知 1男 2女
    @objc var ciSexDesc: String? { // 性别描述
        get{
            var desc = "未知"
            if self.ciSex == 1 {
                desc = "男"
            }
            if self.ciSex == 2 {
                desc = "女"
            }
            return desc
        }
    }
    @objc var ciBirth = "" // 出生日期/
    @objc var ciAge = "" // 年龄/
    @objc var ciCardType = ""  // 证件类型/
    @objc var ciCardNo = "" // 有效证件号码/
    @objc var ciNickname = "" // 宝宝昵称(小名)/
    @objc var ciNationality = "" // 国籍/
    @objc var ciNativeProvince = "" // 宝宝籍贯-省/
    @objc var ciNativeProvinceCode = "" // 宝宝籍贯-省code/
    @objc var ciNaId = "" // 民族业务id
    @objc var naName: String = "" // 民族
    @objc var ofrId = "" // 对象文件业务id/
    @objc var fileType = "" // 文件类型/
    @objc var fiAccessPath = "" // 头像路径/
    var baseParentInfoList: [HFParentModel] = []
    var baseChildBrotherList: [HFBabyBrotherInfoModel] = []
    @objc var grId = "" // 年级业务id/
    @objc var grName = "" // 年级名称/
    @objc var kgrRemarkName = "" // 年级备注名
    @objc var clId = "" // 班级业务id/
    @objc var clName = "" // 班级名称/
    @objc var seId = "" // 学期业务id
    @objc var seName = "" // 学期名称
    @objc var isEntranceKg = 0 // 是否入学 0未入学 1已入学 2审核中
    @objc var ciHeight: Double = 0 // 身高
    @objc var ciWeight: Double = 0 // 体重
    @objc var ciAdmissionDate = "" // 入学日期/
    @objc var ciCharacter = "" // 宝宝性格/
    @objc var ciInterest = "" // 宝宝兴趣/
    @objc var ciFavoriteFood = "" // 喜欢吃的食物/
    @objc var ciDislikeFood = "" // 不喜欢吃的食物/
    @objc var ciVaccinationStatus = 0 // 是否接种全部疫苗0否1是2未选择/
    @objc var ciVaccination = "" // 未接种疫苗名称/
    @objc var ciBeCareBy = "" // 入园前由谁照顾（家长与宝宝关系表业务id）/
    @objc var ciBeCareByName: String = ""
    @objc var ciSchooledStatus = 0 // 之前是否上过幼儿园/
    @objc var ciOnlyChild = 0 // 是否有兄弟姐妹 0否1是
    @objc var ciHasIll = 0 // 现在是否曾患有某种疾病/
    @objc var ciHasIllName = "" // 现在患有的疾病名称 /
    @objc var ciHadIll = 0 // 曾经是否患过某种疾病
    @objc var ciHadIllName = "" // 曾经患有的疾病名称
    @objc var ciHasAllergy = 0 // 是否有过敏史/
    @objc var ciAllergyInfo = "" // 过敏详情/
    @objc var ciSelfDefecation = 0 // 是否可自主大小便0否1是2未选择/
    @objc var ciSelfDress = 0 // 是否可自主穿衣服0否1是2未选择/
    @objc var ciSelfEat = 0 // 是否可自主吃饭0否1是2未选择/
    @objc var ciMyopiaStatus = 0 // 是否近视/
    @objc var ciFatStatus = 0 // 是否肥胖/
    
    var eduBaseKgGrade: HFGradeModel? // 宝宝年级信息
    var eduBaseClass: HFClassModel? // 宝宝班级信息
    /// 幼儿园信息
    var baseKgInfo: HFKindergartenModel?
    var baseChildInfo: HFBaseChildInfo?
    
    // 班级宝宝列表
    @objc var headImg = "" // 宝宝头像
    @objc var usrPhone = "" // 家长手机号
    @objc var cprRelp = "" // 家属名称 爸爸。妈妈
    @objc var cprRelpName = ""
    
    
    
    @objc var status = 0 // 申请状态 1 分班中 2调班中 3毕业中 4退园中
    
    // 邀请记录
    @objc var kiId = "" // 幼儿园业务id
    @objc var kiName = "" // 幼儿园名称
    @objc var ilType = 0 // 邀请类型1邀请教师入园；2邀请宝宝家长入园
    @objc var ilFromUsrId = "" // 邀请者用户id
    @objc var ilToUsrId = "" // 被邀请这用户id
    @objc var ilToUsrPhone = "" // 被邀请这用户手机号
    @objc var ilStatus = 0 // 邀请状态0未绑定；2已拒绝；3已绑定
    @objc var cl_id = "" //班级业务ID
    @objc var usrFullName = "" //家长姓名
    @objc var dicTypeName = ""//亲属关系
    @objc var ilId = ""//邀请记录业务id
    @objc var isAgainInvite = 1 //是否可以再次邀请 0否 1是，默认为可再次邀请
    
    // 本地字段，是否选择，默认为false-未选择
    @objc var selectStatus: Bool = false
    
    @objc var ckrStatus: Int = 0 // 是否绑定 0未绑定1已绑定
    @objc var piRmkName: String = ""
    
    // 查看未绑定宝宝信息
    @objc var piId: String = ""
    @objc var dicFieldCode: String = ""
    @objc var kgrId: String = ""
    @objc var ciComeStatus: Int = 0
    
    @objc var dicFieldName = "" // 与宝宝关系
    
    /// 0在班；1调班中；2已调班；3毕业中；4已毕业；5退园中；6已退园
    @objc var ccrStatus = 0
    
    required init?(map: Map) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// KVC
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("key:\(key)")
    }
    
    override func setNilValueForKey(_ key: String) {
        
    }
    
    func mapping(map: Map) {
        ciId <- map["ciId"]
        ciName <- map["ciName"]
        ciSex <- map["ciSex"]
        ciBirth <- map["ciBirth"]
        ciAge <- map["ciAge"]
        ciCardType <- map["ciCardType"]
        ciCardNo <- map["ciCardNo"]
        ciNickname <- map["ciNickname"]
        ciNationality <- map["ciNationality"]
        ciNativeProvince <- map["ciNativeProvince"]
        ciNativeProvinceCode <- map["ciNativeProvinceCode"]
        ciNaId <- map["ciNaId"]
        naName <- map["naName"]
        ofrId <- map["ofrId"]
        fileType <- map["fileType"]
        fiAccessPath <- map["fiAccessPath"]
        baseParentInfoList <- map["baseParentInfoList"]
        baseChildBrotherList <- map["baseChildBrotherList"]
        grId <- map["grId"]
        grName <- map["grName"]
        kgrRemarkName <- map["kgrRemarkName"]
        clId <- map["clId"]
        clName <- map["clName"]
        seId <- map["seId"]
        seName <- map["seName"]
        isEntranceKg <- map["isEntranceKg"]
        ciHeight <- map["ciHeight"]
        ciWeight <- map["ciWeight"]
        ciAdmissionDate <- map["ciAdmissionDate"]
        ciCharacter <- map["ciCharacter"]
        ciInterest <- map["ciInterest"]
        ciFavoriteFood <- map["ciFavoriteFood"]
        ciDislikeFood <- map["ciDislikeFood"]
        ciVaccinationStatus <- map["ciVaccinationStatus"]
        ciVaccination <- map["ciVaccination"]
        ciBeCareBy <- map["ciBeCareBy"]
        ciBeCareByName    <- map["ciBeCareByName"]
        ciSchooledStatus <- map["ciSchooledStatus"]
        ciOnlyChild <- map["ciOnlyChild"]
        ciHasIll <- map["ciHasIll"]
        ciHasIllName <- map["ciHasIllName"]
        ciHadIll <- map["ciHadIll"]
        ciHadIllName <- map["ciHadIllName"]
        ciHasAllergy <- map["ciHasAllergy"]
        ciAllergyInfo <- map["ciAllergyInfo"]
        ciSelfDefecation <- map["ciSelfDefecation"]
        ciSelfDress <- map["ciSelfDress"]
        ciSelfEat <- map["ciSelfEat"]
        ciMyopiaStatus <- map["ciMyopiaStatus"]
        ciFatStatus <- map["ciFatStatus"]
        
        eduBaseKgGrade <- map["eduBaseKgGrade"]
        eduBaseClass <- map["eduBaseClass"]
        
        headImg <- map["headImg"]
        usrPhone <- map["usrPhone"]
        cprRelp <- map["cprRelp"]
        cprRelpName <- map["cprRelpName"]
        
        kiId <- map["kiId"]
        kiName <- map["kiName"]
        ilType <- map["ilType"]
        ilFromUsrId <- map["ilFromUsrId"]
        ilToUsrId <- map["ilToUsrId"]
        ilToUsrPhone <- map["ilToUsrPhone"]
        ilStatus <- map["ilStatus"]
        cl_id <- map["cl_id"]
        usrFullName <- map["usrFullName"]
        dicTypeName <- map["dicTypeName"]
        ilId <- map["ilId"]
        
        
        
        ckrStatus <- map["ckrStatus"]
        piRmkName <- map["piRmkName"]
        status <- map["status"]
        isAgainInvite <- map["isAgainInvite"]
        
        
        piId <- map["piId"]
        dicFieldCode <- map["dicFieldCode"]
        kgrId <- map["kgrId"]
        ciComeStatus <- map["ciComeStatus"]
        
        dicFieldName <- map["dicFieldName"]
        
        ccrStatus <- map["ccrStatus"]
        baseChildInfo <- map["baseChildInfo"]
        
    }
    
    /// 将0否1是2未选择转为描述
    /// - Parameter value: 值
    /// - Returns: 值描述
    func valueToDesc(value: Int) -> String {
        var desc = "未选择"
        if value == 0 {
            desc = "否"
        }
        if value == 1 {
            desc = "是"
        }
        return desc
    }
    
}

class HFBabyBrotherInfoModel : Mappable {
    /// 兄弟姐妹生日
    var cbBirth: String = ""
    /// 兄弟姐妹年龄
    var cbAge = 0
    /// 兄弟姐妹姓名
    var cbName: String = ""
    /// 兄弟姐妹业务ID
    var cbId: String = ""
    /// 宝宝业务ID
    var ciId: String = ""
    /// 与宝宝关系(字典表业务id)
    var cbRelation: String = ""
    /// 关系名称
    var cbRelationName: String = ""
    /// 兄弟姐妹性别0未知1男2女
    var cbSex: Int = 0
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        cbBirth    <- map["cbBirth"]
        cbAge <- map["cbAge"]
        cbName    <- map["cbName"]
        cbId    <- map["cbId"]
        ciId    <- map["ciId"]
        cbRelation    <- map["cbRelation"]
        cbRelationName <- map["cbRelationName"]
        cbSex    <- map["cbSex"]
    }
    
}

// 添加宝宝时的数据模型
class HFAddBabyDataModel : Mappable {
    
    var ciId = ""
    var piId = ""
    var functionTypes: Int = 1
    var clId: String = ""
    var clName = ""
    var ciName: String = ""
    var ciNickname: String = ""
    var ciBirth: String = ""
    var usrFullName: String = ""
    var cprRelp: String = ""
    var dicFieldName = ""
    var ciComeStatus: Int = -1
    var kgrId: String = ""
    var kgrRemarkName = ""
    var ciSex: Int = 0
    var usrPhone: String = ""
    var kiId: String = ""
    var usrSex: Int = 0 // 家属性别
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ciId <- map["ciId"]
        piId <- map["piId"]
        functionTypes    <- map["functionTypes"]
        clId <- map["clId"]
        clName <- map["clName"]
        ciName    <- map["ciName"]
        ciNickname <- map["ciNickname"]
        ciBirth <- map["ciBirth"]
        usrFullName    <- map["usrFullName"]
        cprRelp    <- map["cprRelp"]
        dicFieldName <- map["dicFieldName"]
        ciComeStatus    <- map["ciComeStatus"]
        kgrId    <- map["kgrId"]
        kgrRemarkName <- map["kgrRemarkName"]
        ciSex    <- map["ciSex"]
        usrPhone    <- map["usrPhone"]
        kiId    <- map["kiId"]
        usrSex <- map["usrSex"]
    }
}


// 宝宝入园家长数据模型
class HFBaseParentInfoModel : Mappable {
    
    var cprRelpName: String = ""
    var cprRelp: String = ""
    var cprDef: Int = 0
    var baseParentInfoResul: HFBaseParentInfoResultModel = HFBaseParentInfoResultModel.init()
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        cprRelpName    <- map["cprRelpName"]
        cprRelp    <- map["cprRelp"]
        cprDef    <- map["cprDef"]
        baseParentInfoResul    <- map["baseParentInfoResult"]
    }
}

class HFBaseParentInfoResultModel : Mappable {
    
    var usrFullName: String = ""
    var usrPhone: String = ""
    var usrBirthday: String = ""
    var piRmkName: String = ""
    var naName: String = ""
    var piEducation: String = ""
    var updateUid: String = ""
    var piAcceptStatus: Int = 0
    var eiEducationTitle: String = ""
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
    var piWorkNear: String = ""
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
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        usrFullName <- map["usrFullName"]
        usrPhone <- map["usrPhone"]
        usrBirthday <- map["usrBirthday"]
        piRmkName    <- map["piRmkName"]
        naName    <- map["naName"]
        piEducation    <- map["piEducation"]
        updateUid    <- map["updateUid"]
        piAcceptStatus    <- map["piAcceptStatus"]
        eiEducationTitle    <- map["eiEducationTitle"]
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
    }
}
