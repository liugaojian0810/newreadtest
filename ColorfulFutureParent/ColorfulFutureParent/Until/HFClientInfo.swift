//
//  HFClientInfo.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/14.
//  Copyright © 2020 huifan. All rights reserved.
//
// 客户端信息类

// 客户端信息类

import Foundation

/// 客户端类型
enum HFClientType: String {
    case ClientTypeKindergarten = "client_type_kg_app" // 园长端
    case ClientTypeTeacher = "client_type_teacher" // 教师端
    case ClientTypeParent = "client_type_parent" // 家长端
}

@objc class HFClientInfo: NSObject {
    /// 当前客户端类型
    static public let currentClientType: HFClientType = .ClientTypeParent
    
    @objc static func getCurrentClientType() -> String {
        return HFClientInfo.currentClientType.rawValue
    }
    
    /// 设备类型
    @objc static public let deviceType = "ios"
    
    /// 推送 获取推送设备唯一标识
    @objc static func getPushDeviceToken() -> String {
        let pushDeviceToken = UserDefaults.standard.string(forKey: "PushRegistrationID") ?? ""
        if pushDeviceToken == "" {
            return "0000000000000000000000000000000000000000000000000000000000000000"
        }else{
            return pushDeviceToken
        }
    }
    
    // 设备唯一编号
    @objc static public let deviceNo = DeviceUID.uid()
    
    // 设备名称
    @objc static public let deviceName = UIDevice.current.name
}
