//
//  HFUpdateUserNameController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/11/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum OperaPhase {
    
    case tip //提示信息
    case varify //验证密码
    case update //修改阶段
}

class HFUpdateUserNameController: HFNewBaseViewController {
    
    let viewModel = HFSetupViewModel()
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var coverBgView: UIView!
    @IBOutlet weak var tipMsgLabel: UILabel!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var verifyNtm: UIButton!
    @IBOutlet weak var funTipLabel: UILabel!
    @IBOutlet weak var textTipLabel: UILabel!
    var canEditUsrName: Bool = true
    @IBOutlet weak var operationBtn: UIButton!

    var currentPhase: OperaPhase = .tip
    var updateSuccessClosure: OptionClosureString?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    func config() -> Void {
        
        self.title = "修改用户名"
        userNameLabel.text = "用户名: " + (HFUserInformation.userInfo()?.usrName ?? "")
        verifyNtm.jk_setBackgroundColor(.colorMain(), for: .normal)
        verifyNtm.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {[weak self] (text) in
                // 修改按钮是否可以点击
                self?.verifyNtm.isEnabled = !text.isEmpty
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
        
        if self.canEditUsrName == false {
            self.operationBtn.isUserInteractionEnabled = false
            self.operationBtn.backgroundColor = .gray
        }
    }
    
    @IBAction func nextStep(_ sender: Any) {
        switch currentPhase {
        case .tip:
            currentPhase = .varify
            self.coverBgView.isHidden = false
            tipMsgLabel.text = "填写当前的登录密码，验证本人身份"
            textField.placeholder = "请输入登录密码"
            self.verifyNtm.setTitle("验证", for: .normal)
            textField.isSecureTextEntry = true
            forgetPasswordBtn.isHidden = false
            textField.text = ""
            funTipLabel.text = "安全验证"
            textTipLabel.text = "登录密码"
        case .varify:
            view.endEditing(false)
            self.viewModel.usrPassword = textField.text!
            self.viewModel.checkPassowordAPI { [self] in
                currentPhase = .update
                self.coverBgView.isHidden = false
                tipMsgLabel.text = "用户名长度限8～20位，用字母加数字进行组合"
                textField.placeholder = "请输入新的用户名"
                self.verifyNtm.setTitle("确定", for: .normal)
                textField.isSecureTextEntry = false
                forgetPasswordBtn.isHidden = true
                viewModel.usrPassword = textField.text!
                textField.text = ""
                verifyNtm.isEnabled = false
                funTipLabel.text = "填写新的用户名"
                textTipLabel.text = "用户名"
            } _: {}
        case .update:
            view.endEditing(false)
            let usrName = textField.text!
            if !usrName.isUsrName() {
                HFAlert.show(withMsg: "您的用户名不符合规则", in: self, alertStatus: AlertStatusError)
                return
            }else{
                viewModel.usrName = usrName
                ShowHUD.showHUDLoading()
                viewModel.updateUserName {
                    ShowHUD.hiddenHUDLoading()
                    HFAlert.show(withMsg: "修改成功", in: self, alertStatus: AlertStatusSuccfess) {
                        if self.updateSuccessClosure != nil {
                            self.updateSuccessClosure!(usrName)
                        }
                        self.navigationController?.popViewController(animated: true)
                    }
                } _: {
                    ShowHUD.hiddenHUDLoading()
                }
            }
            break
        }
    }
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        let vc = HFForgetPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
