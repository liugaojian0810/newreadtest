//
//  HFLoginRegisterViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class HFLoginRegisterViewModel: NSObject {
    
    /// 注册账户
    func registAccount(usrPhone: String, verCode: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["phone"] = usrPhone as AnyObject // 用户手机号
        parameters["code"] = verCode as AnyObject // 验证码
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 端类型
        parameters["ucPushDevice"] = HFClientInfo.deviceType as AnyObject //推送设备类型
        parameters["ucPushDeviceNo"] = HFClientInfo.getPushDeviceToken() as AnyObject //推送设备唯一编号
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountRegistAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 注册发送验证码
    func sendCodeForRegister(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.SendCodeForRegisterAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    

    /// 发送快捷登录验证码
    func sendLoginSmsCode(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.SendCodeForLoginAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /*
     ullDeviceName    是    string    登录设备名称
     ullDeviceNo    是    string    设备唯一编号
     ucClientType    是    string    客户端类型：园长端(client_type_kg_app)，教师端(client_type_teacher)，家长端(client_type_parent)
     loginType    是    string    登录方式 0：手机号、用户名密码登录 1：手机号短信登录 2：微信登录
     nameOrPhone    否    string    登录用户名或手机号登录时必填
     code    否    string    短信验证码登录必填
     usrPassword    否    string    密码登录时必填
     ucWxOpenid    否    string    微信openid登录时必填
     */
    var loginType = 0
    var nameOrPhone = ""
    var code = ""
    var usrPassword = ""
    var ucWxOpenid = ""
    
    func login(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure, _ bindPhone: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        
        parameters["ullDeviceName"] = HFClientInfo.deviceName as AnyObject
        parameters["ullDeviceNo"] = HFClientInfo.deviceNo as AnyObject
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject
        parameters["loginType"] = loginType as AnyObject
        parameters["nameOrPhone"] = nameOrPhone as AnyObject
        parameters["code"] = code as AnyObject
        parameters["usrPassword"] = usrPassword as AnyObject
        parameters["ucWxOpenid"] = ucWxOpenid as AnyObject
        parameters["ucPushDevice"] = "ios" as AnyObject//终端平台(安卓：android 苹果：ios)
        let registId = UserDefaults.standard.object(forKey: "PushRegistrationID")
        parameters["ucPushDeviceNo"] = registId as AnyObject //推送设备唯一编号
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.LoginAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            if (dic["code"] as! Int) == 161057 {
                bindPhone()
            }else{
                let user = HFUserInformation.init(dict:dic["model"] as! [String : Any])
                let res = user.save()
                if res {
                    print("用户信息存储成功")
                }else{
                    print("用户信息存储失败")
                }
                successClosure()
            }
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 发送业务验证码
    func sendVcode(phone: String, bizType: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["bizType"] = bizType as AnyObject // 业务类型
        parameters["sign"] = "" as AnyObject // 验证码签名
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountSendBizVcodeAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 忘记密码 发送验证码
    func forgetPassword_sendMSG(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 登录类型
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.ForgetPasswordSendMSGAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 忘记密码 验证手机号和验证码
    /// - Parameters:
    ///   - checkPhone: 手机号17610775859
    ///   - code: 验证码
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func forgetPassword(checkPhone: String, code: String,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = checkPhone as AnyObject // 手机号
        parameters["code"] = code as AnyObject // 验证码
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.ForgetPasswordCheckAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 忘记密码设置密码
    /// - Parameters:
    ///   - phone: 手机号
    ///   - code: 验证码
    ///   - usrPassword: 第一次输入密码
    ///   - validatePassword: 第二次输入密码
    ///   - usrPwdLevel: 密码等级0低1中2高
    ///   - successClosure: 成功回调
    ///   - failClosure: 失败回调
    func forgetpassword(phone: String, code: String, usrPassword: String, validatePassword: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["code"] = code as AnyObject // 验证码
        parameters["usrPassword"] = usrPassword as AnyObject // 第一次输入密码
        parameters["validatePassword"] = validatePassword as AnyObject // 第二次输入密码
        parameters["usrPwdLevel"] = "\(usrPwdLevel)" as AnyObject
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.ForgetPasswordAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 我的---账户与安全修改密码
    /// - Parameters:
    ///   - oldPassword: 老密码
    ///   - usrPassword: 新密码第一次输入
    ///   - validatePassword: 新密码第二次输入
    ///   - usrPwdLevel: 密码等级
    ///   - successClosure:
    ///   - failClosure:
    func mineUpdatepassword(oldPassword: String, usrPassword: String, validatePassword: String, usrPwdLevel: Int,   _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["oldPassword"] = oldPassword as AnyObject // 老密码
        parameters["usrPassword"] = usrPassword as AnyObject // 新密码第一次输入
        parameters["validatePassword"] = validatePassword as AnyObject // 新密码第二次输入
        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject // 密码等级
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountMineUpdatePassowrdAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 绑定微信登录手机号
    /// - Parameters:
    ///   - phone: 手机号
    ///   - code: 验证码
    ///   - ucWxOpenid: 微信OpenId
    ///   - successClosure:
    ///   - failClosure:
    func loginWXBind(phone: String, code: String, ucWxOpenid: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
        parameters["ucWxOpenid"] = ucWxOpenid as AnyObject //微信openid
        parameters["code"] = code as AnyObject // 短信验证码
        parameters["ucPushDevice"] = "" as AnyObject // 推送-设备类型
        parameters["ucPushDeviceNo"] = "" as AnyObject //  推送设备唯一编号
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountWXBindPhoneAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 绑定微信发送验证码
    /// - Parameters:
    ///   - phone: 手机号
    ///   - successClosure:
    ///   - failClosure:
    func loginWXSendCode(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountWXLoginSendPhoneAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 微信登录设置密码
    /// - Parameters:
    ///   - usrPassword: 第一次输入的密码
    ///   - validatePassword: 第二次输入的密码
    ///   - usrPwdLevel: 密码等级0低1中2高
    ///   - successClosure:
    ///   - failClosure:
    func loginWXSetupPassword(usrPassword: String, validatePassword: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["usrPassword"] = usrPassword as AnyObject
        parameters["validatePassword"] = validatePassword as AnyObject //
        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject // 安全等级 0低 1中 2高

        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountWXLoginSetPassowrdAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 手机号验证码校验
    func phoneVcodeCheck(phone: String, vcode:String,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["vcode"] = vcode as AnyObject // 验证码
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountPhoneVcodeCheckAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 设置初始密码
    func setInitPassword(phone: String, usrPassword: String, validatePassword: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 端类型
        parameters["usrPassword"] = usrPassword as AnyObject  // 用户密码 md5(用户输入的原密码)
        parameters["validatePassword"] = validatePassword as AnyObject // 第二次输入的密码
        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject // 安全等级 0低 1中 2高
        parameters["ullDeviceName"] = HFClientInfo.deviceName as AnyObject
        parameters["ullDeviceNo"] = HFClientInfo.deviceNo as AnyObject
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountInitPasswordAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let user = HFUserInformation.init(dict:dic["model"] as! [String : Any])
            let res = user.save()
            
            if res {
                print("用户信息存储成功")
            }else{
                print("用户信息存储失败")
            }
            
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 通过验证码修改密码
    func updatePassword(usrPassword: String, vcode: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["usrPassword"] = usrPassword.jk_md5 as AnyObject  // 用户密码 md5(用户输入的原密码)
        parameters["vcode"] = vcode as AnyObject // 用户验证码
        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject // 安全等级 0低 1中 2高
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountForgetSmsPasswordAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 校验手机号是否绑定过微信
    func checkMobileWxBind(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject // 手机号
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountCheckMobileWxBindAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let complete = dic["model"] as! Bool
            //校验结果 true正确 false错误
            if complete {
                failClosure()
                AlertTool.showBottom(withText: "该手机号已绑定其它微信，请接触绑定后继续操作")
            }else{
                successClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 微信登录绑定手机号
    func weixinBindPhone(openId: String, phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["openId"] = openId as AnyObject  // 微信OpenId
        parameters["phone"] = phone as AnyObject // 手机号
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountWeixinBindPhoneAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
}



////
////  HFLoginRegisterViewModel.swift
////  ColorfulFuturePrincipal
////
////  Created by 范斗鸿 on 2020/11/30.
////  Copyright © 2020 huifan. All rights reserved.
////
//
//import Foundation
//
//class HFLoginRegisterViewModel: NSObject {
//
//    /// 注册账户
//    func registAccount(usrPhone: String, verCode: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//
//        var parameters = [String: AnyObject]()
//        parameters["usrPhone"] = usrPhone as AnyObject // 用户手机号
//        parameters["verCode"] = verCode as AnyObject // 验证码
//        parameters["ucClientType"] = "" as AnyObject // 端类型
//        parameters["ucPushDevice"] = "1" as AnyObject //推送设备类型
//        parameters["ucPushDeviceNo"] = "" as AnyObject //推送设备唯一编号
//
////        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountRegistAPI, para: parameters, successed: { (response) in
////            successClosure()
////        }) { (error) in
////            failClosure()
////        }
//    }
//
//    /// 发送业务验证码
//    func sendVcode(phone: String, bizType: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject // 手机号
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 业务类型
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.SendCodeForRegisterAPI, para: parameters, successed: { (response) in
//            successClosure()
//        }) { (error) in
//            failClosure()
//        }
//    }
//
//    /// 注册发送验证码
//    /// - Parameters:
//    ///   - phone: 注册手机号
//    ///   - type: 客户端类型 默认教师端
//    func register(phone: String, type: String = "client_type_teacher",  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String : AnyObject]()
//        parameters["phone"] = phone as AnyObject
//        parameters["ucClientType"] = type as AnyObject
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.SendCodeForRegisterAPI, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//    /// 三端统一登录接口
//    private func login(loginType: HFLoginType, nameOrPhone: String = "", code: String = "", usrPassword: String = "", ucWxOpenid: String = "", _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String: AnyObject]()
//        parameters["ullDeviceName"] = UIDevice.jk_version() as AnyObject // 登录设备名称
//        parameters["ullDeviceNo"] = UIDevice.current.identifierForVendor?.uuidString as AnyObject // 设备唯一编号
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
//        parameters["loginType"] = loginType.rawValue as AnyObject  // 推送-设备类型
//        parameters["nameOrPhone"] = nameOrPhone as AnyObject // 手机号
//        parameters["code"] = code as AnyObject // 验证码
//        parameters["usrPassword"] = usrPassword as AnyObject // 客户端类型
//        parameters["ucWxOpenid"] = ucWxOpenid as AnyObject  // 推送-设备类型
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountLoginAPI, para: parameters) { (response) in
//
//            let dic = NSDictionary(dictionary: response as [String : AnyObject])
//            let usr = HFUserInformation.init(dict: dic["model"] as! [String : AnyObject])
//            let res = usr.save()
//
//            if res {
//                print("用户信息存储成功")
//            } else {
//                print("用户信息存储失败")
//            }
//
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//
//    /// 手机号用户名 + 密码登录
//    /// - Parameters:
//    ///   - type: 登录类型
//    ///   - phoneOrUser: 手机号或者用户名
//    ///   - password: 密码
//    ///   - successClosure: 成功回调
//    ///   - failClosure: 失败回调
//    public func login(phoneOrUser: String, password: String,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        login(loginType: HFLoginType.ClientLoginTypeUserOrPhone_Passowrd, nameOrPhone: phoneOrUser, usrPassword: password, successClosure, failClosure)
//    }
//
//    /// 手机验证码快捷登录
//    /// - Parameters:
//    ///   - phone: 手机号
//    ///   - code: 验证码
//    ///   - successClosure: 成功回调
//    ///   - failClosure: 失败回调
//    public func login(phone: String, code: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        login(loginType: HFLoginType.ClientLoginTypePhone_Code, nameOrPhone: phone, code: code, successClosure, failClosure)
//    }
//
//    /// 微信登录
//    /// - Parameters:
//    ///   - wxOpenID: 手机号
//    ///   - successClosure: 成功回调
//    ///   - failClosure: 失败回调
//    public func login(wxOpenID: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        login(loginType: HFLoginType.ClientLoginTypeWX, ucWxOpenid: wxOpenID, successClosure, failClosure)
//    }
//
//    /// 快捷登录发送验证码
//    /// - Parameters:
//    ///   - phone: 手机号
//    ///   - successClosure: 成功回调
//    ///   - failClosure: 失败回调
//    public func loginSendMSGFor(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String : AnyObject]()
//        parameters["phone"] = phone as AnyObject // 手机号
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject  // 客户端类型
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountLoginSendMSG, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//
//    /// 绑定微信发送验证码
//    /// - Parameters:
//    ///   - phone: 手机号
//    ///   - successClosure:
//    ///   - failClosure:
//    func loginWXSendCode(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountWXLoginSendPhoneAPI, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//
//    /// 绑定微信登录手机号
//    /// - Parameters:
//    ///   - phone: 手机号
//    ///   - code: 验证码
//    func loginWXBind(phone: String, code: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
//        parameters["ucWxOpenid"] = "" as AnyObject //微信openid
//        parameters["code"] = "" as AnyObject // 短信验证码
//        parameters["ucPushDevice"] = "" as AnyObject // 推送-设备类型
//        parameters["ucPushDeviceNo"] = "" as AnyObject //  推送设备唯一编号
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountWXBindPhoneAPI, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//
//    }
//
//
//
//    /// 账号注册
//    func phoneVcodeCheck(phone: String, vcode:String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject // 手机号
//        parameters["code"] = vcode as AnyObject // 验证码
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
//        parameters["ucPushDevice"] = "ios" as AnyObject  // 推送-设备类型
//        let deviceStr = JPUSHService.registrationID()
//        parameters["ucPushDeviceNo"] = deviceStr as AnyObject // 推送设备唯一编号
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountRegistAPI, para: parameters, successed: { (response) in
//            successClosure()
//        }) { (error) in
//            failClosure()
//        }
//    }
//
//    /// 忘记密码
//    /// - Parameters:
//    ///   - phone: 手机号
//    ///   - usrPassword: 第一次输入密码
//    ///   - validatePassword: 第二次输入密码
//    ///   - usrPwdLevel: 密码等级0低1中2高
//    ///   - successClosure: <#successClosure description#>
//    ///   - failClosure: <#failClosure description#>
//    func forgetpassword(phone: String, usrPassword: String, validatePassword: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject // 手机号
//        parameters["usrPassword"] = usrPassword as AnyObject // 第一次输入密码
//        parameters["validatePassword"] = validatePassword as AnyObject // 第二次输入密码
//        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.ForgetPasswordAPI, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//
//    /// 忘记密码 发送验证码
//    func forgetPassword_sendMSG(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject // 手机号
//        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 登录类型
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.ForgetPasswordSendMSGAPI, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//
//    /// 忘记密码 验证手机号和验证码
//    /// - Parameters:
//    ///   - checkPhone: 手机号17610775859
//    ///   - code: 验证码
//    ///   - successClosure: 成功回调
//    ///   - failClosure: 失败回调
//    func forgetPassword(checkPhone: String, code: String,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = checkPhone as AnyObject // 手机号
//        parameters["code"] = code as AnyObject // 验证码
//
//        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.ForgetPasswordCheckAPI, para: parameters) { (response) in
//            successClosure()
//        } failured: { (error) in
//            failClosure()
//        }
//    }
//
//    func loinOut() {
//
////        HFSwiftService.requestData(requestType: .Put, urlString: HFLoginRegisterAPI.AccountLoginOutAPI, para: []) { (response) in
////
////        } failured: { (error) in
////
////        }
//
//    }
//
//    /// 设置初始化密码
//    func setInitPassword(usrPassword: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//        var parameters = [String: AnyObject]()
//        parameters["usrPassword"] = usrPassword.jk_md5 as AnyObject  // 用户密码 md5(用户输入的原密码)
//        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject // 安全等级 0低 1中 2高
//
////        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountInitPasswordAPI, para: parameters, successed: { (response) in
////            successClosure()
////        }) { (error) in
////            failClosure()
////        }
//    }
//
//    /// 通过验证码修改密码
//    func updatePassword(usrPassword: String, vcode: String, usrPwdLevel: Int,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//        var parameters = [String: AnyObject]()
//        parameters["usrPassword"] = usrPassword.jk_md5 as AnyObject  // 用户密码 md5(用户输入的原密码)
//        parameters["vcode"] = vcode as AnyObject // 用户验证码
//        parameters["usrPwdLevel"] = usrPwdLevel as AnyObject // 安全等级 0低 1中 2高
//
////        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountForgetSmsPasswordAPI, para: parameters, successed: { (response) in
////            successClosure()
////        }) { (error) in
////            failClosure()
////        }
//    }
//
//    /// 校验手机号是否绑定过微信
//    func checkMobileWxBind(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//        var parameters = [String: AnyObject]()
//        parameters["phone"] = phone as AnyObject // 手机号
////        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountCheckMobileWxBindAPI, para: parameters, successed: { (response) in
////            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
////            let complete = dic["model"] as! Bool
////            //校验结果 true正确 false错误
////            if complete {
////                successClosure()
////            }else{
////                failClosure()
////            }
////        }) { (error) in
////            failClosure()
////        }
//    }
//
//    /// 微信登录绑定手机号
//    func weixinBindPhone(openId: String, phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//        var parameters = [String: AnyObject]()
//        parameters["openId"] = openId as AnyObject  // 微信OpenId
//        parameters["phone"] = phone as AnyObject // 手机号
//
////        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AccountWeixinBindPhoneAPI, para: parameters, successed: { (response) in
////            successClosure()
////        }) { (error) in
////            failClosure()
////        }
//    }
//}
