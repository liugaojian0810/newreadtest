//
//  HFSetupViewModel.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/19.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import WebKit

enum QrCodeType {
    case findPass //找回密码
    case verifyAccount //验证账号
}



@objc
class HFSetupViewModel: NSObject {
    
    
    // MARK: 设置
    
    var tipsAtHome = [["账号与安全"],["问题反馈", "消息通知", "关于我们", "版本更新", "清理缓存"]]
    
    /// 获取时间戳md5加密
    func getSign() -> String {
        let time = HFDateManager.share().getCurrentTimeStamp()
        let timeSign = time + "6ebbd80c3805467ebf17afa200a44ee9"
        let md5 = timeSign.DDMD5Encrypt(.lowercase32)
        let md5Str = time + md5 // 时间 +  md5
        return md5Str
    }
    
    func calcuSpace() -> String{
        let diskSize: Double = Double(SDImageCache.shared.totalDiskSize())
        let mBCache = diskSize/1000.00/1000.00;
        let sizeStr = String(format: "%.1fMB", mBCache)
        return sizeStr
    }
    
    ///清理缓存
    func clearCache() -> Void {
        self.clearCaches()
        self.deleteWebCache()
        SDImageCache.shared.clearDisk {
            
        }
        AlertTool.showTop(withText: "清理成功")
    }
    
    func clearCaches()  {
        //清除cookies
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
        //清除UIWebView的缓存
        let cache = URLCache.shared
        cache.removeAllCachedResponses()
        cache.diskCapacity = 0
        cache.memoryCapacity = 0
    }
    
    func deleteWebCache() {
        //allWebsiteDataTypes清除所有缓存
        let webSet = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = NSDate.init(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: webSet, modifiedSince: date as Date) {
        }
    }
    
