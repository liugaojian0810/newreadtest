//
//  HFAccountInfoModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFAccountInfoModel: Mappable {
    
    /**
     {
         "usrId": "555", // 用户业务ID
         "diId": "DI20201120038084072", // 园长业务ID
         "usrNo": null, // 用户编号
         "usrName": "9992", // 用户名
         "usrFullName": "999", // 姓名
         "usrSex": 0, // 性别
         "usrPhone": "12312312312", // 手机号
         "headImg": "", // 头像
         "diRemarkName": "老魏", // 备注名
         "diWorkYear": "", // 工作年限
         "usrBirthday": "2020-11-12", // 生日
         "diGrSchool": "", // 毕业院校
         "diEducation": "", // 学历
         "naId": "", // 民族
         "diNhomPr": "北京市", // 省
         "diNhomPrCode": "", // 省code
         "diNhomCity": "北京市", // 市
         "diNhomCityCode": "", // 市code
         "diNhomCty": "东城区", // 区
         "diNhomCtyCode": "", // 区code
         "diDetailAdd": "长安街二号院", // 详细地址
         "diNativePr": "北京市", // 籍贯-省
         "diNativePrCode": "" // 省code
     }
     */
    var diGrSchool: String = ""
    var usrBirthday: String = ""
    var diNhomCty: String = ""
    var headImg: String = ""
    var diEducation: String = ""
    var diDetailAdd: String = ""
    var diRemarkName: String = ""
    var diId: String = ""
    var diWorkYear: String = ""
    var diNhomCity: String = ""
    var usrName: String = ""
    var diNhomPr: String = ""
    var usrFullName: String = ""
    var diNhomCtyCode: String = ""
    var usrId: String = ""
    var usrPhone: String = ""
    var naId: String = ""
    var usrSex: Int = 0
    var diNhomCityCode: String = ""
    var usrNo: String = ""
    var diNhomPrCode: String = ""
    var diNativePr: String = ""
    var diNativePrCode: String = ""
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        /**
         usrId    String    用户业务ID
         diId    String    园长业务ID
         usrFullName    String    姓名
         usrPhone    String    手机号
         usrBirthday    String    出生日期
         diNativePr    String    籍贯-省
         diNativePrCode    String    籍贯-省CODE
         diNhomPr    String    现居-省
         diGrSchool    String    毕业院校
         diEducation    String    学历
         diNhomPrCode    String    现居-省业务CODE
         diNhomCity    String    现居-市
         diNhomCityCode    String    现居-市业务CODE
         diNhomCty    String    现居-县/区
         diNhomCtyCode    String    现居-县/区业务CODE
         diDetailAdd    String    现居详细地址
         */
        diGrSchool    <- map["diGrSchool"]
        usrBirthday    <- map["usrBirthday"]
        diNhomCty    <- map["diNhomCty"]
        headImg    <- map["headImg"]
        diEducation    <- map["diEducation"]
        diDetailAdd    <- map["diDetailAdd"]
        diRemarkName    <- map["diRemarkName"]
        diId    <- map["diId"]
        diWorkYear    <- map["diWorkYear"]
        diNhomCity    <- map["diNhomCity"]
        usrName    <- map["usrName"]
        diNhomPr    <- map["diNhomPr"]
        usrFullName    <- map["usrFullName"]
        diNhomCtyCode    <- map["diNhomCtyCode"]
        usrId    <- map["usrId"]
        usrPhone    <- map["usrPhone"]
        naId    <- map["naId"]
        usrSex    <- map["usrSex"]
        diNhomCityCode    <- map["diNhomCityCode"]
        usrNo    <- map["usrNo"]
        diNhomPrCode    <- map["diNhomPrCode"]
        diNativePr    <- map["diNativePr"]
        diNativePrCode    <- map["diNativePrCode"]
    }
    
    
    
    
    //    var note: String = "" // 备注名
    //    var gender: Int? // 性别
    //    var userName: String = "" // 用户名
    //    var name: String = "" // 姓名
    //    var birthday: String = "" // 出生日期
    //    var nativePlace: String = "" // 籍贯
    //    var graduateSchool: String = "" // 毕业院校
    //    var highestSchool: String = "" // 学历
    //    var address: String = "" // 现居住地址
    //    var addressDetail: String = "" // 详细地址
    //
    //
    //    /**
    //     {
    //         "usrId":"", // 用户业务ID
    //         "usrHeadImg":"", // 头像
    //         "diRemarkName":"", // 备注名
    //         "usrSex":0, // 性别
    //         "usrName":"", // 用户名（可用于登录）
    //         "diId":"园长详情业务Id"
    //     }
    //     */
    //
    //    //园长个人信息
    //    var diId: String = ""
    //    var usrId: String = ""
    //    var usrSex: Int = 0
    //    var usrHeadImg: String = ""
    //    var diRemarkName: String = ""
    //    var usrName: String = ""
    //
    //
    //    /**
    //     {
    //         "diId":"", // 园长业务ID
    //         "usrFullName":"", // 姓名
    //         "usrPhone":"", // 手机号
    //         "usrBirthday":"", // 出生日期
    //         "diNativePr":"", // 籍贯-省
    //         "diNativePrCode":"", // 籍贯-省CODE
    //         "diGrSchool":"", // 毕业院校
    //         "diEducation":"", // 学历
    //         "diNhomPr":"", // 现居-省
    //         "diNhomPrCode":"", // 现居-省业务CODE
    //         "diNhomCity":"", // 现居-市
    //         "diNhomCityCode":"", // 现居-市业务CODE
    //         "diNhomCty":"", // 现居-县/区
    //         "diNhomCtyCode":"", // 现居-县/区业务CODE
    //         "diDetailAdd":"", // 现居详细地址
    //     }
    //     */
    //    //获取园长详细信息
    //    var diNhomCityCode: String = ""
    //    var diGrSchool: String = ""
    //    var diDetailAdd: String = ""
    //    var usrBirthday: String = ""
    ////    var diId: String = ""
    //    var diEducation: String = ""
    //    var usrPhone: String = ""
    //    var diNativePrCode: String = ""
    //    var diNhomPr: String = ""
    //    var diNhomCtyCode: String = ""
    //    var diNhomPrCode: String = ""
    //    var diNhomCity: String = ""
    //    var diNhomCty: String = ""
    //    var diNativePr: String = ""
    //    var usrFullName: String = ""
    //
    //    required init?(map: Map) {
    //
    //    }
    //
    //    func mapping(map: Map) {
    //
    //        diId <- map["diId"]
    //        usrId <- map["usrId"]
    //        usrSex <- map["usrSex"]
    //        usrHeadImg <- map["usrHeadImg"]
    //        diRemarkName <- map["diRemarkName"]
    //        usrName <- map["usrName"]
    //
    //        diNhomCityCode <- map["diNhomCityCode"]
    //        diGrSchool <- map["diGrSchool"]
    //        diDetailAdd <- map["diDetailAdd"]
    //        usrBirthday <- map["usrBirthday"]
    //        diEducation <- map["diEducation"]
    //        usrPhone <- map["usrPhone"]
    //        diNativePrCode <- map["diNativePrCode"]
    //        diNhomPr <- map["diNhomPr"]
    //        diNhomCtyCode <- map["diNhomCtyCode"]
    //        diNhomPrCode <- map["diNhomPrCode"]
    //        diNhomCity <- map["diNhomCity"]
    //        diNhomCty <- map["diNhomCty"]
    //        diNativePr <- map["diNativePr"]
    //        usrFullName <- map["usrFullName"]
    //    }
}
