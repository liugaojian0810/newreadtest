//
//  HFFaceManager.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/12/31.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

final class HFFaceManager: NSObject {
    
    @objc static let shared = HFFaceManager.init()
    
    private override init() {
        super.init()
        let manager = FaceSDKManager.sharedInstance()
        if let mgr = manager {
            mgr.setLicenseID(FACE_LICENSE_ID, andLocalLicenceFile: "\(FACE_LICENSE_NAME).\(FACE_LICENSE_SUFFIX)", andRemoteAuthorize: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func startFaceDetect(currentVC: UIViewController, _ successClosure: @escaping (UIImage?)->(),  _ failClosure: @escaping (Error?)->()) {
        if !FaceSDKManager.sharedInstance()!.canWork() {
            print("人脸识别不可用")
            return
        }
        initSDK()
        let dvc = BDFaceDetectionViewController()
        dvc.complateBlock = { (image) in
            if let bImage = image {
                successClosure(bImage)
            }
        }
        let navi = UINavigationController(rootViewController: dvc)
        navi.isNavigationBarHidden = true
        navi.modalPresentationStyle = .fullScreen
        currentVC.present(navi, animated: true, completion: nil)
    }
    
    func initSDK() {
        FaceSDKManager.sharedInstance()?.setMinFaceSize(200)
        FaceSDKManager.sharedInstance()?.setCropFaceSizeWidth(400)
        FaceSDKManager.sharedInstance()?.setCropFaceSizeHeight(640)
        FaceSDKManager.sharedInstance()?.setOccluThreshold(0.5)
//        FaceSDKManager.sharedInstance()?.setIllumThreshold(40)
        FaceSDKManager.sharedInstance()?.setBlurThreshold(0.3)
        FaceSDKManager.sharedInstance()?.setEulurAngleThrPitch(10, yaw: 10, roll: 10)
        FaceSDKManager.sharedInstance()?.setNotFaceThreshold(0.6)
        FaceSDKManager.sharedInstance()?.setCropEnlargeRatio(3.0)
        FaceSDKManager.sharedInstance()?.setMaxCropImageNum(6)
//        FaceSDKManager.sharedInstance()?.setConditionTimeout(15)
        FaceSDKManager.sharedInstance()?.setIsCheckMouthMask(true)
        FaceSDKManager.sharedInstance()?.setMouthMaskThreshold(0.8)
        FaceSDKManager.sharedInstance()?.setImageWithScale(0.8)
        FaceSDKManager.sharedInstance()?.setImageEncrypteWithType(0)
        FaceSDKManager.sharedInstance()?.initCollect()
        
    }
    
    deinit {
        FaceSDKManager.sharedInstance()?.uninitCollect()
    }
    
}
