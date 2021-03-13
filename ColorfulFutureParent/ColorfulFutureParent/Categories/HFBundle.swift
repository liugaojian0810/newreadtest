//
//  HFBundle.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/9/23.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation


extension Bundle {
    
    /**
     应用版本
     */
    static func appVersion() -> String {
        
        let version = self.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
        return version
        
    }
    
    /**
     应用编译版本
     */
    static func appBuildVersion() -> String {
        
        let version = self.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        
        return version
        
    }
    
}
