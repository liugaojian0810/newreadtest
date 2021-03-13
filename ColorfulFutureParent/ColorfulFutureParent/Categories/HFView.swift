//
//  HFView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/20.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

// MARK: 圆角的位置
enum CornerPosition {
    
    case top_Left
    case top_Right
    case top_Left_Right
    case bottm_Left
    case bottm_Right
    case bottm_Left_Right
    case left
    case right
    case all
    case none
}


extension UIView {
    
    // MARK: 边框
    func setBorder(_ width: CGFloat, _ color: UIColor) {
        
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    // MARK: 画圆角
    func corner_radius(at position: CornerPosition, radius: CGFloat) {
        let corners: UIRectCorner
        switch position {
        case .top_Left:
            corners = [.topLeft]
        case .top_Right:
            corners = [.topRight]
        case .top_Left_Right:
            corners = [.topLeft, .topRight]
        case .bottm_Left:
            corners = [.bottomLeft]
        case .bottm_Right:
            corners = [.bottomRight]
        case .bottm_Left_Right:
            corners = [.bottomLeft, .bottomRight]
        case .left:
            corners = [.topLeft, .bottomLeft]
        case .right:
            corners = [.topRight, .bottomRight]
        case .none:
            corners = []
        default:
            corners = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        }
        self.setCorner(corners, withRadius: radius)
    }
    
    
    // MARK: 画圆角 UIBezierPath
    func corner_radius_bezier(at corners: UIRectCorner, cornerRadius: CGFloat) {
        self.layoutIfNeeded()
        let frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let shapelayer = CAShapeLayer()
        shapelayer.frame = frame
        shapelayer.path = path.cgPath
        self.layer.mask  = shapelayer
    }
    
    /// x origin of view.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// y origin of view.
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    /// Origin of view.
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    /// CenterX of view.
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    /// CenterY of view.
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    /// Bottom of view.
    var bottom: CGFloat {
        return frame.maxY
    }
    
    
}



extension UIView {
    
    
    //绘制虚线边框
    func drawsDottedBorder(_ spacing: CGFloat, borderColor color: UIColor, lineWidth width: CGFloat) {
        
        let shapeLayer = CAShapeLayer()
        let size = self.frame.size
        
        let shapeRect = CGRect(x: spacing, y: spacing, width: size.width - spacing * 2, height: size.height - spacing * 2)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        //
        shapeLayer.lineDashPattern = [3,4]
        let path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 8)
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
        
    }
    
    //绘制虚线边框
    func drawsDotted(_ spacing: CGFloat, borderColor color: UIColor, lineWidth width: CGFloat){
        
         let imgV: UIImageView = UIImageView(frame: CGRect(x: spacing, y: self.jk_height - width, width: self.jk_width - (spacing * 2), height: width))
         self.addSubview(imgV)
         UIGraphicsBeginImageContext(imgV.frame.size)
         
         let context = UIGraphicsGetCurrentContext()
         context?.setLineCap(CGLineCap.square)
         
         let lengths:[CGFloat] = [3,9,]
         context?.setStrokeColor(color.cgColor)
         context?.setLineWidth(width)
         context?.setLineDash(phase: 0, lengths: lengths)
         context?.move(to: CGPoint(x: spacing, y: 0))
         context?.addLine(to: CGPoint(x: self.width, y: 0))
         context?.strokePath()
         
         context?.setStrokeColor(color.cgColor)
         context?.setLineWidth(width)
         context?.setLineDash(phase: 0, lengths: lengths)
         context?.move(to: CGPoint(x: spacing, y: 0))
         context?.addLine(to: CGPoint(x: self.width, y: 0))
         context?.strokePath()
         imgV.image = UIGraphicsGetImageFromCurrentImageContext()
      //结束
         UIGraphicsEndImageContext()
     }
    
    //MARK:- 绘制虚线
    @discardableResult
    func drawDashLine(startPoint: CGPoint , endPoint: CGPoint,strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 10, lineSpacing: Int = 5) -> (CAShapeLayer){
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
}


// MARK: 截图
extension UIView {
    /// 截屏Image
    var captureImage: UIImage? {
        
        // 参数①：截屏区域  参数②：是否透明  参数③：清晰度
        UIGraphicsBeginImageContextWithOptions(frame.size, true, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
}


// MARK: 截长图、大图
extension UIScrollView {
    
    /// 截长屏Image
    var captureLongImage: UIImage? {
        
        var image: UIImage? = nil
        let savedContentOffset = contentOffset
        let savedFrame = frame
        
        contentOffset = .zero
        frame = CGRect(x: 0, y: 0,
                       width: contentSize.width,
                       height: contentSize.height)
        
        UIGraphicsBeginImageContext(frame.size)
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: frame.size.width,
                   height: frame.size.height),
            false,
            UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print("contentSize == \(contentSize)")
        contentOffset = savedContentOffset
        frame = savedFrame
        return image
        
    }
}

