//
//  HFMineViewModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/11.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON


enum FieldType {
    
    case headImg //家长头像
    case usrFullName //家长姓名
    case sex //家长性别
    case cprRelp //家长宝宝关系
    case piRmkName //家长备注名
}


class HFMineViewModel: NSObject {
    
    
    // MARK: 我的资料
    
    /// 我的资料
    lazy var tips = ["头像", "姓名", "性别", "与宝宝关系", "备注名"]
    lazy var contents = ["", "", "", "", ""]
    
    ///分组提示
    lazy var sectionTips = ["宝宝信息", "亲属信息", "入园信息", "健康信息"]
    
    /// 宝宝档案
    lazy var babyArchiverTips = [["宝宝小名", "性别", "出生日期", "年龄", "国籍", "民族", "证件类型", "有效证件号码", "宝宝户籍"], [], ["身高（cm）", "体重（kg）", "入园前由谁照看", "入园日期", "宝宝性格", "兴趣爱好", "喜欢吃的食物", "不喜欢吃的食物", "是否上过幼儿园", "是否能自己大小便","是否能自己穿衣服", "是否能自己吃饭", "是否有兄弟姐妹", "与兄弟姐妹关系","兄弟姐妹姓名", "兄弟姐妹年龄"], ["是否戴眼镜", "是否肥胖", "是否曾患过某种疾病","", "是否有过敏史","", "是否接种全部疫苗", ""]]
    
    var headImg: String = ""
    var usrFullName: String = ""
    var sex: String = ""
    var cprRelp: String = ""
    var piRmkName: String = ""
    
