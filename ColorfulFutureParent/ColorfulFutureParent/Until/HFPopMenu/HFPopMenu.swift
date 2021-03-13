//
//  HFPopMenu.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/12.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

let PopMenuShared = HFPopMenu.shared

class HFPopMenu: NSObject {
    static let shared = HFPopMenu()
    private var menuView: HFPopMenuView?

    public func showPopMenuSelecteWithFrameWidth(width: CGFloat, height: CGFloat, point: CGPoint, dataArr: [HFPopViewModel], action: @escaping ((Int) -> Void)) {
        weak var weakSelf = self
        /// 每次重置保证显示效果
        if self.menuView != nil {
            weakSelf?.hideMenu()
        }
        let window = UIApplication.shared.windows.first
        self.menuView = HFPopMenuView(width: width, height: height, point: point, dataArr: dataArr, action: { (index) in
            ///点击回调
            action(index)
            weakSelf?.hideMenu()
        })
        menuView?.touchBlock = {
            weakSelf?.hideMenu()
        }
        self.menuView?.backgroundColor = UIColor.black.withAlphaComponent(0)
        window?.addSubview(self.menuView!)
    }
    public func hideMenu() {
        self.menuView?.removeFromSuperview()
        self.menuView = nil
    }
}
