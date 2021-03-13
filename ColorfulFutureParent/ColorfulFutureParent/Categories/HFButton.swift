//
//  HFButton.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/9/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation


extension UIButton {
    
    //枚举图片的位置
    enum ButtonImageEdgeInsetsStyle {
        case top    //上图下文字
        case left   //左图右文字
        case bottom   //下
        case right   //右
    }
    
    //渐变方向
    enum GrandientDirection {
        case horizontal    //横向
        case vertical   //纵向
        case left_top   //左上角

    }
    
    /// 按钮图片和文字的排版设置
    /// - Parameters:
    ///   - style: 图片位置 space:图片与文字的距离
    ///   - space: 无
    func imageEdgeInsetsStyle(style:ButtonImageEdgeInsetsStyle,space:CGFloat) {
        let imageWidth:CGFloat = (self.imageView?.frame.size.width)!
        let imageHeight:CGFloat = (self.imageView?.frame.size.height)!

        var labelWidth:CGFloat = 0
        var labelHeight:CGFloat = 0

        labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
        labelHeight = (self.titleLabel?.intrinsicContentSize.height)!

        var imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero

        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space/2.0, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWidth, bottom: 0, right: 0)
        default:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -labelWidth-space/2.0, bottom: 0, right: labelWidth+space/2.0)
            break
        }

        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    
    /// 按钮背景渐变颜色设置
    /// - Parameters:
    ///   - fromColor: 启示颜色
    ///   - toColor: 最后颜色
    ///   - direction: 无
    func bgColor(fromColor:UIColor, toColor:UIColor, direction:GrandientDirection) {

        self.isEnabled = true
        if(self.layer.sublayers == nil || self.layer.sublayers!.count < 2) {
            let gradientColors: [CGColor] = [fromColor.cgColor, toColor.cgColor]
            let gradientLayer: CAGradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            if(direction == .horizontal) {
                gradientLayer.startPoint = CGPoint(x:0, y:0)
                gradientLayer.endPoint = CGPoint(x:1, y:0)
            }else if(direction == .vertical) {
                gradientLayer.startPoint = CGPoint(x:0, y:0)
                gradientLayer.endPoint = CGPoint(x:0, y:1)
            }else {
                gradientLayer.startPoint = CGPoint(x:0, y:0)
                gradientLayer.endPoint = CGPoint(x:1, y:1)
            }
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.layer.cornerRadius = 4
            self.clipsToBounds = true
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
}





