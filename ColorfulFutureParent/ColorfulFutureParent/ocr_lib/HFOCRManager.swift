//
//  HFOCRManager.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/12/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

enum OCRError: Error {
    case OCRError (String)
}


final class HFOCRManager: NSObject {
    
    var captureCardVC: UIViewController?
    
    private override init() {
        super.init()
        if let licenseFile = Bundle.main.path(forResource: "aip", ofType: "license") {
            if let licenseFileData = NSData.init(contentsOfFile: licenseFile) {
                AipOcrService.shard()?.auth(withLicenseFileData: licenseFileData as Data)
            }
        }
    }
    
    static let shared = HFOCRManager.init()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 身份证ocr识别 【正面】
    /// - Parameters:
    ///   - currentVC: 弹出的拍照ViewController的父ViewController
    ///   - successClosure: 成功回调 【身份证数据， 身份证照片】
    ///   - failClosure:
    /// - Returns:
    func hf_localIdcardOCROnlineFront(currentVC: UIViewController, _ successClosure: @escaping (HFIDCardInfoDetial?, UIImage?)->(),  _ failClosure: @escaping (Error?)->()) {
        // 外部需要img 数据模型
        
        if let vc = AipCaptureCardVC.viewController(with: .idCardFont, andImageHandler: { (img) in
                    AipOcrService.shard()?.detectIdCardFront(from: img, withOptions: [:], successHandler: { (response) in
                                                            
                                let model = Mapper<HFIDCardInfoDetial>().map(JSONObject: response)
                                if let cardVC =  self.captureCardVC {
                                    Asyncs.async({
                                        
                                    }) {
                                        successClosure(model, img)
                                        cardVC.dismiss(animated: true, completion: nil)
                                    }
                                                        
                                                                                                    }
                                                        
                                                            
                                                        }, failHandler: { (error) in
                                                            failClosure(error)
                                                        })})
        {
            captureCardVC = vc
            currentVC.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    /// 身份证ocr识别 【背面】
    /// - Parameters:
    ///   - currentVC: 弹出的拍照ViewController的父ViewController
    ///   - successClosure: 成功回调 【身份证数据， 身份证照片】
    ///   - failClosure:
    /// - Returns:
    func hf_localIdcardOCROnlineBack(currentVC: UIViewController, _ successClosure: @escaping (HFIDCardInfoDetial?, UIImage?)->(),  _ failClosure: @escaping (Error?)->()) {
        
        guard let vc = AipCaptureCardVC.viewController(with: .idCardBack, andImageHandler: { (img) in
            AipOcrService.shard()?.detectIdCardBack(from: img, withOptions: [:], successHandler: { (response) in
                let model = Mapper<HFIDCardInfoDetial>().map(JSONObject: response)
                if let cardVC =  self.captureCardVC {
                    Asyncs.async {
                    } _: {
                        successClosure(model, img)
                        cardVC.dismiss(animated: true, completion: nil)
                    }
                }
            }, failHandler: { (error) in
                failClosure(error)
            })
        }) else {
            print("身份证拍照vc弹出失败")
            return
        }
        captureCardVC = vc
        currentVC.present(vc, animated: true, completion: nil)
    }
    
    func hf_businessLicenseOCR() {
        guard let vc = AipGeneralVC.viewController(handler: { (image) in
            AipOcrService.shard()?.detectBusinessLicense(from: image, withOptions: [:], successHandler: { (response) in
    
            }, failHandler: { (error) in
    
            })
        }) else {
            print("营业执照拍照vc弹出失败")
            return
        }
    }
    
}
