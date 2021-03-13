//
//  HFTools_Swift.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/25.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit


class HFTools_Swift: NSObject {
    
    /// 获取屏幕状态
    static var isFullScreen: Bool {
        guard#available(iOS 11.0, *) else {
            return false
        }
        let isX = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
        return isX
    }
    
    
    /// 获取宝宝id
    static var babyId: String{
        HFUserManager.shared().getUserInfo().babyInfo.babyID
    }
    
}
