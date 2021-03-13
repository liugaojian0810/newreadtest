//
//  HFAccountSetPasswordController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/20.
//  Copyright © 2020 huifan. All rights reserved.
//。设置密码

import UIKit

enum PasswordType {
    
    case original
    case current
}

class HFAccountSetPasswordController: HFNewBaseViewController {
    
    var passwordLevel: SecuriLevel = .low // 密码安全等级（安全等级 0低 1中 2高）
    var oldPassword: String?

    @IBOutlet weak var passSecuTipLabel: UILabel!
    @IBOutlet weak var levelTipLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    var type: PasswordType?
    @objc var original: Bool = false {
        didSet{
            if original == true {
                type = .original
            }else{
                type = .current
            }
        }
    }
    
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!

    var myViewModel = HFSetupViewModel()
    var loginRegisterViewModel = HFLoginRegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }

    func config() -> Void {
        self.title = "设置密码"
        self.submitBtn.alpha = 0.5
        self.submitBtn.isUserInteractionEnabled = false
        if type == .original {
            passSecuTipLabel.isHidden = true
            levelTipLabel.isHidden = true
            levelLabel.isHidden = true
            self.textFieldOne.placeholder = "请输入原始密码"
            self.bottomBgView.isHidden = true
            self.bottomViewHeight.constant = 0
            submitBtn.setTitle("下一步", for: .normal)
        }else{
            passSecuTipLabel.isHidden = false
            levelTipLabel.isHidden = false
            levelLabel.isHidden = false
            self.textFieldOne.placeholder = "请输入新密码"
            self.textFieldTwo.placeholder = "再次确认密码"
            self.bottomBgView.isHidden = false
            self.bottomViewHeight.constant = 60
            submitBtn.setTitle("提交", for: .normal)
            textFieldTwo.rx.text.orEmpty.asObservable()
                .subscribe(onNext: {[weak self](text) in
                    self?.submitBtn.isEnabled = !text.isEmpty
                    if text.isEmpty {
                        self?.levelLabel.text = "-"
                        self?.levelLabel.textColor = .hexColor(0x666666)
                        self?.passwordLevel = .low
                    } else {
                        let level = text.securityLever()
                        switch level {
                        case .low:
                            self?.levelLabel.text = "低"
                            self?.levelLabel.textColor = .hexColor(0x666666)
                            self?.passwordLevel = .low
                        case .mid:
                            self?.levelLabel.text = "中"
                            self?.levelLabel.textColor = .hexColor(0x00D1A9)
                            self?.passwordLevel = .mid
                        case .high:
                            self?.levelLabel.text = "高"
                            self?.levelLabel.textColor = .hexColor(0x00D1A9)
                            self?.passwordLevel = .high
                        }
                    }
                }, onError: {(error) in }, onCompleted: nil, onDisposed: nil)
        }
        
        
        textFieldOne.addTarget(self, action: #selector(textFieldChnage(uitext:)), for: .editingChanged)
        textFieldTwo.addTarget(self, action: #selector(textFieldChnage(uitext:)), for: .editingChanged)
    }
    
    
    @objc func textFieldChnage(uitext: UITextField) {
        if uitext.tag == 101  {
            if type == .original {
                self.myViewModel.oldPass = uitext.text ?? ""
            }else{
                self.myViewModel.pass = uitext.text ?? ""
            }
        }else{
            self.myViewModel.deteminPass = uitext.text ?? ""
        }

        if type == .original {
            if self.textFieldOne.text?.isEmptyStr() == false {
                self.submitBtn.alpha = 1
                self.submitBtn.isUserInteractionEnabled = true
            }else{
                self.submitBtn.alpha = 0.5
                self.submitBtn.isUserInteractionEnabled = false
            }
        }else{
            
            if (self.textFieldOne.text?.isEmptyStr() == false) && (self.textFieldTwo.text?.isEmptyStr() == false) {
                self.submitBtn.alpha = 1
                self.submitBtn.isUserInteractionEnabled = true
            }else{
                self.submitBtn.alpha = 0.5
                self.submitBtn.isUserInteractionEnabled = false
            }
        }
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            if sender.tag == 101 {
                textFieldOne.isSecureTextEntry = true
            }else{
                textFieldTwo.isSecureTextEntry = true
            }
        }else{
            if sender.tag == 101 {
                textFieldOne.isSecureTextEntry = false
            }else{
                textFieldOne.isSecureTextEntry = false
            }
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        self.view.endEditing(true)
        if type == .original {
//            self.myViewModel.oldPass = self.textFieldOne.text ?? ""
//            myViewModel.verifyOldPassword({
//                let vc = HFAccountSetPasswordController()
//                vc.type = .current
//                self.navigationController?.pushViewController(vc, animated: true)
//            }) {
//                HFAlert.show(withMsg: "密码错误", in: self, alertStatus: AlertStatusError)
//            }
            let vc = HFAccountSetPasswordController()
            vc.oldPassword = self.textFieldOne.text ?? ""
            vc.type = .current
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            self.myViewModel.pass = self.textFieldOne.text ?? ""
            self.myViewModel.deteminPass = self.textFieldTwo.text ?? ""
            ShowHUD.showHUDLoading()
            loginRegisterViewModel.mineUpdatepassword(oldPassword: self.oldPassword!, usrPassword: self.myViewModel.pass, validatePassword: self.myViewModel.deteminPass, usrPwdLevel: passwordLevel.rawValue) {
                ShowHUD.hiddenHUDLoading()
//                HFAlert.show(withMsg: "设置成功", in: self, alertStatus: AlertStatusSuccfess)
                for item in self.navigationController?.viewControllers ?? [] {
                    if item.isKind(of: HFAccountSecurityController.classForCoder()) {
                        self.navigationController?.popToViewController(item, animated: true)
                    }
                    print(item)
                }
            } _: {
                ShowHUD.hiddenHUDLoading()
//                HFAlert.show(withMsg: "设置出错", in: self, alertStatus: AlertStatusError)
            }
        }
    }
}
