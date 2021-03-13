//
//  HFFont.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

extension UIFont {
    
    /// 快捷创建一个**Medium System Font**，因为UI使用此字体频率非常高
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont对象
    public class func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight:UIFont.Weight.medium)
    }
    
    /// 快捷创建一个**Semibold System Font**，因为UI使用此字体频率非常高
    /// - Parameter fontSize: 字体大小
    /// - Returns: UIFont对象
    public class func semiboldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight:UIFont.Weight.semibold)
    }
    
}

/// 快捷创建一个**Medium System Font**，因为UI使用此字体频率非常高
/// - Parameter fontSize: fontSize: 字体大小
/// - Returns: UIFont对象
public func MediumFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.mediumFont(ofSize: fontSize)
}

/// 快捷创建一个**Semibold System Font**，因为UI使用此字体频率非常高
/// - Parameter fontSize: 字体大小
/// - Returns: UIFont对象
public func SemiboldFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.semiboldFont(ofSize: fontSize)
}

/// 快捷创建一个**System Font**，因为UI使用此字体频率非常高
/// - Parameter fontSize: 字体大小
/// - Returns: UIFont对象
public func SystemFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize)
}

extension UIFont {

    /// 用于价格类文字需要突出信息  24号
    public class func fontPriceHighlight() -> UIFont {
        return UIFont.systemFont(ofSize: 24, weight:UIFont.Weight.semibold)
    }
     
    /// 弹出框标题 18号
    public class func fontAlertTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 18, weight:UIFont.Weight.semibold)
    }
    
    /// 模块标题 17号
    public class func fontModuleTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight:UIFont.Weight.semibold)
    }
    
    /// 用于课程等标题文字信息 15号
    public class func fontListTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 15, weight:UIFont.Weight.regular)
    }
    
    /// 用于页面次级内容文字 13号
    public class func fontListContent() -> UIFont {
        return UIFont.systemFont(ofSize: 13, weight:UIFont.Weight.regular)
    }
    
    /// 用于页面辅助信息，时间显示 12号
    public class func fontAuxiMsg() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight:UIFont.Weight.regular)
    }
    
    /// 用于页面辅助角标类层级较弱文字 11号
    public class func fontAuxiMsgWeak() -> UIFont {
        return UIFont.systemFont(ofSize: 11, weight:UIFont.Weight.regular)
    }

}


