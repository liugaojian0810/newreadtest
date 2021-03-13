//
//  TabBarController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

@objc(TabBarController)

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        setTabbarItemUI()
        
        self.tabBar.tintColor = .colorWithHexString("04BFF7")
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = .colorWithHexString("C0C0C0")
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func setTabbarItemUI() {
        for (index, vc) in self.viewControllers!.enumerated() {
            if index == 0 {
                let item = UITabBarItem()
                let image = UIImage(named: "home_tabbar_homepage_unsele")?.withRenderingMode(.alwaysOriginal)
                item.image = image
                let selImage = UIImage(named: "home_tabbar_homepage_sele")?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = selImage
                item.title = "首页"
                vc.tabBarItem = item
            }else if index == 1{
                let item = UITabBarItem()
                let image = UIImage(named: "home_tabbar_member_zone_unsele")?.withRenderingMode(.alwaysOriginal)
                item.image = image
                let selImage = UIImage(named: "home_tabbar_member_zone_sele")?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = selImage
                item.title = "会员专区"
                vc.tabBarItem = item
            }else{
                let item = UITabBarItem()
                let image = UIImage(named: "home_tabbar_mine_unsele")?.withRenderingMode(.alwaysOriginal)
                item.image = image
                let selImage = UIImage(named: "home_tabbar_mine_sele")?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = selImage
                item.title = "我的"
                vc.tabBarItem = item
            }
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func addObservers() -> Void {
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotoLoginout), name: NSNotification.Name(rawValue: "LoginOutTag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(presentLoginVCt), name: NSNotification.Name(rawValue: "HFUserLogoutNotification"), object: nil)
    }
    
    @objc func gotoLoginout() -> Void {
        
        switchLoginState(true)
    }
    
    @objc func presentLoginVCt() -> Void {
        
        switchLoginState(false)
    }
    
    /// 切换到未登录
    /// @param timeOut 登录超时的原因
    func switchLoginState(_ isTimeOut: Bool) -> Void {
        let userDefaluts = UserDefaults.standard
        userDefaluts.set(object: UIDevice.jk_version(), forKey: "version")
        if isTimeOut {
            userDefaluts.setValue(false, forKey: "LoginOutTag")
        }else{
            userDefaluts.setValue(true, forKey: "LoginOutTag")
        }
        userDefaluts.synchronize()
        let baseNv = HFNewBaseNavigationController(rootViewController: HFNewLoginViewController())
        baseNv.modalPresentationStyle = .overFullScreen
        UIApplication.shared.keyWindow?.rootViewController = baseNv
    }
    
    
}
