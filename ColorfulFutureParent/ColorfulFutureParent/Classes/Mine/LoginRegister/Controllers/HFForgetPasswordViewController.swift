//
//  HFForgetPasswordViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// 忘记密码
class HFForgetPasswordViewController: HFNewBaseViewController {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var smsCodeTextField: UITextField!
    @IBOutlet weak var smsCodeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var myViewModel = HFLoginRegisterViewModel()
    var countDown: HFSwiftCountDown?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "忘记密码"
        smsCodeBtn.setTitleColor(.colorMain(), for: .normal)
        smsCodeBtn.setTitleColor(.colorMainDisable(), for: .disabled)
        smsCodeBtn.isEnabled = false
        phoneTextField.jk_maxLength = 11
        smsCodeTextField.jk_maxLength = 6
        
        roundView.backgroundColor = HFLoginRegistConfig.roundBgColor
        
        nextBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        nextBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        nextBtn.isEnabled = false
        let nameText = phoneTextField.rx.text.orEmpty.map { $0.count == 11 }.share(replay: 1)
        _ = nameText.subscribe(onNext: {[weak self] (bool) in
                    if !self!.smsCodeBtn.isHidden {
                        self?.smsCodeBtn.isEnabled = bool
                    }
                  }, onCompleted: nil, onDisposed: nil)
        let verCodeText = smsCodeTextField.rx.text.orEmpty.map { $0.count == 6 }.share(replay: 1)
        _ = Observable
            .combineLatest(nameText, verCodeText) {$0 && $1}
            .share(replay: 1)
            .subscribe(onNext: {[weak self] (bool) in
                // 修改按钮是否可以点击
                self?.nextBtn.isEnabled = bool
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
        
        self.phoneTextField.addTarget(self, action: #selector(textFieldChange(tf:)), for: .editingChanged)
        self.smsCodeTextField.addTarget(self, action: #selector(textFieldChange(tf:)), for: .editingChanged)
    }
    
    @objc func textFieldChange(tf: UITextField) {
        if let text = self.phoneTextField.text {
            self.phoneTextField.text = String(text.prefix(11))
        }
        if let text = self.smsCodeTextField.text {
            self.smsCodeTextField.text = String(text.prefix(6))
        }
    }

    @IBAction func sendSmsCode(_ sender: UIButton) {
        ShowHUD.showHUDLoading()
        myViewModel.forgetPassword_sendMSG(phone: phoneTextField.text!) {
            ShowHUD.hiddenHUDLoading()
            
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
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        ShowHUD.showHUDLoading()
        /// 调用忘记验证码验证接口
        myViewModel.forgetPassword(checkPhone: phoneTextField.text!, code: smsCodeTextField.text!) {
            ShowHUD.hiddenHUDLoading()
            let vc = HFSetNewPasswordViewController()
            vc.type = .forgetSet
            vc.phone = self.phoneTextField.text!
            vc.smsCode = self.smsCodeTextField.text
            self.navigationController?.pushViewController(vc, animated: true)
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
