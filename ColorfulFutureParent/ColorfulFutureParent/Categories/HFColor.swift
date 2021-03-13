//
//  HFColor.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

extension UIColor{
    
    //十六进制颜色值转换
    class func colorWithHex(_rgbValue:Int,_alpha:CGFloat = 1.0)-> UIColor {
        return UIColor(red: ((CGFloat)((_rgbValue & 0xFF0000) >> 16)) / 255.0,green: ((CGFloat)((_rgbValue & 0xFF00) >> 8)) / 255.0,blue: ((CGFloat)(_rgbValue & 0xFF)) / 255.0,alpha: _alpha)
    }
    
    /// 快速构建rgb颜色
    ///
    /// - Parameters:
    ///   - r: r
    ///   - g: g
    ///   - b: b
    /// - Returns: 返回rgb颜色对象，alpha默认1
    class func colorWithRGB(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    /// 生成随机颜色
    ///
    /// - Returns: 返回随机色
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithRGB(r, g: g, b: b)
    }
    
    
    /// 16进制转UIColor
    ///
    /// - Parameter hex: 16进制
    /// - Returns: UIColor
    class func colorWithHexString(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    /// 返回16进制颜色
    class func colorWithHexString(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}



// MARK: - Initializers
extension UIColor {
    
    /// 快捷构造器-RGBA色值，RGB取值范围是[0...255], alpha取值范围是[0...1]
    /// - Author: HouWan
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: alpha, default: 1.0
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue:b/255.0, alpha:a)
    }
    
    /// Same as above!
    convenience public init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue:b/255.0, alpha:a)
    }
    
    /// 使用十六进制颜色码生成`UIColor`对象, eg:`UIColor(0xFF2D3A)`
    /// - Author: HouWan
    /// - Parameters:
    ///   - hexValue: 十六进制数值
    ///   - alpha: alpha, default: 1.0, alpha取值范围是[0...1]
    convenience public init(_ hexValue: Int, alpha: Float = 1.0) {
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(alpha))
    }
    
    /// 使用十六进制颜色码生成`UIColor`对象, eg:`UIColor.hexColor(0xFF2D3A)`
    /// - Author: HouWan
    /// - Parameters:
    ///   - hexValue: 十六进制数值
    ///   - alpha: alpha, default: 1.0, alpha取值范围是[0...1]
    /// - Returns: 十六进制颜色
    class func hexColor(_ hexValue: Int, alpha: Float = 1.0) -> UIColor {
        return UIColor(hexValue, alpha: alpha)
    }
    
}

extension UIColor {
    
    /// 返回一个随机得出来的RGB颜色, 透明度为1.0
    class var random: UIColor {
        let red = CGFloat(Int.random(in: 0...255))
        let green = CGFloat(Int.random(in: 0...255))
        let blue = CGFloat(Int.random(in: 0...255))
        return UIColor.init( red, green, blue)
    }
    
    /// APP主色，大面积使用，用于主要突出的文字、按钮、和颜色块
    class func colorMain() -> UIColor {
        return .colorWithHexString("#04BFF7")
    }
    
    /// 主色调（禁用状态）
    class func colorMainDisable() -> UIColor {
        return .colorWithHexString("#82DFFB")
    }
    
    /// 背景
    class func colorBg() -> UIColor {
        return .colorWithHexString("#F6F6F6")
    }
    
    /// 分割线
    class func colorSeperLine() -> UIColor {
        return .colorWithHexString("#EDEDED")
    }
    
    /// 商城价格，用于辅助文字、按钮、和颜色块强调性内容
    class func colorPriceStrong() -> UIColor {
        return .colorWithHexString("#FF4D00")
    }
    
    /// 审核状态，审核中
    class func colorAuditing() -> UIColor {
        return .colorWithHexString("#FFC83B")
    }
    
    /// 审核状态，成功
    class func colorAuditSuccess() -> UIColor {
        return .colorWithHexString("#00D1A9")
    }
    
    /// 审核状态，失败
    class func colorAuditFail() -> UIColor {
        return .colorWithHexString("#FC5655")
    }
    
    /// 协议色值
    class func colorAgreement() -> UIColor {
        return .colorWithHexString("#369CF0")
    }
    
    /// 日历背景色块
    class func colorCaladerBg() -> UIColor {
        return .colorWithHexString("#FFF7EA")
    }
    
    /// 秒杀互动
    class func colorSecondsKill() -> UIColor {
        return .colorWithHexString("#E84D2F")
    }
    
    /// 拼团活动
    class func colorSpellGroup() -> UIColor {
        return .colorWithHexString("#E82F91")
    }
    
    /// 满赠活动
    class func colorGiveFull() -> UIColor {
        return .colorWithHexString("#E82FE7")
    }
    
    
    /// 文字颜色，一级标题
    class func colorPrimaryTitle() -> UIColor {
        return .colorWithHexString("#333333")
    }
    
    /// 文字颜色，次级标题
    class func colorSecondarTitle() -> UIColor {
        return .colorWithHexString("#666666")
    }
    
    /// 市场价或者正文内容
    class func colorBodyContent() -> UIColor {
        return .colorWithHexString("#999999")
    }
    
    /// 置灰、进入提示
    class func colorSetGrey() -> UIColor {
        return .colorWithHexString("#C0C0C0")
    }
    
}


