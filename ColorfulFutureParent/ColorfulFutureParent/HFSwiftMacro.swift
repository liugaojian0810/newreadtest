//
//  HFSwiftMacro.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/7/28.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation


/// 顶部的安全边距
var kSafeTop: CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets .top ?? 0
    } else {
        return 0
    }
}

/// 底部的安全边距
var kSafeBottom: CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets .bottom ?? 0
    } else {
        return 0
    }
}

/// App状态栏的高度
var kStatusBarHeight: CGFloat {
    return HFTools_Swift.isFullScreen ? 40.0 : 20
}

/// App导航栏高度，包含状态栏(20/44)
var kNavigatioHeight: CGFloat {
    return HFTools_Swift.isFullScreen ? 88.0 : 64.0
}

/// App`TabBar`的高度
var kTabBarHeight: CGFloat {
    return HFTools_Swift.isFullScreen ? 83.0 : 49.0
}

/// 屏幕高度
internal let ScreenHeight = UIScreen.main.bounds.height

/// 屏幕宽度
internal let ScreenWidth = UIScreen.main.bounds.width

public let S_SCREEN_WIDTH = UIScreen.main.bounds.size.width

public let S_SCREEN_SCALE = UIScreen.main.bounds.size.width / 375


public let S_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

public let S_SCREEN_SIZE = UIScreen.main.bounds.size

public let S_SCREEN_WINDOW = UIApplication.shared.keyWindow

public let S_NAV_HEIGHT = UIApplication.shared.statusBarFrame.size.height + 44

public typealias OptionClosure = () -> ()

public typealias OptionClosureInt = (_ index: Int) -> ()

public typealias OptionClosureString = (_ str: String) -> ()

public typealias OptionClosureBool = (_ res: Bool) -> ()

public typealias OptionClosureSuccess = (_ responseObject: [String: Any]) -> ()

public typealias OptionClosureFail = (_ error: Error) -> ()



