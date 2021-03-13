//
//  HFNewLoginViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/10/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class HFNewLoginViewController: HFNewBaseViewController,UITextFieldDelegate {
    
    //    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var roundView: UIView!
    /// 注册新账号Button
    @IBOutlet weak var registerBtn: UIButton!
    /// 忘记密码Button
    @IBOutlet weak var forgetBtn: UIButton!
    /// 【顶部】快捷登录Button
    @IBOutlet weak var fastLoginBtn: UIButton!
    /// 【顶部】密码登陆Button
    @IBOutlet weak var passWordLoginBtn: UIButton!
    /// 账号 手机号 TextField
    @IBOutlet weak var phoneNumberText: UITextField!
    /// 密码 验证码 TextField
    @IBOutlet weak var verCode: UITextField!
    /// 获取验证码 快捷登录时获取验证码
    @IBOutlet weak var optionBtn: UIButton!
    /// 密码登录时显示/隐藏密码
    @IBOutlet weak var eyeBtn: UIButton!
    /// 密码登陆Button 调用登陆接口
    @IBOutlet weak var loginBtn: UIButton!
    /// 同意协议 Button
    @IBOutlet weak var agreementBtn: UIButton!
    ///
    //    @IBOutlet weak var threeAccountState: UILabel!
    /// 微信登陆Button 【调用微信登陆】
    @IBOutlet weak var threeAccountBtn: UIButton!
    ///
    @IBOutlet weak var agreementAttLab: HFAttributeTapLabel!
    
    @IBOutlet weak var enverimentChangeBtn: UIButton!
    
    var inputOk = false
    
    var countDown: HFSwiftCountDown?
    let myViewModel = HFLoginRegisterViewModel()
    
    // MARK: Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberText.delegate = self
        
        loginBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        loginBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        registerBtn.setTitleColor(.colorMain(), for: .normal)
        
        phoneNumberText.keyboardType = .numberPad
        
        self.roundView.backgroundColor = HFLoginRegistConfig.roundBgColor
        self.optionBtn.isHidden = false
        self.eyeBtn.isHidden = true
        self.fastLoginBtn.setTitleColor(HFLoginRegistConfig.loginTitleColor, for: .selected)
        self.fastLoginBtn.setTitleColor(.colorPrimaryTitle(), for: .normal)
        self.passWordLoginBtn.setTitleColor(HFLoginRegistConfig.loginTitleColor, for: .selected)
        self.passWordLoginBtn.setTitleColor(.colorPrimaryTitle(), for: .normal)
        self.optionBtn.setTitleColor(HFLoginRegistConfig.smsGetBtnTitleColor, for: .normal)
        self.optionBtn.setTitleColor(HFLoginRegistConfig.smsGetBtnTitleDisableColor, for: .disabled)
        self.optionBtn.isEnabled = false
        self.agreementBtn.setImage(HFLoginRegistConfig.agreementNormalImage, for: .normal)
        self.agreementBtn.setImage(HFLoginRegistConfig.agreementSelectImage, for: .selected)
        self.agreementBtn.isSelected = false
        
        self.phoneNumberText.addTarget(self, action: #selector(textFieldChange(tf:)), for: .editingChanged)
        self.verCode.addTarget(self, action: #selector(textFieldChange(tf:)), for: .editingChanged)
        
        self.fastLogin(self.fastLoginBtn)
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginAuthorSuccess(_:)), name: NSNotification.Name(rawValue: LoginAuthorSuccessNotifacation), object: nil)
        
        #if DEBUG
        self.enverimentChangeBtn.isHidden = false;
        if let hostUrl = UserDefaults.standard.value(forKey: HFHotfixServiceHostUrlKry) as? String {
            self.enverimentChangeBtn.setTitle(hostUrl, for: .normal)
        }
        #else
        self.enverimentChangeBtn.isHidden = true;
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let logout = UserDefaults.standard.bool(forKey: "LoginOutTag")
        if logout == false {
            ShowHUD.showHUD(withInfo: "登录失效，请重新登录")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    MARK: Actions
    @IBAction func fastLogin(_ sender: UIButton) {
        myViewModel.loginType = 1
        self.phoneNumberText.text = ""
        self.phoneNumberText.placeholder = "请输入手机号"
        self.verCode.placeholder = "请输入验证码"
        self.verCode.text = "";
        self.phoneNumberText.keyboardType = .numberPad
        self.verCode.keyboardType = .numberPad
        if self.passWordLoginBtn.isSelected == true {
            self.view.endEditing(false)
        }
        self.optionBtn.isHidden = false
        self.eyeBtn.isHidden = true
        self.verCode.isSecureTextEntry = false
        self.fastLoginBtn.isSelected = true
        self.passWordLoginBtn.isSelected = false
        self.fastLoginBtn.isSelected = true
        self.fastLoginBtn.titleLabel?.font = UIFont.semiboldFont(ofSize: 20)
        self.passWordLoginBtn.isSelected = false
        self.passWordLoginBtn.titleLabel?.font = UIFont.semiboldFont(ofSize: 14)
        
        let nameText = phoneNumberText.rx.text.orEmpty.map { $0.count == 11 }.share(replay: 1) // 手机号11位
        _ = nameText.subscribe(onNext: {[weak self] (bool) in
                    if !self!.optionBtn.isHidden {
                        self?.optionBtn.isEnabled = bool
                    }
                  }, onCompleted: nil, onDisposed: nil)
        let verCodeText = verCode.rx.text.orEmpty.map { $0.count == 6 }.share(replay: 1) // 验证码6位
        _ = Observable
            .combineLatest(nameText, verCodeText) {$0 && $1}
            .share(replay: 1)
            .subscribe(onNext: {[weak self] (bool) in
                // 修改按钮是否可以点击
//                self?.loginBtn.isEnabled = bool && self!.agreementBtn.isSelected
                self?.loginBtn.isEnabled = bool
                self?.inputOk = bool
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
    }
    
    @IBAction func passwordLogin(_ sender: UIButton) {
        myViewModel.loginType = 0
        self.phoneNumberText.placeholder = "请输入手机号/用户名"
        self.verCode.placeholder = "请输入密码"
        self.phoneNumberText.text = ""
        self.verCode.text = "";
        self.phoneNumberText.keyboardType = .namePhonePad
        self.verCode.keyboardType = .asciiCapable
        if self.fastLoginBtn.isSelected == true {
            self.view.endEditing(false)
        }
        self.optionBtn.isHidden = true
        self.eyeBtn.isHidden = false
        self.verCode.isSecureTextEntry = !self.eyeBtn.isSelected
        self.fastLoginBtn.isSelected = false
        self.passWordLoginBtn.isSelected = true
        self.passWordLoginBtn.titleLabel?.font = UIFont.semiboldFont(ofSize: 20)
        self.fastLoginBtn.isSelected = false
        self.fastLoginBtn.titleLabel?.font = UIFont.semiboldFont(ofSize: 14)
        
        //        let nameText = phoneNumberText.rx.text.orEmpty.map { $0.count == 11 }.share(replay: 1)
        let nameText = phoneNumberText.rx.text.orEmpty.map { $0.count > 0 }.share(replay: 1)
        let verCodeText = verCode.rx.text.orEmpty.map { $0.count > 5 && $0.count <= 20 }.share(replay: 1)
        // 输入内容必须大于5位且小于18位
        _ = Observable
            .combineLatest(nameText, verCodeText) {$0 && $1}
            .share(replay: 1)
            .subscribe(onNext: {[weak self] (bool) in
                // 修改按钮是否可以点击
//                self?.loginBtn.isEnabled = bool && self!.agreementBtn.isSelected
                self?.loginBtn.isEnabled = bool
                self?.inputOk = bool
            }, onError: { (error) in
            }, onCompleted: nil, onDisposed: nil)
    }
    
    @IBAction func swiftEye(_ sender: UIButton) {
        eyeBtn.isSelected = !eyeBtn.isSelected
        verCode.isSecureTextEntry = !verCode.isSecureTextEntry
    }
    
    @objc func textFieldChange(tf: UITextField) {
        /**
         手机号/用户名输入框
         支持字母数字输入，最多20个字符限制，超出不可输入
         密码输入框
         密文显示最多20个字符限制输入
         */
        if self.fastLoginBtn.isSelected {
            if let text = self.phoneNumberText.text {
                self.phoneNumberText.text = String(text.prefix(11))
            }
            if let text = self.verCode.text {
                self.verCode.text = String(text.prefix(6))
            }
        }else{
            if let text = self.phoneNumberText.text {
                self.phoneNumberText.text = String(text.prefix(20))
            }
            if let text = self.verCode.text {
                self.verCode.text = String(text.prefix(20))
            }
        }
    }
    
    
    
    @IBAction func getSmsCode(_ sender: UIButton) {
        if phoneNumberText.text?.isEmptyStr() == true {
            ShowHUD.showHUD(withInfo: "请输入手机号")
            return
        }
        if phoneNumberText.text?.isPhoneNum() == false {
            ShowHUD.showHUD(withInfo: "请输入手机号")
            return
        }
        ShowHUD.showHUDLoading()
        myViewModel.sendLoginSmsCode(phone: phoneNumberText.text!, {
            ShowHUD.hiddenHUDLoading()
            ShowHUD.showHUD(withInfo: "发送成功")
            if self.countDown != nil {
                self.countDown?.stop()
                self.countDown = nil
            }
            self.countDown = HFSwiftCountDown.init()
            self.countDown?.countDown(timeInterval: 1, repeatCount: 60, handler: { [weak self] (time, count) in
                if count != 0 {
                    self?.optionBtn.setTitle(("\(count)s"), for: .normal)
                    self?.optionBtn.isUserInteractionEnabled = false
                }else{
                    self?.optionBtn.setTitle("重新获取", for: .normal)
                    self?.optionBtn.isUserInteractionEnabled = true
                }
            })
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.passWordLoginBtn.isSelected {
            if self.phoneNumberText == textField {
                // 限制仅输入数字和字母
                let characterSet = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789").inverted
                let filtered = string.components(separatedBy: characterSet)
                let ss = filtered.joined(separator: "")
                return ss == string
            }
        }
        return true
    }
    
    // 注册
    @IBAction func regist(_ sender: UIButton) {
        let vc = HFRegistViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 忘记密码
    @IBAction func forget(_ sender: UIButton) {
        let vc = HFForgetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 微信登录
    @IBAction func weChatLogin(_ sender: UIButton) {
        
        /*
         scope - 必须，应用授权作用域，如获取用户个人信息则填写snsapi_userinfo
         state - 非必须，用于保持请求和回调的状态，授权请求后原样带回给第三方。该参数可用于防止csrf攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数加session进行校验
         appid - 必须，应用唯一标识，在微信开放平台提交应用审核通过后获得
         */
        myViewModel.loginType = 2
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "com.huifan.ColorfulFuturePrincipal"
//        req.openID = WeChat_Key
        WXApi.send(req) { (success) in
            print(success)
        }
    }
    
    @objc func loginAuthorSuccess(_ notif: Notification) -> Void {
        let openID = notif.object
        self.myViewModel.ucWxOpenid = openID as! String
        self.login(self.fastLoginBtn)
    }
    
    @IBAction func agreementClick(_ sender: UIButton) {
        self.agreementBtn.isSelected = !self.agreementBtn.isSelected
        self.loginBtn.isEnabled = self.inputOk && self.agreementBtn.isSelected
    }
    
    @IBAction func login(_ sender: UIButton) {
        if self.agreementBtn.isSelected == false {
            AlertTool.showBottom(withText: "请先勾选用户协议")
            return
        }
        ShowHUD.showHUDLoading()
        if self.myViewModel.loginType == 0 {
            myViewModel.usrPassword = verCode.text!
        }else if self.myViewModel.loginType == 1 {
            myViewModel.code = verCode.text!
        }else{
            
        }
        myViewModel.nameOrPhone = phoneNumberText.text!
        myViewModel.login {
            ShowHUD.hiddenHUDLoading()
            self.loginSuccess()
        } _: {
            ShowHUD.hiddenHUDLoading()
        } _: {
            ShowHUD.hiddenHUDLoading()
            let bind = HFBindingPhoneViewController()
            bind.openId = self.myViewModel.ucWxOpenid
            bind.bindSuccessClosure = {
                self.login(self.loginBtn)
            }
            self.navigationController?.pushViewController(bind, animated: true)
        }
    }
    
    
//    func onReq(_ req: BaseReq) {
//
//    }
//
//    func onResp(_ resp: BaseResp) {
//
//    }
    
    @IBAction func environmentConfig(_ sender: UIButton) {
        
        let hh = HFEnvironmentConfigController()
        self.present(hh, animated: true, completion: {})
    }
    
}

