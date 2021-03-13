//
//  HFPubRequest.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/2.
//  Copyright © 2020 huifan. All rights reserved.
//
// 公共接口网络请求

import Foundation
import SwiftyJSON
import ObjectMapper

class HFPubRequest: NSObject {
    
    /// 图片上传一
    @objc class func uploadImage(image: UIImage, uploadProgress: @escaping ResProgress , successed: @escaping (_ resModel: [HFImageUploadResultModel]) -> (), failured: @escaping ResFail) {
        uploadImage(images: [image], para: [:], isShowHUD: false, uploadProgress: uploadProgress, successed: successed, failured: failured)
    }
    /// 图片上传二
    @objc class func uploadImage(images: [UIImage], uploadProgress: @escaping ResProgress , successed: @escaping (_ resModel: [HFImageUploadResultModel]) -> (), failured: @escaping ResFail) {
        uploadImage(images: images, para: [:], isShowHUD: false, uploadProgress: uploadProgress, successed: successed, failured: failured)
    }
    /// 图片上传三
    @objc class  func uploadImage(images: [UIImage], isShowHUD: Bool, uploadProgress: @escaping ResProgress , successed: @escaping (_ resModel: [HFImageUploadResultModel]) -> (), failured: @escaping ResFail) {
        uploadImage(images: images, para: [:], isShowHUD: isShowHUD, uploadProgress: uploadProgress, successed: successed, failured: failured)
    }
    /// 图片上传四
    @objc class  func uploadImage(images: [UIImage], para: [String: AnyObject], isShowHUD: Bool, uploadProgress: @escaping ResProgress , successed: @escaping (_ resModel: [HFImageUploadResultModel]) -> (), failured: @escaping ResFail) {
        
        HFSwiftService.uploadImages(images: images, urlString: HFPublicAPI.UploadImageAPI, para: para, isShowHUD: isShowHUD, uploadProgress: uploadProgress, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseArrayBaseModel<HFImageUploadResultModel>>().map(JSON: dic as! [String : Any] )
            
            successed(responseBaseModel!.model ?? [])
            
        }, failured: failured)
    }
}
