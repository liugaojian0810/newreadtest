//
//  HFAccountValidationCell.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/20.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum AccountValidationType {
    case account //账号验证
    case identity //身份验证
}


class HFAccountValidationCell: UITableViewCell {
    
    @IBOutlet weak var firstTipLabel: UILabel!
    @IBOutlet weak var secondTipLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var smsCodeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var btnClickClosure: OptionClosure?
    var getSmsCodeBlock: OptionClosure?
    
    var validType: AccountValidationType = .account {
        didSet{
            
            if validType == .account {
                self.firstTipLabel.text = "手机号"
                self.secondTipLabel.text = "密码"
                self.firstTextField.text = ""
                self.secondTextField.text = ""
                self.firstTextField.placeholder = "请输入手机号"
                self.secondTextField.placeholder = "请输入密码"
            }else{
                
                self.firstTipLabel.text = "用户姓名"
                self.secondTipLabel.text = "身份证号"
                self.firstTextField.text = ""
                self.secondTextField.text = ""
                self.firstTextField.placeholder = "请输入用户姓名"
                self.secondTextField.placeholder = "请输入身份证号"
            }
        }
        willSet{
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstTextField.jk_maxLength = 11
        firstTextField.keyboardType = .numberPad
        smsCodeBtn.setTitleColor(.colorMain(), for: .normal)
        smsCodeBtn.setTitleColor(.colorMainDisable(), for: .disabled)
        smsCodeBtn.isEnabled = false
        
        secondTextField.jk_maxLength = 6
        secondTextField.keyboardType = .numberPad
        nextBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        nextBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        nextBtn.isEnabled = false
        
        let nameText = firstTextField.rx.text.orEmpty.map { $0.count == 11 }.share(replay: 1)
        _ = nameText.subscribe(onNext: {[weak self] (bool) in
            self?.smsCodeBtn.isEnabled = bool
        }, onCompleted: nil, onDisposed: nil)
        let verCodeText = secondTextField.rx.text.orEmpty.map { $0.count == 6 }.share(replay: 1)
        _ = Observable
            .combineLatest(nameText, verCodeText) {$0 && $1}
            .share(replay: 1)
            .subscribe(onNext: {[weak self] (bool) in
                // 修改按钮是否可以点击
                self?.nextBtn.isEnabled = bool
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func nextStep(_ sender: UIButton) {
        
        if btnClickClosure != nil {
            btnClickClosure!()
        }
        
    }
    
    @IBAction func smsCode(_ sender: UIButton) {
        
        if getSmsCodeBlock != nil {
            getSmsCodeBlock!()
        }
    }
    
    
}
