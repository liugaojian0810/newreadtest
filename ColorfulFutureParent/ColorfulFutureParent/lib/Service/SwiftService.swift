//
//  SwiftService.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import MBProgressHUD

//成功
typealias NetSuccessBlock<T: Mappable> = (_ value: HFSwiftBaseModel<T>, JSON) -> Void

//失败
typealias NetFailedBlock = (AFSErrorInfo) -> Void

//进度
typealias AFSProgressBlock = (Double) -> Void


class HFRequestManager: NSObject {
    private var sessionManager: SessionManager?
    static let share = HFRequestManager()
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustPolicyManager: nil)
//        let delegate =
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HFRequestManager {
 func requestByTargetType<T: Mappable>(targetType: YAPITargetType, model: T.Type, success: @escaping NetSuccessBlock<T>, failed: @escaping NetFailedBlock) -> Void {
        let url = targetType.baseUrl + targetType.path
        switch targetType.method {
        case .get:
            self.GET(url: url, param: targetType.pararms, headers: targetType.headers, isShowHUD: targetType.isShowHUD, success: success, failed: failed)
            break
        case .post:
            self.POST(url: url, param: targetType.pararms, headers: targetType.headers, isShowHUD: targetType.isShowHUD, success: success, failed: failed)
            break
        case .bodyPost:
            self.POST(url: url, paramBody: targetType.pararms, headers: targetType.headers, isShowHUD: targetType.isShowHUD, success: success, failed: failed)
            break
        default:
            break
        }
    }
    
    func uploadByTargetType<T: Mappable>(targetType: YAPITargetType, model: T.Type,progess:@escaping AFSProgressBlock , success: @escaping NetSuccessBlock<T>, failed: @escaping NetFailedBlock) -> Void {
        let url = targetType.baseUrl + targetType.path
        switch targetType.method {
        case .uploadImage:
            self.postImage(image: targetType.pararms["image"] as! UIImage, url: url, param: nil, headers: targetType.headers, isShowHUD: targetType.isShowHUD, progressBlock: progess, successBlock: success, faliedBlock: failed)
            break
        case .uploadMp4:
            self.postVideo(video: targetType.pararms["video"] as! Data, url: url, param: nil, headers: targetType.headers, isShow: targetType.isShowHUD, progressBlock: progess, successBlock: success, faliedBlock: failed)
            break
        default:
            break
        }
    }
}



extension HFRequestManager {
    
    fileprivate func GET<T: Mappable>(url: String, param: Parameters?, headers: HTTPHeaders, isShowHUD: Bool, success: @escaping NetSuccessBlock<T>, failed: @escaping NetFailedBlock) -> Void {
//        let encodStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if isShowHUD {
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
            }
        }
        self.sessionManager?.request(url, method: .get, parameters: param, encoding: URLEncoding.httpBody , headers: headers).validate().responseJSON(completionHandler: { (response) in
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                //            MBProgressHUD.
            }
            self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
        })
    }
    
    fileprivate func POST<T: Mappable>(url: String, param: Parameters?, headers: HTTPHeaders, isShowHUD: Bool, success: @escaping NetSuccessBlock<T>, failed: @escaping NetFailedBlock) -> Void {
        //let encodStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
        
//        let headers: HTTPHeaders = ["Content-Type":"application/json;charset=utf-8"];
        // http
        if isShowHUD {
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
            }
        }
        self.sessionManager!.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.httpBody, headers: headers)
            .validate()
            .responseJSON(completionHandler: { (response) in
                let keyViewController = UIApplication.shared.keyWindow?.rootViewController
                if (keyViewController != nil) {
                    MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                    //            MBProgressHUD.
                }
                self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
            })
    }
//    内容放在body里面
    func POST<T: Mappable>(url: String, paramBody: Dictionary<String, Any>?, headers: HTTPHeaders, isShowHUD: Bool, success: @escaping NetSuccessBlock<T>, failed: @escaping NetFailedBlock) -> Void {
        //let encodStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed);
        if isShowHUD {
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
            }
        }
        let json = JSON.init(paramBody as Any)
        let urlReqest = URL.init(string: url)
        var request = URLRequest.init(url: urlReqest!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json.description.data(using: .utf8)
        // http
        self.sessionManager!.request(request)
            .validate()
            .responseJSON(completionHandler: { (response) in
                self.handleResponse(response: response, successBlock: success, faliedBlock: failed)
                let keyViewController = UIApplication.shared.keyWindow?.rootViewController
                if (keyViewController != nil) {
                    MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                    //            MBProgressHUD.
                }
            })
    }
    
