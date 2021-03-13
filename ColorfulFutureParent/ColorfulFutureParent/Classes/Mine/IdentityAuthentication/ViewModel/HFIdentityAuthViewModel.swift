//
//  HFIdentityAuthViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/3.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
/// 认证类型
enum IdentityAuthType: Int {
    case personal = 1 //个人认证
    case kingdera //幼儿园认证
}


class HFIdentityAuthViewModel: NSObject {
    
    var cancelInfoModel: HFAuthCancelInfoModel?
    // 获取注销信息
    func getCancelStatus( _ successClosure: @escaping ()->(),  _ failClosure: @escaping (Error?)->()) {
        var parameters = [String: AnyObject]()
        parameters["clientType"] = HFClientInfo.currentClientType.rawValue as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFAuthorAPI.getCancelStatusAPI, para: parameters) { (response) in
            let dict = NSDictionary(dictionary: response)
            let response = Mapper<HFResponseBaseModel<HFAuthCancelInfoModel>>().map(JSON: dict  as! [String : Any])
            self.cancelInfoModel = response?.model
            successClosure()
        } failured: { (error) in
            failClosure(error)
        }
    }
    
    // 注销时/修改手机号 人脸识别认证
    @objc func faceVerifyCancel(verifyType: Int, image: UIImage,  _ successClosure: @escaping ()->(),  _ failClosure: @escaping (Error?)->()) {
        
        var parameters = [String: AnyObject]()
        parameters["verifyType"] = verifyType as AnyObject
        let imgData = image.jpegData(compressionQuality: 0.8)
        let baseImg = imgData?.base64EncodedString()
        parameters["imageBase64"] = baseImg as AnyObject

        HFSwiftService.requestData(requestType: .Post, urlString: HFAuthorAPI.FaceVerifyCancelAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure(error)
        }

    }
    
    func faceVerify(name: String, idCard: String, uaiAuthority:String, signDate:String, uaiValidity: String, image: UIImage, checktype: IdentityAuthType, _ successClosure: @escaping ()->(),  _ failClosure: @escaping (Error?)->()) {

        var parameters = [String: AnyObject]()
        parameters["name"] = name as AnyObject
        parameters["idCard"] = idCard as AnyObject
        let imgData = image.jpegData(compressionQuality: 0.8)
        let baseImg = imgData?.base64EncodedString()
        
//        let tmp = ["uaiRealName":name, "uaiIdCard":idCard, "uaiAuthority":uaiAuthority, "uaiValidity":uaiValidity]
        let tmp = ["uaiRealName":name, "uaiIdCard":idCard, "uaiAuthority":uaiAuthority, "uaiValidity":signDate.timeStrTranslate(), "uaiValidityEnd": uaiValidity.timeStrTranslate()]
        parameters["baseUserAuthenticationInfoAddParam"] = tmp as AnyObject
        parameters["imageBase64"] = baseImg as AnyObject
        parameters["checkType"] = checktype.rawValue as AnyObject
//        baseUserAuthenticationInfoAddParam
//        baseKgAuthenticationInfoAddParam
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFAuthorAPI.FaceVerifyAPI, para: parameters) { (response) in
            
            successClosure()
        } failured: { (error) in
            failClosure(error)
        }

    }
    var identityAuthModel: HFIdentityAuthMdoel?
    // 查询用户认证信息
    func checkUserFaceAuthentication(_ successClosure: @escaping ()->(),  _ failClosure: @escaping (Error?)->()) {
        HFSwiftService.requestData(requestType: .Get, urlString: HFAuthorAPI.checkFaceVerifyAPI, para: [:]) { (response) in
            let dict = NSDictionary(dictionary: response)
            let responseModel = Mapper<HFResponseBaseModel<HFIdentityAuthMdoel>>().map(JSON: dict as! [String : Any])
            self.identityAuthModel = responseModel?.model
            successClosure()
        } failured: { (error) in
            failClosure(error)
        }

    }
    
    var ideAuthType: IdentityAuthType = .personal
    
    let grTips = ["姓名", "身份证号", "签证机关", "有效期限"]
    var grPlacehoulders = ["", "", "", ""]
    var usrEditMsgs = ["", "", "", ""]

    let kingderTips = ["公司名称", "统一社会信用代码", "官方", "成立日期", "营业期限"]
    let kingderPlacehoulders = ["", "", "", "", ""]
    var usrEditKingderMsgs =  ["", "", "", "", ""]
    
    /// 身份证正
    var idenZImg: UIImage?
    /// 身份证反
    var idenFImg: UIImage?
    /// 营业执照
    var bussLisImg: UIImage?
    
}