    /// 修改个人信息
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func updatePersonalInfo(_ fieldType: FieldType, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        switch fieldType {
        case .headImg:
            parameters["headImg"] = headImg as AnyObject
        case .usrFullName:
            parameters["usrFullName"] = usrFullName as AnyObject
        case .sex:
            parameters["sex"] = sex as AnyObject
        case .cprRelp:
            parameters["cprRelp"] = cprRelp as AnyObject
        default:
            parameters["piRmkName"] = piRmkName as AnyObject
        }
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.EditMyInfoAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 宝宝实例
    var babyModel: HFBabyModel?
    
    /// 查看宝宝
    /// - Parameters:
    ///   - ciId: 学员业务id
    ///   - successClosure: 请求成功
    ///   - failClosure: 请求失败
    /// - Returns: 无返回值
    func getBabyDetail(ciId: String,_ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        assert(!ciId.isEmpty, "学员业务id")
        var parameters = [String: AnyObject]()
        parameters["ciId"] = ciId as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.LookChildAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFBabyModel>>().map(JSON: dic as! [String : Any] )
            self.babyModel = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
//    //过敏详情
//    var ciAllergyInfo: String = ""
//    //未接种疫苗名称
//    var ciVaccination: String = ""
//    //曾经患有的疾病名称
//    var ciHadIllName: String = ""
    
    /// 获取宝宝档案字段
    func getStr(at indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return babyModel?.baseChildInfo?.ciNickname ?? ""
            case 1:
                if babyModel?.baseChildInfo != nil {
                    return babyModel!.baseChildInfo!.ciSex == 1 ? "男" : (babyModel!.baseChildInfo!.ciSex == 2 ? "女" : "未知")
                }
                return "未知"
            case 2:
                return babyModel!.baseChildInfo?.ciBirth.substring(to: 10) ?? ""
            case 3:
                let birth = babyModel!.baseChildInfo?.ciBirth.substring(to: 10) ?? ""
                return String.caculateAgeY(birthday: birth) + "岁"
            case 4:
                return babyModel?.baseChildInfo?.ciNationalityName ?? ""
            case 5:
                return babyModel?.baseChildInfo?.naName ?? ""
            case 6:
                return "居民身份证"
            case 7:
                return babyModel?.baseChildInfo?.ciCardNo ?? ""
            default:
                return babyModel?.baseChildInfo?.ciRegisteredProvince ?? ""
            }
        case 1:
            print("")
            return ""
        case 2:
            switch indexPath.row {
            case 0:
                return "\(babyModel?.baseChildInfo?.ciHeight ?? 0)"
            case 1:
                return "\(babyModel?.baseChildInfo?.ciWeight ?? 0)"
            case 2:
                return babyModel?.baseChildInfo?.ciBeCareByName ?? ""
            case 3:
                return (babyModel?.baseChildInfo?.ciAdmissionDate ?? "").substring(to: 10)
            case 4:
                return babyModel?.baseChildInfo?.ciCharacter ?? ""
            case 5:
                return babyModel?.baseChildInfo?.ciInterest ?? ""
            case 6:
                return babyModel?.baseChildInfo?.ciFavoriteFood ?? ""
            case 7:
                return babyModel?.baseChildInfo?.ciDislikeFood ?? ""
            case 8:
                if babyModel?.baseChildInfo?.ciSchooledStatus == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 9:
                if babyModel?.baseChildInfo?.ciSelfDefecation == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 10:
                if babyModel?.baseChildInfo?.ciSelfEat == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 11:
                if babyModel?.baseChildInfo?.ciSelfEat == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 12:
                if babyModel?.baseChildInfo?.ciOnlyChild == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 13:
                if (babyModel?.baseChildBrotherList.count ?? 0) > 0 {
                    return babyModel?.baseChildBrotherList[0].cbRelationName ?? ""
                }
                return ""
            case 14:
                if (babyModel?.baseChildBrotherList.count ?? 0) > 0 {
                    return babyModel?.baseChildBrotherList[0].cbName ?? ""
                }
                return ""
            case 15:
                if (babyModel?.baseChildBrotherList.count ?? 0) > 0 {
                    return "\(babyModel?.baseChildBrotherList[0].cbAge ?? 0)"
                }
                return ""
            default:
                if (babyModel?.baseChildBrotherList.count ?? 0) > 0 {
                    return babyModel?.baseChildBrotherList[0].cbName ?? ""
                }
                return ""
            }
        default:
            switch indexPath.row {
            case 0:
                if babyModel?.baseChildInfo?.ciMyopiaStatus == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 1:
                if babyModel?.baseChildInfo?.ciFatStatus == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 2:
                if babyModel?.baseChildInfo?.ciHadIll == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 3:
                if babyModel?.baseChildInfo?.ciHadIll == 1 {
                    return babyModel?.baseChildInfo?.ciHadIllName ?? ""
                }else{
                    return ""
                }
            case 4:
                if babyModel?.baseChildInfo?.ciHasAllergy == 1 {
                    return "是"
                }else{
                    return "否"
                }
            case 5:
                if babyModel?.baseChildInfo?.ciHasAllergy == 1 {
                    return babyModel?.baseChildInfo?.ciAllergyInfo ?? ""
                }else{
                    return ""
                }
            case 6:
                if babyModel?.baseChildInfo?.ciVaccinationStatus == 1 {
                    return "是"
                }else{
                    return "否"
                }
            default:
                if babyModel?.baseChildInfo?.ciVaccinationStatus == 1 {
                    return ""
                }else{
                    return babyModel?.baseChildInfo?.ciVaccination ?? ""
                }
            }
        }
    }
    
    /// 存储宝宝档案字段
    func setInfo(at indexPath: IndexPath, with conStr: String) -> Void {
        switch indexPath.row {
        case 0:
            self.contents[indexPath.row] = conStr
            self.personCenterInfo?.headImg = conStr
        case 1:
            self.contents[indexPath.row] = conStr
            self.personCenterInfo?.usrFullName = conStr
        case 2:
            self.contents[indexPath.row] = conStr
            if conStr == "男" {
                self.personCenterInfo?.usrSex = 1
            }else if conStr == "女"{
                self.personCenterInfo?.usrSex = 2
            }else{
//                self.personCenterInfo?.usrSex = conStr
            }
        case 3:
            self.contents[indexPath.row] = conStr
            self.personCenterInfo?.cprRelp = conStr
        default:
            self.contents[indexPath.row] = conStr
            self.personCenterInfo?.piRmkName = conStr
        }
    }
    
    // 我的信息
    var userInfo: HFUserInfoModel?
    
    // 个人中心信息
    var personCenterInfo: HFPersonCenterModel?
    