//    上传图片
    func postImage<T: Mappable>(image: UIImage, url: String, param: Parameters?, headers: HTTPHeaders, isShowHUD: Bool, progressBlock: @escaping AFSProgressBlock, successBlock:@escaping NetSuccessBlock<T>,faliedBlock:@escaping NetFailedBlock) {
        if isShowHUD {
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
            }
        }
        
        let imageData = image.jpegData(compressionQuality: 0.0001)
        let headers = ["content-type":"multipart/form-data"];
        self.sessionManager?.upload(multipartFormData: { (multipartFormData) in
            //采用post表单上传
            // 参数解释
            let dataStr = DateFormatter.init()
            dataStr.dateFormat = "yyyyMMddHHmmss"
            let fileName = "\(dataStr.string(from: Date.init())).png"
            multipartFormData.append(imageData!, withName: "file", fileName: fileName, mimeType: "image/jpg/png/jpeg")
        }, to: url, headers: headers, encodingCompletion: { (encodingResult) in
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                //            MBProgressHUD.
            }
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    self.handleResponse(response: response, successBlock: successBlock, faliedBlock: faliedBlock)
//                    print("json:\(result)")
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    progressBlock(progress.fractionCompleted);
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
                break
            case .failure(let encodingError):
                self.handleRequestError(error: encodingError as NSError, faliedBlock: faliedBlock);
                break
            }
        })
    }
    
    func postVideo<T: Mappable>(video: Data, url: String, param: Parameters?,headers: HTTPHeaders,isShow: Bool, progressBlock: @escaping AFSProgressBlock, successBlock:@escaping NetSuccessBlock<T>,faliedBlock:@escaping NetFailedBlock) {
//        let headers = ["content-type":"multipart/form-data"];
        if isShow {
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.showAdded(to: keyViewController!.view, animated: true)
            }
        }
        self.sessionManager?.upload(multipartFormData: { (multipartFormData) in
            //采用post表单上传
            // 参数解释
            let dataStr = DateFormatter.init()
            dataStr.dateFormat = "yyyyMMddHHmmss"
            let fileName = "\(dataStr.string(from: Date.init())).mp4"
            multipartFormData.append(video, withName: "file", fileName: fileName, mimeType: "video/mp4");
        }, to: url, headers: headers, encodingCompletion: { (encodingResult) in
            
            let keyViewController = UIApplication.shared.keyWindow?.rootViewController
            if (keyViewController != nil) {
                MBProgressHUD.hide(for: keyViewController!.view, animated: true)
                //            MBProgressHUD.
            }
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    self.handleResponse(response: response, successBlock: successBlock, faliedBlock: faliedBlock)
                    //                    print("json:\(result)")
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    progressBlock(progress.fractionCompleted);
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
                break
            case .failure(let encodingError):
                self.handleRequestError(error: encodingError as NSError, faliedBlock: faliedBlock);
                break
            }
        })
    }
}

extension HFRequestManager {
    /** 处理服务器响应数据*/
    private func handleResponse<T: Mappable>(response:DataResponse<Any>, successBlock: NetSuccessBlock<T> ,faliedBlock: NetFailedBlock){
        if let error = response.result.error {
            // 服务器未返回数据
            self.handleRequestError(error: error as NSError , faliedBlock: faliedBlock)
            
        }else if let value = response.result.value {
            // 服务器又返回数h数据
            if (value as? NSDictionary) == nil {
                // 返回格式不对
                self.handleRequestSuccessWithFaliedBlcok(faliedBlock: faliedBlock)
            }else{
                self.handleRequestSuccess(value: value, successBlock: successBlock, faliedBlock: faliedBlock);
            }
        }
    }
    
    /** 处理请求失败数据*/
    private func handleRequestError(error: NSError, faliedBlock: NetFailedBlock){
        var errorInfo = AFSErrorInfo();
        errorInfo.code = error.code;
        errorInfo.error = error;
        if ( errorInfo.code == -1009 ) {
            errorInfo.message = "无网络连接";
        }else if ( errorInfo.code == -1001 ){
            errorInfo.message = "请求超时";
        }else if ( errorInfo.code == -1005 ){
            errorInfo.message = "网络连接丢失(服务器忙)";
        }else if ( errorInfo.code == -1004 ){
            errorInfo.message = "服务器没有启动";
        }else if ( errorInfo.code == 404 || errorInfo.code == 3) {
        }
        faliedBlock(errorInfo)
    }
    
     /** 处理请求成功数据*/
    private func handleRequestSuccess<T: Mappable>(value:Any, successBlock: NetSuccessBlock<T>,faliedBlock: NetFailedBlock){
        let json: JSON = JSON(value);
        let baseModel = HFSwiftBaseModel<T>.init(JSONString: json.description)
        if baseModel?.errorCode == 200 {
            successBlock(baseModel!, json)
        } else{ // 获取服务器返回失败原因
            var errorInfo = AFSErrorInfo();
            errorInfo.code = baseModel!.errorCode;
            errorInfo.message = (baseModel?.errorMessage)!;
            faliedBlock(errorInfo);
        }
    }
    
    /** 服务器返回数据解析出错*/
    private func handleRequestSuccessWithFaliedBlcok(faliedBlock:NetFailedBlock){
        var errorInfo = AFSErrorInfo();
        errorInfo.code = -1;
        errorInfo.message = "数据解析出错";
    }
}

/** 访问出错具体原因 */
struct AFSErrorInfo {
    var code = 0
    var message = ""
    var error = NSError()
}

public protocol YAPITargetType {
    
    var method: RequestMed {get}
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var pararms: Dictionary<String, Any>{get}
    
    var headers: HTTPHeaders {get}
    
    var isShowHUD: Bool {get}
}

public enum RequestMed: Int {
    case post = 0
    case get = 1
    case bodyPost = 2
    case uploadImage = 3
    case uploadMp4 = 4
}
