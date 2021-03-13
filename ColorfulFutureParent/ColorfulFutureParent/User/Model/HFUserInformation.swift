//
//  HFUserInformation.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

class HFUserInformation: NSObject{
    
    @objc var usrId: String = "" // 用户业务ID
    @objc var usrNeedChangePwd: Int = 0 // 是否需要强制修改密码0否1是
    @objc var usrAuthStatus: Int = 0 //0未实名，1实名 用户是否实名认证
    @objc var ucDestruction: Int = 0 // 用户端类型注销状态(0未注销，1注销中，2已注销)
    @objc var usrName: String = "" // 用户名
    @objc var ucFinishInfo: Int = 0 // 是否完成资料0否1是
    @objc var token: String = "" // 登录token
    @objc var usrNo: String = "" // 用户编号（前端显示的用户ID）
    @objc var diGrSchool: String = "" // 毕业院校
    @objc var usrBirthday: String = "" // 出生日期
    @objc var diNativePr: String = "" // 籍贯-省
    @objc var diNativePrCode: String = "" // 籍贯-省CODE
    @objc var diNhomPr: String = "" // 现居-省
    @objc var diNhomPrCode: String = "" // 现居-省CODE
    @objc var diNhomCity: String = "" // 现居-市
    @objc var diNhomCityCode: String = "" // 现居-市业务CODE
    @objc var diNhomCty: String = "" // 现居-县/区
    @objc var diNhomCtyCode: String = "" // 现居-县/区业务CODE
    @objc var diDetailAdd: String = "" // 现居详细地址
    @objc var headImg: String = "" // 头像
    @objc var diEducation: String = "" // 学历
    @objc var diRemarkName: String = "" // 备注名
    @objc var diId: String = "" // 园长业务ID
    @objc var diWorkYear: Int = 0 // 工作年限
    @objc var usrFullName: String = "" // 姓名
    @objc var usrPhone: String = "" // 手机号
    @objc var naId: String = "" // 名族
    @objc var ciSexDesc: String? { // 性别描述
        get{
            var desc = "未知"
            if self.usrSex == 1 {
                desc = "男"
            }
            if self.usrSex == 2 {
                desc = "女"
            }
            return desc
        }
    }
    @objc var usrSex: Int = 0 // 性别
    
    /// KVC
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("key:\(key)")
    }
    
    override func setNilValueForKey(_ key: String) {
        
    }
    
    /// Init
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        super.init()
        // KVC赋值
        setValuesForKeys(dict)
    }
    
    /// 归解档
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.mj_decode(aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        self.mj_encode(aCoder)
    }
    
    /// 存储
    @discardableResult
    public func save()->Bool{
        return NSKeyedArchiver.archiveRootObject(self, toFile: HFUserInformation.getArchivePath())
    }
    
    /// 删除归档信息，登出时调用
    @objc class func remove(complete: () -> ()) -> () {
        if FileManager.default.fileExists(atPath: HFUserInformation.getArchivePath()) == false {
            complete()
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: HFUserInformation.getArchivePath())
        }catch {}
        complete()
    }
    
    /// 登录校验
    func isLogin() -> Bool {
        return HFUserInformation.isLogin()
    }
    
    @objc class func isLogin() -> Bool {
        let user = HFUserInformation.userInfo()
        if user != nil && user?.token != "" && user?.ucDestruction == 0 {
            return true
        }
        return false
    }
    
    /// 解档，获取用户信息
    @objc class func userInfo()->HFUserInformation?{
        return  NSKeyedUnarchiver.unarchiveObject(withFile: getArchivePath()) as? HFUserInformation
    }
    
    /// 归档路径
    fileprivate class func getArchivePath() -> (String) {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! + "/user.date"
        return path
    }
    
}

extension HFUserInformation{
    /// 同步用户详细信息，网络请求
    @objc class func sync(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosureFail) -> Void {
        var parameters = [String: AnyObject]()
        parameters["ciId"] = HFBabyViewModel.shared.currentBaby?.ciId as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFBaseUseAPI.MyCenterInfoAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: Any])
            let res = self.sync(parameters: dic["model"] as! [String: Any])
            if res {
                print("同步用户信息成功")
            }else{
                print("同步用户信息失败")
            }
            
            successClosure()
        }) { (error) in
            print("同步用户信息失败")
            failClosure(error)
        }
    }
    
    /// 同步信息，外部传入用户信息字典
    @discardableResult
    @objc class func sync(parameters:[String: Any]) -> Bool {
        let user = HFUserInformation.userInfo()
        if user != nil {
            user!.setValuesForKeys(parameters)
            let res = user!.save()
            if res {
                print("同步用户信息保存成功")
                return true
            }else{
                print("同步用户信息保存失败")
                return false
            }
        }else{
            print("同步用户信息失败，本地未找到用户数据信息")
            return false
        }
    }
}
