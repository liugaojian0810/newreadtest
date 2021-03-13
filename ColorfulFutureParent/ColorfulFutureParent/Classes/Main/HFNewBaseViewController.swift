//
//  HFNewBaseViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFNewBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    var backBtn: UIButton?
    
    var hiddenNavigation: Bool  = false {
        didSet{
            if hiddenNavigation == true {
                self.navigationController?.setNavigationBarHidden(true, animated: false)
            }else{
                self.navigationController?.setNavigationBarHidden(false, animated: false)
            }
        }
    }
    
    var captureReturn: Bool  = false {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .colorWithHexString("F9F9F9")
        createBackBtn()
        
        self.addSubViews()
        self.addMasonry()
        self.loadDataSource()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.rightBarButtonItem?.tintColor = .colorWithHexString("4b4b4b")
        self.navigationItem.leftBarButtonItem?.tintColor = .colorWithHexString("4b4b4b")
    }
    
    
    deinit {
        let className = self.jk_className()
        print(className as Any, "deinit 执行销毁方法")
    }
    
    func addSubViews() {
        
    }
    
    func addMasonry() {
        
    }
    
    func loadDataSource() {
        
    }
    
    /// 设置导航右侧按钮颜色
    func rightBtnColor(_ color: UIColor) -> Void {
        self.navigationItem.rightBarButtonItem?.tintColor = color
    }
    
    /// 设置导航左侧按钮颜色
    func  leftBtnColor(_ color: UIColor) -> Void {
        self.navigationItem.leftBarButtonItem?.tintColor = color
    }
    
    /// 左侧返回按钮
    func createBackBtn() -> Void {
        let vcs = self.navigationController?.viewControllers
        if vcs != nil {
            if vcs!.count > 1 {
                let backBtn  = UIButton(type: .custom)
                backBtn.frame = CGRect(x: 0, y: 0, width: 49, height: 32)
                backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
                backBtn.showsTouchWhenHighlighted = true
                backBtn.contentHorizontalAlignment = .left
                backBtn.setImage(UIImage(named: "navigation_back_arrow"), for: .normal)
                backBtn.setImage(UIImage(named: "navigation_back_arrow"), for: .highlighted)
                backBtn.addTarget(self, action: #selector(backBtnClieck(send:)), for: .touchUpInside)
                let barButnItem = UIBarButtonItem(customView: backBtn)
                self.navigationItem.leftBarButtonItems = [barButnItem]
                self.backBtn = backBtn
                self.backBtn?.isHidden = false
            }
        }else{
            self.backBtn?.isHidden = true
        }
    }

    /// 返回按钮点击 需要拦截点击事件的话可以复写此方法
    @objc func backBtnClieck(send: UIButton) -> Void {
        
        if self.hiddenNavigation == true{
            
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.popViewController(animated: true)
            
        }else{
            
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    /// 公共页面弹窗 包含2个操作按钮。 没有高亮按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 描述
    ///   - firBtnMsg: 第一个按钮的文本
    ///   - secondBtnMsg: 第二个按钮的文本
    ///   - firstClosure: 点击第一个按钮回调
    ///   - secondClosure: 点击第二个按钮回调
    /// - Returns: 无返回值
    func showNormalAlert(_ title: String, _ message: String, _ firBtnMsg: String, _ secondBtnMsg: String, _ firstClosure:@escaping ()->(), _ secondClosure:@escaping  ()->()) -> Void {
        let alert = SPAlertController.init(title: title, message: message, preferredStyle: .alert, animationType: .none)
        alert.messageFont = .systemFont(ofSize: 16)
        alert.messageColor = .colorWithHexString("666666")
        let action1 = SPAlertAction.init(title: firBtnMsg, style: .default) { (action) in
            firstClosure()
        }
        let action2 = SPAlertAction.init(title: secondBtnMsg, style: .default) { (action) in
            secondClosure()
        }
        action1.titleColor = .colorWithHexString("ACB1BC")
        action1.titleFont = .systemFont(ofSize: 18)
        action2.titleColor = .colorWithHexString("ACB1BC")
        action2.titleFont = .boldSystemFont(ofSize: 18)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: {})
    }


    /// 公共页面弹窗 包含2个操作按钮。 高亮按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 描述
    ///   - firBtnMsg: 第一个按钮的文本
    ///   - secondBtnMsg: 第二个按钮的文本
    ///   - firstClosure: 点击第一个按钮回调
    ///   - secondClosure: 点击第二个按钮回调
    /// - Returns: 无返回值
    func showCustomAlert(_ title: String, _ message: String, _ firBtnMsg: String, _ secondBtnMsg: String, _ firstClosure:@escaping ()->(), _ secondClosure:@escaping ()->()) -> Void {
        let alert = SPAlertController.init(title: title, message: message, preferredStyle: .alert, animationType: .none)
        alert.messageFont = .systemFont(ofSize: 16)
        alert.messageColor = .colorWithHexString("666666")
        let action1 = SPAlertAction.init(title: firBtnMsg, style: .default) { (action) in
            firstClosure()
        }
        let action2 = SPAlertAction.init(title: secondBtnMsg, style: .default) { (action) in
            secondClosure()
        }
        action1.titleColor = .colorWithHexString("ACB1BC")
        action1.titleFont = .systemFont(ofSize: 18)
        action2.titleColor = .colorWithHexString("FF9120")
        action2.titleFont = .boldSystemFont(ofSize: 18)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: {})
    }
    

    /// - 底部弹出
    func showCustomSheetAlert(_ title: String, _ message: String, _ firBtnMsg: String, _ secondBtnMsg: String, _ firstClosure:@escaping ()->(), _ secondClosure:@escaping ()->()) -> Void {
        let alert = SPAlertController.init(title: title, message: message, preferredStyle: .actionSheet, animationType: .none)
        alert.messageFont = .systemFont(ofSize: 16)
        alert.messageColor = .colorWithHexString("666666")
        let action1 = SPAlertAction.init(title: firBtnMsg, style: .default) { (action) in
            firstClosure()
        }
        let action2 = SPAlertAction.init(title: secondBtnMsg, style: .default) { (action) in
            secondClosure()
        }
        action1.titleColor = .colorWithHexString("ACB1BC")
        action1.titleFont = .systemFont(ofSize: 18)
        action2.titleColor = .colorWithHexString("0BB987")
        action2.titleFont = .boldSystemFont(ofSize: 18)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: {})
    }

    
    /// - 底部弹出
    func showAlertSheetMessage(_ message: String, _ btnMsg: String, _ closure:@escaping ()->()) -> Void {
        let alert = SPAlertController.init(title: "", message: message, preferredStyle: .actionSheet, animationType: .none)
        alert.messageFont = .systemFont(ofSize: 16)
        alert.messageColor = .colorWithHexString("666666")
        let action1 = SPAlertAction.init(title: btnMsg, style: .default) { (action) in
            closure()
        }
        action1.titleColor = .colorWithHexString("FF9120")
        action1.titleFont = .systemFont(ofSize: 15)
        alert.addAction(action1)
        self.present(alert, animated: true, completion: {})
    }
    
    /// - 底部弹出
    func showAlertCenterMessage(_ message: String, _ btnMsg: String, _ closure:@escaping ()->()) -> Void {
        let alert = SPAlertController.init(title: "", message: message, preferredStyle: .alert, animationType: .none)
        alert.messageFont = .systemFont(ofSize: 16)
        alert.messageColor = .colorWithHexString("666666")
        let action1 = SPAlertAction.init(title: btnMsg, style: .default) { (action) in
            closure()
        }
        action1.titleColor = .colorWithHexString("FF9120")
        action1.titleFont = .systemFont(ofSize: 15)
        alert.addAction(action1)
        self.present(alert, animated: true, completion: {})
    }
    
    
    
}



extension HFNewBaseViewController {

     func getSectionHead(with height: CGFloat, _ bgColor: UIColor) -> UIView {
         
        let head = UIView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: height))
        head.backgroundColor = bgColor
        return head
    }

     func getSectionFoot(with height: CGFloat, _ bgColor: UIColor) -> UIView {
         
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: height))
        footer.backgroundColor = bgColor
        return footer
    }
    
}

