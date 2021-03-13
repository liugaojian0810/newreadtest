//
//  HFSetNewPasswordViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum PassWordType {
    case set,affirm // 设置密码，确认密码
    case forgetSet,forgetAffirm // 忘记密码设置密码，确认密码
}

/// 设置新密码
class HFSetNewPasswordViewController: HFNewBaseViewController {

    var myViewModel = HFLoginRegisterViewModel()
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField! // 密码输入框
    @IBOutlet weak var securityLevelTipLable: UILabel!
    @IBOutlet weak var securityLevelLabel: UILabel! // 安全等级
    @IBOutlet weak var submitBtn: UIButton!
    
    var passwordLevel: SecuriLevel = .low // 密码安全等级（安全等级 0低 1中 2高）
    
    var type: PassWordType = .set
    
    var password: String? // 确认密码时传入 第一次输入
    
    var smsCode: String? // 忘记密码时传入
    
    var phone = "" // 设置密码时传入的手机号
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type {
        case .set:
            self.title = "设置密码"
            self.titleLabel.text = "设置登录密码"
            self.passwordTF.placeholder = "请输入密码"
        case .affirm:
            self.title = "设置密码"
            self.titleLabel.text = "设置登录密码"
            self.passwordTF.placeholder = "请再次输入密码"
            self.submitBtn.setTitle("确定", for: .normal)
        case .forgetSet:
            self.title = "设置新密码"
            self.titleLabel.text = "设置新密码"
            self.passwordTF.placeholder = "请输入新密码"
        case .forgetAffirm:
            self.title = "设置新密码"
            self.titleLabel.text = "设置新密码"
            self.passwordTF.placeholder = "请再次输入新密码"
            self.submitBtn.setTitle("确定", for: .normal)
        }
        
        roundView.backgroundColor = HFLoginRegistConfig.roundBgColor
        let bottomLinePhone = CALayer()
        bottomLinePhone.frame = CGRect(x: 0, y: 65, width: S_SCREEN_WIDTH - 80, height: 1)
        bottomLinePhone.backgroundColor = UIColor.jk_color(withHexString: "#EDEDED")?.cgColor
        passwordTF.layer.addSublayer(bottomLinePhone)
        
        submitBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        submitBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        submitBtn.isEnabled = false
        
        passwordTF.isSecureTextEntry = true
        securityLevelLabel.isHidden = true
        securityLevelTipLable.isHidden = true
        passwordTF.jk_maxLength = 20
        let passwordText = passwordTF.rx.text.orEmpty.map { $0.count >= 8 }.share(replay: 1)
        _ = passwordText.subscribe(onNext: {[weak self] (bool) in
            self?.submitBtn.isEnabled = bool
        }, onCompleted: nil, onDisposed: nil)
        _ = passwordTF.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {[weak self] (text) in
                // 修改按钮是否可以点击
                if text.isEmpty {
                    self?.securityLevelTipLable.isHidden = true
                    self?.securityLevelLabel.isHidden = true
                    self?.securityLevelLabel.text = "-"
                    self?.securityLevelLabel.textColor = .hexColor(0x666666)
                    self?.passwordLevel = .low
                }else{
                    self?.securityLevelTipLable.isHidden = false
                    self?.securityLevelLabel.isHidden = false
                    let lever = text.securityLever()
                    switch lever {
                    case .low:
                        print("低")
                        self?.securityLevelLabel.text = "低"
                        self?.securityLevelLabel.textColor = .hexColor(0x666666)
                        self?.passwordLevel = .low
                    case .mid:
                        print("中")
                        self?.securityLevelLabel.text = "中"
                        self?.securityLevelLabel.textColor = .hexColor(0x00D1A9)
                        self?.passwordLevel = .mid
                    case .high:
                        print("高")
                        self?.securityLevelLabel.text = "高"
                        self?.securityLevelLabel.textColor = .hexColor(0x00D1A9)
                        self?.passwordLevel = .high
                    }
                }
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
    }
    
    // 切换文本显示
    @IBAction func switchSecureTextEntry(_ sender: UIButton) {
        self.passwordTF.isSecureTextEntry = !self.passwordTF.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    
    // 提交
    @IBAction func submit(_ sender: UIButton) {
        if passwordLevel == .low {
            ShowHUD.showHUD(withInfo: "密码等级过低")
            return
        }
        switch type {
        case .set,.forgetSet:
            let vc = HFSetNewPasswordViewController()
            if type == .set {
                vc.type = .affirm
            }else{
                vc.type = .forgetAffirm
            }
            vc.password = passwordTF.text
            vc.smsCode = smsCode
            vc.phone = phone
            self.navigationController?.pushViewController(vc, animated: true)
        case .affirm:
            if password != passwordTF.text {
                ShowHUD.showHUD(withInfo: "确认密码不一致，请重新输入")
                return
            }
            ShowHUD.showHUDLoading()
            myViewModel.setInitPassword(phone:phone, usrPassword: passwordTF.text ?? "",validatePassword: password!, usrPwdLevel: self.passwordLevel.rawValue, {
                ShowHUD.hiddenHUDLoading()
                let vc = HFPerfectInformationViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }) {
                ShowHUD.hiddenHUDLoading()
            }
        case .forgetAffirm:
            if password != passwordTF.text {
                ShowHUD.showHUD(withInfo: "确认密码不一致，请重新输入")
                return
            }
            ShowHUD.showHUDLoading()
            myViewModel.forgetpassword(phone: phone, code: smsCode!, usrPassword: password!, validatePassword: passwordTF.text!, usrPwdLevel: self.passwordLevel.rawValue) {
                ShowHUD.hiddenHUDLoading()
//                self.navigationController?.popToRootViewController(animated: true)
                HFAlert.show(withMsg: "设置成功", in: self, alertStatus: AlertStatusSuccfess)
                Asyncs.asyncDelay(2) {
                } _: {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
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
