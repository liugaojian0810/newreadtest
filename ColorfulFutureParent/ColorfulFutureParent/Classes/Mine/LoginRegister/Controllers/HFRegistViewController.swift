//
//  HFRegistViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HFRegistViewController: HFNewBaseViewController {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var smsCodeTextField: UITextField!
    @IBOutlet weak var agreementAttLab: HFAttributeTapLabel!
    @IBOutlet weak var smsCodeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var agreementBtn: UIButton!
    @IBOutlet weak var alreadyAccountBtn: UIButton!
    
    var myViewModel = HFLoginRegisterViewModel()
    var countDown: HFSwiftCountDown?
    
    var inputOk = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = HFLoginRegistConfig.registTitle
        roundView.backgroundColor = HFLoginRegistConfig.roundBgColor
        let bottomLineVerPhone = CALayer()
        bottomLineVerPhone.frame = CGRect(x: 0, y: 63, width: S_SCREEN_WIDTH - 54, height: 1)
        bottomLineVerPhone.backgroundColor = UIColor.jk_color(withHexString: "#EDEDED")?.cgColor
        phoneTextField.layer.addSublayer(bottomLineVerPhone)
        phoneTextField.jk_maxLength = 11
        
        let bottomLineVerCode = CALayer()
        bottomLineVerCode.frame = CGRect(x: 0, y: 63, width: S_SCREEN_WIDTH - 54, height: 1)
        bottomLineVerCode.backgroundColor = UIColor.jk_color(withHexString: "#EDEDED")?.cgColor
        smsCodeTextField.layer.addSublayer(bottomLineVerCode)
        smsCodeTextField.jk_maxLength = 6
        
        alreadyAccountBtn.setTitleColor(.colorMain(), for: .normal)
        
        self.agreementBtn.setImage(HFLoginRegistConfig.agreementNormalImage, for: .normal)
        self.agreementBtn.setImage(HFLoginRegistConfig.agreementSelectImage, for: .selected)
        self.agreementBtn.isSelected = false
        
        self.agreementAttLab.tapBlock = { string in
            if (string == "《用户服务协议》") {
                print("点击用户服务协议")
            }else if (string == "用户隐私政策") {
                print("用户隐私政策")
            }else{
                print("儿童用户隐私政策")
            }
        };
        let str = "同意《用户服务协议》《用户隐私政策》及《儿童用户隐私政策》";
        
        let myAttribute = [NSAttributedString.Key.foregroundColor: HFLoginRegistConfig.agreementColor]
        let model1 = HFAttributeModel.init();
        model1.range = NSRange.init(location: 2, length: 8)
        model1.string = "《用户服务协议》";
        model1.attributeDic = myAttribute
        
        let model2 = HFAttributeModel.init();
        model2.range = NSRange.init(location: 10, length: 8)
        model2.string = "《用户隐私政策》";
        model2.attributeDic = myAttribute
        
        let model3 = HFAttributeModel.init();
        model3.range = NSRange.init(location: 19, length: 10)
        model3.string = "《儿童用户隐私政策》";
        model3.attributeDic = myAttribute
        
        //label内容赋值
        self.agreementAttLab.setText(str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xC0C0C0),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11)], tapStringArray: [model1,model2,model3])
        
        smsCodeBtn.setTitleColor(.colorMain(), for: .normal)
        smsCodeBtn.setTitleColor(.colorMainDisable(), for: .disabled)
        smsCodeBtn.isEnabled = false
        nextBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        nextBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        nextBtn.isEnabled = false
        let nameText = phoneTextField.rx.text.orEmpty.map { $0.count == 11 }.share(replay: 1)
        _ = nameText.subscribe(onNext: {[weak self] (bool) in
            self?.smsCodeBtn.isEnabled = bool
        }, onCompleted: nil, onDisposed: nil)
        let verCodeText = smsCodeTextField.rx.text.orEmpty.map { $0.count == 6 }.share(replay: 1)
        _ = Observable
            .combineLatest(nameText, verCodeText) {$0 && $1}
            .share(replay: 1)
            .subscribe(onNext: {[weak self] (bool) in
                // 修改按钮是否可以点击
                self?.nextBtn.isEnabled = bool && self!.agreementBtn.isSelected
                self?.inputOk = bool
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
    }
    
    @IBAction func sendSmsCode(_ sender: UIButton) {
        if self.agreementBtn.isSelected == false {
            ShowHUD.showHUD(withInfo: "请先勾选用户协议")
            return
        }
        if phoneTextField.text == "" {
            ShowHUD.showHUD(withInfo: "请输入手机号")
            return
        }
        ShowHUD.showHUDLoading()
        myViewModel.sendCodeForRegister(phone: phoneTextField.text!, {
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
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: UIButton) {
        if self.agreementBtn.isSelected == false {
            ShowHUD.showHUD(withInfo: "请先勾选用户协议")
            return
        }
        if phoneTextField.text == "" {
            ShowHUD.showHUD(withInfo: "请输入手机号")
            return
        }
        ShowHUD.showHUDLoading()
        myViewModel.registAccount(usrPhone: phoneTextField.text!, verCode: smsCodeTextField.text!, {
            ShowHUD.hiddenHUDLoading()
            let vc = HFSetNewPasswordViewController()
            vc.phone = self.phoneTextField.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    @IBAction func agreementClick(_ sender: UIButton) {
        self.agreementBtn.isSelected = !self.agreementBtn.isSelected
        self.nextBtn.isEnabled = self.inputOk && self.agreementBtn.isSelected
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
