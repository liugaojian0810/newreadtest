//
//  HFSwiftService.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

/// 网路状态
@objc enum HFNetworkStatus: Int32 {
    case  HttpUnknow       = -1  //未知
    case  HttpNoReachable  = 0  // 无网络
    case  HttpWwan         = 1   //2g，3g，4g
    case  HttpWifi         = 2  // wifi
}

/// 请求方式
@objc(RequestType)

enum RequestType: Int {
    case Get
    case Post
    case Put
    case Delete
}

/// 相关回调定义
typealias NetworkStatus = (_ HFNetworkStatus: Int32) -> ()

/// 成功回调
typealias ResComplete = (_ responseObject: [String: Any]) -> ()

/// 失败回调
typealias ResFail = (_ error: Error) -> ()

/// 进度回调
typealias ResProgress = (_ progress: Double) -> Void

let ServiceHosts = ["https://dev-edu-hfsaas.huifanayb.cn", "https://test-edu-hfsaas.huifanayb.cn"]
let HFHotfixServiceHostUrlKry = "HFHotfixServiceHostUrlKry"

/// 网络请求地址主机地址
class  HFSwiftServiceFactory {
    var hostName: String {
        get{
            #if DEBUG
            if let hostUrl = UserDefaults.standard.value(forKey: HFHotfixServiceHostUrlKry) as? String {
                return hostUrl
            }else{
                return S_HOST_DEBUG
            }
            #else
            return S_HOST_RELEASE
            #endif
        }
    }
}


@objc(HFSwiftService)
class HFSwiftService: NSObject {
    let manager: SessionManager = {
        var defaultHeader = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]
        let defaultConfig = URLSessionConfiguration.default
        defaultConfig.timeoutIntervalForRequest = 20
        defaultConfig.httpAdditionalHeaders = defaultHeader
        let sessionManager =  Alamofire.SessionManager(configuration: defaultConfig, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
        return sessionManager
    }()
}


extension HFSwiftService {
    
    @objc static func requestData(requestType: RequestType, urlString: String, para: [String: AnyObject], successed: @escaping ResComplete, failured: @escaping ResFail) {
        
        //获取请求类型
        var method: HTTPMethod = .get
        switch requestType {
        case .Get:
            method = HTTPMethod.get
        case .Post:
            method = HTTPMethod.post
        case .Put:
            method = HTTPMethod.put
        case .Delete:
            method = HTTPMethod.delete
        }
        
        //当前时间的时间戳
        let timeInteral: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInteral)
        
        let token: String = HFUserInformation.userInfo()?.token ?? ""
        let tokenMd5: NSString = NSString(string: token)
        
        let  httpUrl = HFSwiftServiceFactory().hostName + urlString
        #if DEBUG
        print("user token:\(token)")
        let data = try! JSONSerialization.data(withJSONObject: para, options: .prettyPrinted)
        let strJson = String.init(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        print("\nurl:" + httpUrl + "\npara:" + strJson!)
        #endif
        if method == .post || method == .put || method == .delete {
            //发送网络请求
            var request = URLRequest.init(url:URL.init(string: httpUrl)!)
            let data = try! JSONSerialization.data(withJSONObject: para, options: .prettyPrinted)
            request.httpBody = data
            request.httpMethod = method.rawValue
            request.setValue(token, forHTTPHeaderField: "token")
            request.setValue(UIDevice.jk_version(), forHTTPHeaderField: "version")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            Alamofire.request(request).validate().responseJSON { (response) in
                HFSwiftService.checkRequestResult(successed: successed, failured: failured, response: response)
            }
        }else{
            //签名和密钥信息、 这个做安全对接的时候需要补充
            let headers: HTTPHeaders = [
                "requestToken":tokenMd5.md5(),
                "requestTime": "\(timeStamp)",
                "sign": "SHA1算法签名",
                "token": token,
                "version": UIDevice.jk_version()
            ]
            Alamofire.request(httpUrl, method: method, parameters: para, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                
                HFSwiftService.checkRequestResult(successed: successed, failured: failured, response: response)
                
            }
        }
    }
    