    // 推送是否关闭
    var isCloseNotify: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "HFNotifyOnKey")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HFNotifyOnKey")
        }
    }
    
    /// 消息通知开关
    func notifySwitch(_ on: Bool, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["ucPushOn"] = ((on == true) ? "1" : "0") as AnyObject
        parameters["ucPushDevice"] = HFClientInfo.deviceType as AnyObject //推送设备类型
        parameters["ucPushDeviceNo"] = HFClientInfo.getPushDeviceToken() as AnyObject //推送设备唯一编号
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.NoticeSwitchAPI, para: parameters, successed: { (response) in
            self.isCloseNotify = !on
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    var userDeleteCheck: HFUserCheckDelete?
    /// 检查用户是否可以注销
    func checkuserdelete( _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFLoginRegisterAPI.AccountDeleteCheck, para: [:]) { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFUserCheckDelete>>().map(JSON: dic as! [String : Any] )
            self.userDeleteCheck = responseBaseModel?.model
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }

    /// 使用当前手机号发送验证码 校验用户
    func sendCheckAccountCode(phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject
        parameters["bizType"] = "current_vcode" as AnyObject
        // sign
        let signStr = getSign()
        parameters["sign"] = signStr as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountOfCurrentSendCode, para: parameters) { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFUserCheckDelete>>().map(JSON: dic as! [String : Any] )
            self.userDeleteCheck = responseBaseModel?.model
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 修改绑定的推送设备号
    func saveNotifyDeviceNo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["ucPushDevice"] = HFClientInfo.deviceType as AnyObject //推送设备类型
        parameters["ucPushDeviceNo"] = HFClientInfo.getPushDeviceToken() as AnyObject //推送设备唯一编号
        
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.DeviceNoAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 退出登录
    func letout(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.LogoutAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    /// 账号退出， 公共部分 三端通用
    func logou(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Put, urlString: HFLoginRegisterAPI.AccountLoginOutAPI, para: parameters, successed: { (response) in
            HFUserInformation.remove {
                successClosure()
            }
        }) { (error) in
            HFUserInformation.remove {
                failClosure()
            }
        }
    }
    
    ///版本信息
    @objc var version: HFAppVersionModel?
    
    /// 园长端获取APP版本信息
    @objc func appVersion(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["platform"] = "ios" as AnyObject //终端平台(安卓：android 苹果：ios)
        parameters["clientType"] = HFClientInfo.currentClientType.rawValue as AnyObject //产品平台(家长端：client_type_parent 园长端：client_type_kg_app 教师端: client_type_teacher 家长端机器人 client_type_robot)
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.AppVersionAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFAppVersionModel>>().map(JSON: dic as! [String : Any] )
            self.version = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    @objc var pbContent: String = ""
    @objc var imgs: [UIImage]?
    @objc var imagesModel: [HFImageUploadResultModel]?
    
    @objc func feedback(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) ->Void {
        
        if self.pbContent.isEmptyStr() {
            AlertTool.showBottom(withText: "请输入描述内容")
            return
        }else{
            var parameters = [String: AnyObject]()
            parameters["pbType"] = "1" as AnyObject //问题类型0投诉1建议
            parameters["pbClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject //端类型：client_type_teacher=教师端APP；client_type_parent=家长端APP；client_type_kg_app=园长端App
            parameters["pbDeviceType"] = HFClientInfo.deviceType as AnyObject //手机类型（1：苹果 2：安卓）
            parameters["pbContent"] = pbContent as AnyObject //
            if imgs?.count != 0 && imagesModel != nil {
                var pics = [Any]()
                for model in imagesModel! {
                    var dic = [String: String]()
                    dic["fiId"] = model.fiId
                    dic["fiAccessPath"] = model.fiAccessPath
                    pics.append(dic)
                }
                parameters["pbImages"] = pics as AnyObject //
            }
            HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.FeedbackAPI, para: parameters, successed: { (response) in
                successClosure()
            }) { (error) in
                failClosure()
            }
        }
    }
    
    
    // MARK: 账号与安全
    
    //标签
    var tips = [ "用户名","用户ID","手机号", "登录密码", "微信", "登录设备记录"]
    //内容
    var contents = ["","", "", "", "未绑定", ""]
    //绑定微信
    var binding: Bool = true
    
    //账号安全信息
    var secur: HFAccountSecurInfoModel?
    
    /// 列表标题
    var securLevel: String {
        get{
            if secur != nil {
                switch secur!.usrPwdLevel {
                case 0:
                    return "安全等级：低"
                case 1:
                    return "安全等级：中"
                case 2:
                    return "安全等级：高"
                default:
                    return "安全等级：-"
                }
            }else{
                return "安全等级：-"
            }
        }
        set{
            
        }
    }
    
    /// 获取账号安全信息
    func accountSecuInfo(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.AccountSecuInfoAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            self.secur = HFAccountSecurInfoModel(JSON: dic["model"] as! [String : Any])
            if self.secur?.weixinBindStatus == 0 { //微信绑定状态 1已绑定 0未绑定
                self.binding = false
            }else{
                self.binding = true
            }
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    /// 用户名
    var usrName = ""
    /// 密码
    var usrPassword = ""
    
    /// 修改用户名叫验密码
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func checkPassowordAPI(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["usrPassword"] = usrPassword as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.CheckPassowordAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let haveBinded = dic["model"] as! Bool
//            #warning("测试完成之后需要删除")
//            haveBinded = true
            if haveBinded {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 修改用户名
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func updateUserName(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["usrName"] = usrName as AnyObject
        parameters["usrPassword"] = usrPassword as AnyObject
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.UserUpdateUserNameAPI, para: parameters, successed: { (response) in
            HFAccountRelevantManager.shared.employeeInfo?.usrName = self.usrName
            HFAccountRelevantManager.shared.kinder?.baseUser?.usrName = self.usrName
            let userInfo = HFUserInformation.userInfo()
            userInfo?.usrName = self.usrName
            userInfo?.save()
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    // 用户微信OpenId
    var ucWxOpenid: String = ""
    
    /// 用户绑定/解绑微信微信
    func bindingWeChat(_ bind: Bool, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        if bind {
            parameters["ucWxOpenid"] = ucWxOpenid as AnyObject
            HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountBindWeChatAPI, para: parameters, successed: { (response) in
                self.binding = true
                successClosure()
            }) { (error) in
                failClosure()
            }
        }else{
            HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountWeixinUnBindWeChatAPI, para: parameters, successed: { (response) in
                self.binding = false
                successClosure()
            }) { (error) in
                failClosure()
            }
        }
    }
    
    // 微信是否已经绑定其他账号
    var haveBinded: Bool = false
    
    //校验微信是否绑定过其它账号
    func weChatBindStateVerify(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["ucWxOpenid"] = ucWxOpenid as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.AccountCheckBindWeChatAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let haveBinded = dic["model"] as! Bool
            if haveBinded {
                self.haveBinded = true
            }else{
                self.haveBinded = false
            }
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    
    // MARK: 密码
    //老密码
    var oldPass: String = ""
    //新密码
    var pass: String = ""
    //确认密码
    var deteminPass: String = ""
    
    /// 原密码校验
    func verifyOldPassword(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["usrPassword"] = oldPass as AnyObject //用户当前密码
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountOldPasswordVerifyAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let complete = dic["model"] as! Bool
            //原始密码校验结果
            if complete {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 用户修改密码
    func updateNewPassword(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        /**
         {
         "oldPassword":"用户旧密码",
         "newPassword":"用户新密码"
         }
         */
        parameters["oldPassword"] = oldPass as AnyObject
        parameters["newPassword"] = pass as AnyObject
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountUpdatePasswordAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            
            failClosure()
        }
    }
    
    // MARK: 手机号
    //老的手机号
    @objc var oldPhone: String = ""
    //手机号
    @objc var phone: String = ""
    //二维码
    @objc var qrCode: String = ""
    ///用户手机号校验
    @objc func verifyOldPhone(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        if oldPhone.isEmptyStr() || !oldPhone.isPhoneNum(){
            AlertTool.showBottom(withText: "请输入有效手机号")
            return
        }else{
            var parameters = [String: AnyObject]()
            parameters["usrPhone"] = oldPhone as AnyObject //用户当前密码
            HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountOldPhoneVerifyAPI, para: parameters, successed: { (response) in
                let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
                let complete = dic["model"] as! Bool
                //校验结果 true正确 false错误
                if complete {
                    successClosure()
                }else{
                    failClosure()
                }
            }) { (error) in
                failClosure()
            }
        }
    }
    
    /// 修改新手机号发送验证码
    /// - Parameters:
    ///   - phone: 新手机号
    ///   - successClosure:
    ///   - failClosure:
    @objc func updateNewPhoneSendMsg(_ phone: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject
        parameters["ucClientType"] = HFClientInfo.currentClientType.rawValue as AnyObject // 客户端类型
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.SetNewPhoneSendMSGPhoneAPI, para: parameters) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 新接口 修改手机号
    /// - Parameters:
    ///   - oldPhone: 老手机号
    ///   - newPhone: 新手机号
    ///   - code: 验证码
    ///   - successClosure:
    ///   - failClosure:
    @objc func setNewPhone(_ oldPhone: String, _ newPhone: String, _ code: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["oldPhone"] = oldPhone as AnyObject
        parameters["newPhone"] = phone as AnyObject
        parameters["code"] = code as AnyObject
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.SetNewPhoneAPI, para: parameters) { (response) in
            let userInfo = HFUserInformation.userInfo()
            userInfo?.usrPhone = self.phone
            userInfo?.save()
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    /// 用户修改手机号
//    @objc func updateNewPhone(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
//        var parameters = [String: AnyObject]()
//        /**
//         {
//         "oldPhone":"15210091001", // 用户原手机号
//         "newPhone":"15210091001", // 用户新手机号
//         "newPhoneVcode":"202303" // 新手机号验证码
//         }
//         */
//        parameters["oldPhone"] = oldPhone as AnyObject
//        parameters["newPhone"] = phone as AnyObject
//        parameters["newPhoneVcode"] = qrCode as AnyObject
//        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountUpdatePhoneAPI, para: parameters, successed: { (response) in
//            successClosure()
//        }) { (error) in
//
//            failClosure()
//        }
//    }
    
    
    /// 登录设备记录
    lazy var logs = [HFLoginDeviceModel]()
    /// 设备记录总数
    var logsTotal = 0
    
    /// 登录设备记录列表
    @objc func loginLogList(_ page: Int, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        /**
         {
         "pageNum": 1, // 当前页数
         "pageSize": 10, // 每页记录条数
         }
         */
        parameters["pageSize"] = "15" as AnyObject
        parameters["pageNum"] = "\(page)" as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.LoginLogListAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFLoginDeviceModel>>>().map(JSON: dic as! [String : Any] )
            if page == 1 {
                self.logs.removeAll()
            }
            self.logs += responseBaseModel?.model?.list ?? []
            self.logsTotal = responseBaseModel?.model?.total ?? 0
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 删除登录设备记录
    @objc func deleteLoginLog(_ indexPath: IndexPath,  _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        /**
         {
         "ullId":"ul2020081700000120", // 设备记录业务主键
         }
         */
        let record = self.logs[indexPath.row]
        parameters["ullId"] = record.ullId as AnyObject //设备记录业务主键
        HFSwiftService.requestData(requestType: .Delete, urlString: HFBaseUseAPI.DeleteLoginLogAPI, para: parameters, successed: { (response) in
            self.logs.remove(at: indexPath.row)
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    // 登录设备列表跳转详情时传参
    var loginDeviceModel: HFLoginDeviceModel?
    var deviceName: String = ""
    
    /// 更新设备名称
    @objc func updateLoginDeviceName( _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["ullId"] = loginDeviceModel?.ullId as AnyObject //设备记录业务主键
        parameters["ullDeviceName"] = deviceName as AnyObject // 设备名称
        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.DeleteLoginLogAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    var devicePhone: String = ""
    var deviceCode: String = ""
    var deviceNo: String = ""
    
    ///其它设备登录短信验证
    @objc func loginDeviceVerify(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.HaveKingdergationAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let complete = dic["model"] as! Bool
            //校验结果 true正确 false错误
            if complete {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    ///校验园长是否有幼儿园接口
    @objc func haveKinderga(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.HaveKingdergationAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let complete = dic["model"] as! Int // 当前登录园长下的幼儿园数量，结果大于0表示园长有幼儿园，否则没有
            //校验结果 true正确 false错误
            if complete > 0 {
                successClosure()
            }else{
                failClosure()
            }
        }) { (error) in
            failClosure()
        }
    }
    
    /// 钱包余额
    var walletBalance: HFWalletBalanceModel?
    
    /// 账号钱包余额查询
    @objc func walletInfoBalance(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.WalletBalanceAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFWalletBalanceModel>>().map(JSON: dic as! [String : Any] )
            self.walletBalance = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 校验手机号验证码
    func verifyPhoneQrCode(phone: String, _ vcodeType: QrCodeType, _ code: String,_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["phone"] = phone as AnyObject//手机号
        parameters["vcode"] = code as AnyObject //手机号
        parameters["vcodeType"] = "current_vcode" as AnyObject //手机号
        parameters["sign"] = getSign() as AnyObject //手机号

        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountOfCurrentCheck, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 用户提交撤销申请
    func userCommitDestruction(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountFinalRquest, para: [:]) { (response) in
            successClosure()
        } failured: { (error) in
            failClosure()
        }
    }
    
    ///客服电话
    var serviceTelephone: String = ""
    
    /// 获取客服电话
    func getCustomerServiceTelephone(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.CompanyPhoneAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let complete = dic["model"] as! String
            self.serviceTelephone = complete
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 用户注销申请ID
    var udlId: String = ""
    
    /// 园长撤销注销申请
    func undoCancellation(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
 
        HFSwiftService.requestData(requestType: .Post, urlString: HFLoginRegisterAPI.AccountRevokeDeleteRquest, para: [:], successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 用户协议
    var agreement: HFUserAgreement?
    
    /// 获取用户协议接口
    @objc func getUserAgreement(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        var parameters = [String: AnyObject]()
        parameters["id"] = "2" as AnyObject //协议ID
        parameters["clientType"] = "2" as AnyObject //0 家长 1教师 2园长
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.GetUserAgrementAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFUserAgreement>>().map(JSON: dic as! [String : Any] )
            self.agreement = responseBaseModel?.model
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    ///  园长注销提现接口
    var walletId: String = ""
    var mainBodyName: String = ""
    var cardId: String = ""
    var cardType: String = ""
    var takeAmount: String = ""
    var password: String = ""
    func cancelWallet(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        /**
         {
         "walletId":10000, // 钱包Id
         "mainBodyName":"XX幼儿园", // 主体名称
         "cardId":98, // 银行卡id号
         "cardType":1, // 卡类型 1个人银行卡 2企业银行卡
         "takeAmount":100, // 提现金额,必须是全部金额
         "password":"123456" // 支付密码
         }
         */
        var parameters = [String: AnyObject]()
        parameters["walletId"] = walletId as AnyObject
        parameters["mainBodyName"] = mainBodyName as AnyObject
        parameters["cardId"] = cardId as AnyObject
        parameters["cardType"] = cardType as AnyObject
        parameters["takeAmount"] = takeAmount as AnyObject
        parameters["password"] = password as AnyObject
        HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.CancelWalletAPI, para: parameters, successed: { (response) in
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    
    
    
    /// 撤销注销申请
    //    func cancelCancellation(udlId: String, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
    //
    //        var parameters = [String: AnyObject]()
    //        parameters["udlid"] = udlId as AnyObject
    //
    //        HFSwiftService.requestData(requestType: .Put, urlString: HFBaseUseAPI.AccountCancelLogoffAPI, para: parameters) { (response) in
    //
    //            successClosure()
    //        } failured: { (error) in
    //
    //            failClosure()
    //        }
    //    }
    
}
