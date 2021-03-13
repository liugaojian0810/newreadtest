//
//  HFVideoPlayEnumListView.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import SwifterSwift


/// 成长营播放右侧菜单列表View
class HFVideoPlayEnumListView: HFBaseView {
    
    /// 关闭与展开的回调
    typealias openOrCloseEnum = (_ isOpen : Bool) -> Void
    var callBack: openOrCloseEnum?
    
    /// 菜单项目点击事件回调
    typealias enumClick = (_ type : Int) -> Void
    var enumClicCallBack: enumClick?
    
    
    /// 初始化一个有三个菜单项的菜单列表
    lazy var menuList: [HFVideoPlayEnumItemView] = {
        var menuList = [HFVideoPlayEnumItemView]()
        for item in 0...2 {
            let tempView = HFVideoPlayEnumItemView()
            let menu = setMenus(menu: tempView, menuType: PlayEnumList(rawValue: item) ?? PlayEnumList.playback)
            menuList.append(menu)
        }
        return menuList
    }()
    
    /// 初始化一个有两个菜单项的菜单列表
    lazy var menuListShort: [HFVideoPlayEnumItemView] = {
        var menuList = [HFVideoPlayEnumItemView]()
        for item in 0...1 {
            let tempView = HFVideoPlayEnumItemView()
            let menu = setMenus(menu: tempView, menuType: PlayEnumList(rawValue: (item + 1)) ?? PlayEnumList.playback)
            menuList.append(menu)
        }
        return menuList
    }()
    
    
    /// 创建一个菜单View，并添加点击事件
    /// - Parameters:
    ///   - menu: 菜单View对象
    ///   - menuType: 菜单View的类型：枚举值，0-回放；1-课程表；2-分享
    /// - Returns: 创建好的菜单View
     private func setMenus(menu: HFVideoPlayEnumItemView, menuType: PlayEnumList) -> HFVideoPlayEnumItemView {

        // 设置单个菜单项目的类型：枚举值，0-回放；1-课程表；2-分享
        menu.playType = menuType
        // 创建一个点击手势
        let tap = UITapGestureRecognizer(target:self, action:#selector(tapClick(sender:)))
        
        // 设置菜单View可以点击
        menu.isUserInteractionEnabled=true
        
        // 给菜单View添加点击手势
        menu.addGestureRecognizer(tap)
        return menu
    }
    
    
    /// 点击事件
    /// - Parameter sender: 事件的手势对象
    @objc private func tapClick(sender: UITapGestureRecognizer){
        let enumTemp = (sender.view) as! HFVideoPlayEnumItemView
        if enumClicCallBack != nil {
            enumClicCallBack!(enumTemp.playType.rawValue)
        }
    }
    
    /// 打开或者关闭菜单View的按钮
    lazy var btnOpenAndClose: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "icon_Open_EnumList"), for: .normal)
        btn.setImage(UIImage.init(named: "icon_Close_EnumList"), for: .selected)
        btn.addTarget(self, action: #selector(btnOpenAndCloseClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    /// 打开或者关闭菜单的回调事件
    /// - Parameter block: 闭包回调的具体实现，打开OR关闭
    @objc func callBackBlock(block: @escaping openOrCloseEnum) {
           callBack = block
    }
    
    /// 菜单按钮的点击回调事件
    /// - Parameter block: 闭包回调的具体实现，点击的是哪一个菜单项
    @objc func enumClickCallBackBlock(block: @escaping enumClick) {
        enumClicCallBack = block
    }
    
    @objc private func btnOpenAndCloseClick(sender: UIButton) -> Void {
        sender.isSelected = !sender.isSelected;
        if callBack != nil {
            callBack!(sender.isSelected)
        }
    }
    
    
    /// 背景View
    lazy var bgView: UIImageView = {
        let bgView = UIImageView()
        bgView.image = UIImage.init(named: "img_fenxianglakai")
        return bgView
    }()
    
    /// 添加所有子View
    override func addMySubViews() {
        self.addSubview(bgView)
        self.addSubview(btnOpenAndClose)
    }
    
    /// 设置子视图的位置和大小
    override func addSnap() {
        self.bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.btnOpenAndClose.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview().offset(-5)
            make.width.equalTo(35)
            make.height.equalTo(60)
        }
    }
    
    
    /// 创建右侧菜单列表
    /// - Parameter isLive: 是否直播
    /// - Returns: NULL
    @objc func rightEnums(isLive: Bool) -> Void {
        var index = 0
        if isLive {
            bgView.image = UIImage.init(named: "img_fenxianglakai")
            for enumItem in menuList {
                createMenuView(menuView: enumItem, index: index)
                index += 1
            }
        } else {
            bgView.image = UIImage.init(named: "img_fenxianglakai_S")
            for enumItem in menuListShort {
                createMenuView(menuView: enumItem, index: index)
                index += 1
            }
        }
    }
    
    
    /// 右侧菜单项目的单个创建方法
    /// - Parameters:
    ///   - menuView: 菜单View对象
    ///   - index: 第几个View
    /// - Returns: NULL
    private func createMenuView(menuView: HFVideoPlayEnumItemView, index: Int) -> Void {
        self.addSubview(menuView)
        menuView.snp.makeConstraints { (make) in
            make.centerX.equalTo(64)
            make.top.equalTo(60 * index + 15 * (index + 1))
            make.width.equalTo(40)
            make.height.equalTo(60)
        }
    }
}
