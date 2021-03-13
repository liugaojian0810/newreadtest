//
//  HFCancelAccountResultController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/21.
//  Copyright © 2020 huifan. All rights reserved.
//  注销账号确认及结果显示

import UIKit

class HFCancelAccountResultController: HFNewBaseViewController {
    
    public var cancelState: CancelState = .undefined
    
    public var tipMessage: String?
    
    var myViewModel = HFSetupViewModel()
    var cancelViewModel = HFIdentityAuthViewModel()
    var udlId = "" // 用户注销申请ID
    
    ///账号验证
    lazy var resultView: HFCancelAccountResultView = {
        let resultView = Bundle.main.loadNibNamed("HFCancelAccountResultView", owner: nil, options: nil)?.last as! HFCancelAccountResultView
        return resultView
    }()
    
    // 注销成功后，点击右上角返回 到登陆页面
    override func backBtnClieck(send: UIButton) {
        
        if self.cancelState == .cancelTip1 ||
            self.cancelState == .through ||
            self.cancelState == .greaterUndo {
            navigationController?.popViewController(animated: true)
            return
        }
        
        self.myViewModel.logou {
            print("退出调用接口成功")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HFUserLogoutNotification"), object: nil)
        } _: {
            print("退出调用接口失败")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HFUserLogoutNotification"), object: nil)
        }
    }
    
//    func logoutSuccess() -> Void {
//        let hud = ShowHUD.showHUD(withInfo: "退出成功")
//        hud?.completionBlock = {
//
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        resultView.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.isTranslucent ? kNavigatioHeight : 0, width: S_SCREEN_WIDTH, height: S_SCREEN_HEIGHT - kNavigatioHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        if self.cancelState == .through || self.cancelState == .greaterUndo {
            self.cancelViewModel.getCancelStatus {
                self.resultView.cancelInfoModel = self.cancelViewModel.cancelInfoModel
                if 0 < self.cancelViewModel.cancelInfoModel!.restCancelDate {
                    // 可以撤销
                    self.resultView.cancelState = .through
                }else{
                    // 不可以撤销
                    self.resultView.cancelState = .greaterUndo
                }
            } _: { (error) in
                
            }

        }
    }
    
    func config() -> Void {
        self.title = "注销账号"
        self.view.addSubview(resultView)
        resultView.tipMessage = self.tipMessage
        self.resultView.cancelState = self.cancelState
        //参数 1是确定 2时去结算 3时返回首页 4是取消 5是确定注销
        resultView.operaClosure = { state in
            /**
             case cancelTip1  // 注销提示1（不满足注销条件）
             case cancelTip2  // 注销提示1（通过认证后提示）
             case waitReview  // 注销成功,等待审核
             case reviewIng   // 审核中
             case reject      // 审核拒绝
             case through     // 审核通过（撤销期内）
             case greaterUndo // 超过注销撤销期（撤销期为90天）
             case undefined   // 未定义
             */
            if state == .cancelTip1 {
//                self.resultView.cancelState = .cancelTip2
                ///获取客服电话
                ShowHUD.showHUDLoading()
                self.myViewModel.getCustomerServiceTelephone({
                    ShowHUD.hiddenHUDLoading()
                    self.call_telephone()
                }) {
                    ShowHUD.hiddenHUDLoading()
                }
            }else if state == .cancelTip2 {
                self.resultView.cancelState = .waitReview
            }else if state == .waitReview {
                self.resultView.cancelState = .reviewIng
                
            }else if state == .reviewIng {
                self.resultView.cancelState = .reject
                self.cancelCancellation()
            }else if state == .reject {
                self.resultView.cancelState = .through
            }else if state == .through {
                self.cancelCancellation()
            }else if state == .greaterUndo {
                self.goBack()
            }else{
                print("瞎点什么玩意儿")
            }
        }
    }
    
    func call_telephone() -> Void {
        // 拨打电话
        let phone = "telprompt://" + myViewModel.serviceTelephone
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.openURL(URL(string: phone)!)
        }
    }

    /// 撤回注销
    func cancelCancellation() -> Void {
        self.showCustomAlert("撤回注销账号", "撤回注销成功后，账号数据将被恢复，确认是否撤回注销账号。", "取消", "确认") {
            
        } _: {
            self.confirmCancel()
        }
    }
    
    /// 确认撤销
    func confirmCancel() {
        ShowHUD.showHUDLoading()
        myViewModel.undoCancellation({
            ShowHUD.hiddenHUDLoading()
            self.cancelSuccesss()
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    /// 撤回成功
    func cancelSuccesss() -> Void {
        if HFUserInformation.userInfo() != nil {
            // 恢复为未注销状态
            HFUserInformation.sync(parameters: ["ucDestruction":0])
        }
        self.goBack()
    }
    
    func goBack() -> Void {
        if self.cancelState == .cancelTip1 ||
            self.cancelState == .through ||
            self.cancelState == .greaterUndo {
            navigationController?.popViewController(animated: true)
        } else {
//            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main_Parent", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            ShowHUD.showHUDLoading()
            self.myViewModel.logou {
                ShowHUD.hiddenHUDLoading()
                print("退出调用接口成功")
                self.logoutSuccess()
            } _: {
                print("退出调用接口失败")
                ShowHUD.hiddenHUDLoading()
                self.logoutSuccess()
            }
        }
    }
    
    
    
    func logoutSuccess() -> Void {
        let hud = ShowHUD.showHUD(withInfo: "请重新登录")
        hud?.completionBlock = {
            if ((UIDevice.current.systemVersion.float() ?? 0) > 13.0) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HFUserLogoutNotification"), object: nil)
            }else{
                let userDefaluts = UserDefaults.standard
                userDefaluts.set(object: UIDevice.jk_version(), forKey: "version")
                userDefaluts.setValue(false, forKey: "LoginOutTag")
                userDefaluts.synchronize()
                let baseNv = HFNewBaseNavigationController(rootViewController: HFNewLoginViewController())
                baseNv.modalPresentationStyle = .overFullScreen
                UIApplication.shared.keyWindow?.rootViewController = baseNv
            }
        }
    }
    
    
    
}
