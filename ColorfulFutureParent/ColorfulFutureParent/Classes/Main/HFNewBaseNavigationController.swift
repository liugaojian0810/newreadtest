//
//  HFNewBaseNavigationController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFNewBaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    ///开始接收到手势的代理方法
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        ///判断是否是侧滑相关的手势
        if gestureRecognizer == self.interactivePopGestureRecognizer{
            
            ///如果当前展示的控制器是根控制器就不让其响应
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        return true
    }

    ///接收到多个手势的代理方法
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        ///判断是否是侧滑相关手势
        if gestureRecognizer == self.interactivePopGestureRecognizer && gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()){
            let pan = gestureRecognizer as! UIPanGestureRecognizer
            let point: CGPoint = pan.translation(in: self.view)
            ///如果是侧滑相关的手势，并且手势的方向是侧滑的方向就让多个手势共存
            if point.x > 0 {
                return true
            }
        }
        return false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
}
