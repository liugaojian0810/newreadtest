//
//  HFBindingPhoneViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by wzz on 2020/10/19.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HFBindingPhoneViewController: HFNewBaseViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var smsCodeTextField: UITextField!
    @IBOutlet weak var smsCodeBtn: UIButton!
    @IBOutlet weak var bindBtn: UIButton!
    
    var myViewModel = HFLoginRegisterViewModel()
    var countDown: HFSwiftCountDown?
    var openId = "" // 微信OpenId
    var bindSuccessClosure: OptionClosure? // 微信绑定成功

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "绑定手机"
        
        let bottomLineVerPhone = CALayer()
        bottomLineVerPhone.frame = CGRect(x: 0, y: 65, width: S_SCREEN_WIDTH - 54, height: 1)
        bottomLineVerPhone.backgroundColor = UIColor.jk_color(withHexString: "#EDEDED")?.cgColor
        phoneTextField.layer.addSublayer(bottomLineVerPhone)
        
        let bottomLineVerCode = CALayer()
        bottomLineVerCode.frame = CGRect(x: 0, y: 65, width: S_SCREEN_WIDTH - 54, height: 1)
        bottomLineVerCode.backgroundColor = UIColor.jk_color(withHexString: "#EDEDED")?.cgColor
        smsCodeTextField.layer.addSublayer(bottomLineVerCode)
        
        bindBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        bindBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        bindBtn.isEnabled = false
        let nameText = phoneTextField.rx.text.orEmpty.map { $0.count == 11 }.share(replay: 1)
        let verCodeText = smsCodeTextField.rx.text.orEmpty.map { $0.count == 6 }.share(replay: 1)
        _ = Observable
            .combineLatest(nameText, verCodeText) {$0 && $1}
            .share(replay: 1)
            .subscribe(onNext: {[weak self] (bool) in
                // 修改按钮是否可以点击
                self?.bindBtn.isEnabled = bool
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
    }
    
    /// 登录微信发送验证码
    @IBAction func sendSmsCode(_ sender: UIButton) {
        if phoneTextField.text?.isPhoneNum() == false {
            AlertTool.showBottom(withText: "请输入有效手机号")
            return
        }else{
            ShowHUD.showHUDLoading()
            // 发送验证码
            myViewModel.loginWXSendCode(phone: phoneTextField.text!) {
                ShowHUD.hiddenHUDLoading()
                self.sendVerifyCodeSuccess()
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
        }
    }
    
    /// 发送验证码成功
    func sendVerifyCodeSuccess() -> Void {
//        myViewModel.sendVcode(phone: phoneTextField.text!, bizType: "forget-password", {
//            ShowHUD.hiddenHUDLoading()
            if self.countDown != nil {
                self.countDown?.stop()
                self.countDown = nil
            }
            self.countDown = HFSwiftCountDown.init()
            self.countDown?.countDown(timeInterval: 1, repeatCount: 60, handler: { [weak self] (time, count) in
                if count != 0 {
                    self?.smsCodeBtn.setTitle(("\(count)s"), for: .normal)
                    self?.smsCodeBtn.isUserInteractionEnabled = false
                }else{
                    self?.smsCodeBtn.setTitle("重新获取", for: .normal)
                    self?.smsCodeBtn.isUserInteractionEnabled = true
                }
            })
//        }) {
//            ShowHUD.hiddenHUDLoading()
//        }
    }
    
    /// 校验手机号是否绑定过微信
    @IBAction func bindingPhone(_ sender: UIButton) {
        // 校验手机号是否绑定过微信 ⚠️ 手机端暂时不需要验证 后端验证
        
        myViewModel.loginWXBind(phone: phoneTextField.text!, code: smsCodeTextField.text!, ucWxOpenid: openId) {
            self.loginSuccess()
            ShowHUD.hiddenHUDLoading()
            
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    func loginSuccess() -> Void {
        
        let userInfo = HFUserInformation.userInfo()
        // 注销状态校验
        if userInfo?.ucDestruction == 1 || userInfo?.ucDestruction == 2 {
            let vc = HFCancelAccountResultController()
            if userInfo?.ucDestruction == 1 {
                vc.cancelState = .through
            }
            if userInfo?.ucDestruction == 2 {
                vc.cancelState = .greaterUndo
            }
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        // 是否需要强制修改密码
        if userInfo?.usrNeedChangePwd == 1 {
            let vc = HFSetNewPasswordViewController()
            vc.phone = phoneTextField.text!
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        // 资料完整度校验
        if userInfo?.ucFinishInfo == 0 {
            let vc = HFPerfectInformationViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        UIApplication.shared.keyWindow!.rootViewController = HFViewController();
    }
    /// 微信绑定手机号


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