    /// 处理网络请求结果
    static func checkRequestResult(successed: @escaping ResComplete, failured: @escaping ResFail, response: (DataResponse<Any>)) -> Void {
        switch response.result {
        case .success(let json):
            // 服务器有返回数据
            if let result = json as? [String: Any] {
                #if DEBUG
                print(result)
                #endif
                let code = result["code"] as? Int
                if (code == 200 || code == 70200) {
                    /** 处理请求成功数据*/
                    successed(result)
                }else if code == 161057 {
                    /** 需绑定手机号*/
                    successed(result)
                }else if code == 161166 {
                    /** 宝宝入园申请表已存在，是否同步宝宝数据*/
                    successed(result)
                }else if code == 161034 {
                    /** 钱包已开通*/
                    successed(result)
                }else if code == 161178 {
//                    successed(result)
                    /** 没有完善信息*/
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NeedImproveInformation"), object: nil, userInfo: nil)
                }
                else{
                    var errorMsg = HFErrorCodeHandling.errorMessage("\(code ?? 0)")
                    if errorMsg.isEmptyStr() {
                        var errorMessage = result["message"] as? String
                        if errorMessage == nil {
                            errorMessage = result["error"] as? String
                        }
                        if errorMessage == nil {
                            errorMessage = "请求失败"
                        }
                        errorMsg = errorMessage!
                    }
                    let error = NSError(domain:NSURLErrorDomain , code: code ?? NSURLErrorBadServerResponse, userInfo: [NSLocalizedDescriptionKey:errorMsg])
                    HFSwiftService.handleReqError(error: (error as NSError), faliedBlock: failured)
                }
            }else{
                // 返回格式不对
                let error = NSError(domain:NSURLErrorDomain , code: NSURLErrorCannotParseResponse, userInfo: [NSLocalizedDescriptionKey:"数据解析错误"])
                HFSwiftService.handleReqError(error: (error as NSError), faliedBlock: failured)
            }
        case .failure(let error):
            // 服务器连接失败
            HFSwiftService.handleReqError(error: (error as NSError), faliedBlock: failured)
        }
    }
    
    
    
    /** 处理请求失败数据*/
    static func handleReqError(error: NSError, faliedBlock: ResFail){
        #if DEBUG
        print(error)
        #endif
        let code = error.code;
        var message = ""
        if ( code == -1009 ) {
            message = "无网络连接";
        }else if ( code == -1001 ){
            message = "服务器请求超时";
        }else if ( code == -1005 ){
            message = "网络连接丢失(服务器忙)";
        }else if ( code == -1004 ){
            message = "服务器没有启动";
        }else if ( code == 404 || code == 3) {
            message = "404访问地址错误";
        }else if (code == 700) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TokenTimeOutNotifi"), object: nil)
        }else{
            message = error.localizedDescription
        }
        if message == "" {
            message = "请求失败"
        }
        AlertTool.showCenter(withText: message)
        faliedBlock(error)
    }
    
    /// 图片上传
    @objc static func uploadImages(images: [UIImage], urlString: String, para: [String: AnyObject], isShowHUD: Bool, uploadProgress: @escaping ResProgress , successed: @escaping ResComplete, failured: @escaping ResFail) {
        
        if isShowHUD {
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
            }
        }
        
        let httpUrl = HFSwiftServiceFactory().hostName + urlString
        Alamofire.upload(multipartFormData: { (mutilPartData) in
            
            for image in images {
                let imgData = image.jpegData(compressionQuality: 0.0001)
                mutilPartData.append(imgData!, withName: "file", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpg/png/jpeg")
            }
            
            for (key, value) in para {
                mutilPartData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, to: httpUrl) { (encodingResult) in
            
            if isShowHUD {
                let keyViewController = UIApplication.shared.keyWindow?.rootViewController
                if (keyViewController != nil) {
                    MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                }
            }
            
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    HFSwiftService.checkRequestResult(successed: successed, failured: failured, response: response)
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    uploadProgress(progress.fractionCompleted)
                }
                break
            case .failure(let encodingError):
                HFSwiftService.handleReqError(error: (encodingError as NSError), faliedBlock: failured)
                break
            }
        }
    }
}