    /// 获取我的信息接口
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getMyInfo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        let ciId = HFBabyViewModel.shared.currentBaby?.ciId ?? ""
        if ciId.length() > 0 {
            parameters["ciId"] = ciId as AnyObject
        }
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.MyInfoAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFUserInfoModel>>().map(JSON: dic as! [String : Any] )
            self.userInfo = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    /// 获取个人中心接口
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getPersonCenterInfo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        parameters["ciId"] = (HFBabyViewModel.shared.currentBaby?.ciId ?? "") as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.MyCenterInfoAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFPersonCenterModel>>().map(JSON: dic as! [String : Any] )
            self.personCenterInfo = responseBaseModel?.model
            if self.personCenterInfo != nil {
                self.contents[0] = self.personCenterInfo?.headImg ?? ""
                if self.personCenterInfo?.usrSex == 1 {
                    self.contents[2] = "男"
                }else if self.personCenterInfo?.usrSex == 2 {
                    self.contents[2] = "女"
                }else{
                    self.contents[2] = "未知"
                }
                self.contents[1] = self.personCenterInfo?.usrFullName ?? ""
                self.contents[3] = self.personCenterInfo?.dicFieldName ?? ""
                self.contents[4] = self.personCenterInfo?.piRmkName ?? ""
            }
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    // MARK: 其它亲属相关的
    var anotherRelations = [HFBabyParentModel]()

    /// 获取其它亲属信息
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getAnotherRelations(_ page: Int, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        /**
         参数名    必选    类型    说明
         ciId    是    String    宝宝业务id
         usrId    否    String    用户业务id 家长端调用必传
         pageNum    否    Integer    当前页数
         pageSize    否    Integer
         */
        parameters["ciId"] = (HFBabyViewModel.shared.currentBaby?.ciId ?? "") as AnyObject
        parameters["usrId"] = HFUserInformation.userInfo()?.usrId as AnyObject
        parameters["pageNum"] = page as AnyObject
        parameters["pageSize"] = 10 as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.BabyParentListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFBabyParentModel>>>().map(JSON: dic as! [String : Any] )
            self.anotherRelations.removeAll()
            self.anotherRelations += responseBaseModel?.model?.list ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 添加其它亲属信息
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func addAnotherRelations(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure){
        var parameters = [String: AnyObject]()
        parameters["usrFullName"] = results[0] as AnyObject
        parameters["usrPhone"] = results[3] as AnyObject
        parameters["usrSex"] = results[2] as AnyObject
        parameters["cprRelp"] = cprRelp as AnyObject
        parameters["ciId"] = (HFBabyViewModel.shared.currentBaby?.ciId ?? "") as AnyObject
        parameters["type"] = "2" as AnyObject
//        parameters["kiId"] = (HFBabyViewModel.shared.currentBaby?.kiId ?? "") as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.BabyAddParentAPI, para: parameters, successed: { (response) in
//            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
//            let responseBaseModel = Mapper<HFResponsePageBaseModel<HFUserInfoModel>>().map(JSON: dic as! [String : Any] )
//            self.anotherRelations?.removeAll()
//            self.anotherRelations! += responseBaseModel.model ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 提示文本
    var addMembersTips = ["姓名", "与宝宝关系", "性别", "手机号"]
    /// 占位文字
    var addMembersPlaceholders = ["请输入姓名", "请选择", "请选择", "请输入手机号"]
    /// 保存编辑结果
    var results = ["", "", "", ""]
    
    /// 验证输入文本
    /// - Returns: 是否合法
    func verifyReslts() -> Bool {
        if results[0].isEmptyStr() {
            AlertTool.showBottom(withText: "请输入姓名")
            return false
        }
        if results[1].isEmptyStr() {
            AlertTool.showBottom(withText: "请选择家属与宝宝关系")
            return false
        }
        if results[2].isEmptyStr() {
            AlertTool.showBottom(withText: "请选择家属性别")
            return false
        }
        if results[3].isEmptyStr() || !results[3].isPhoneNum() {
            AlertTool.showBottom(withText: "请输入有效手机号")
            return false
        }
        return true
    }
}
