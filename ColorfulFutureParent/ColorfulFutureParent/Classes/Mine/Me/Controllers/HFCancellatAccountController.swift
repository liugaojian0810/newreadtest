//
//  HFCancellatAccountController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/20.
//  Copyright © 2020 huifan. All rights reserved.
//  注销账号

import UIKit

class HFCancellatAccountController: HFNewBaseViewController {
    
    ///解绑警告UI界面
    lazy var warningView: HFCancelWaringView = {
        let warningView = Bundle.main.loadNibNamed("HFCancelWaringView", owner: nil, options: nil)?.last as! HFCancelWaringView
        
        warningView.nextBut?.jk_setBackgroundColor(.colorMain(), for: .normal)
        
        warningView.agreeBtn?.setImage(HFLoginRegistConfig.agreementNormalImage, for: .normal)
        warningView.agreeBtn?.setImage(HFLoginRegistConfig.agreementSelectImage, for: .selected)
        warningView.agreementAttLab?.tapBlock = { string in
            if (string == "《账号注销协议》") {
                print("查看账号注销协议")
            }
        };
        let str = "我已经阅读并同意《账号注销协议》";
        let myAttribute = [NSAttributedString.Key.foregroundColor: HFLoginRegistConfig.agreementColor]
        let model1 = HFAttributeModel.init();
        model1.range = NSRange.init(location: 8, length: 8)
        model1.string = "《账号注销协议》";
        model1.attributeDic = myAttribute
        //label内容赋值
        warningView.agreementAttLab?.setText(str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xC0C0C0),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11)], tapStringArray: [model1])
        
        warningView.nextStepBlock = {
            print("点击申请注销按钮")
            if self.warningView.agreeBtn?.isSelected != true {
                ShowHUD.showHUD(withInfo: "您还未同意《账号注销协议》")
                return
            }

            ShowHUD.showHUDLoading()
            self.myViewModel.checkuserdelete {
                ShowHUD.hiddenHUDLoading()
                self.userDeleteCheck = self.myViewModel.userDeleteCheck
                if let m = self.myViewModel.userDeleteCheck {
                    if m.allow {
                        // 允许注销。
                        //  1 已实名  调用人脸识别
                        //  0 未实名。 直接去调用注销
                        self.currentState = 2 // 改变当前状态
                    } else {
                        // 不允许注销 将后台的消息提示出来
                        let vc = HFCancelAccountResultController()
                        vc.tipMessage = m.message
                        vc.cancelState = .cancelTip1
                        self.navigationController?.pushViewController(vc, animated: true)

                    }
                }
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
        }
        
        warningView.agreeBlock = {
            print("点击同意协议")
        }
        
        warningView.withdrawBlock = {
            print("点击提现")
        }
        
        return warningView
    }()
    
    ///账号验证
    lazy var accountValidView: HFAccountValidationCell = {
        let accountValidView = Bundle.main.loadNibNamed("HFAccountValidationCell", owner: nil, options: nil)?.last as! HFAccountValidationCell
        
        accountValidView.isHidden = true
        
        accountValidView.btnClickClosure = {
            print("点击了下一步按钮")
            //验证手机号和验证码
            self.view.endEditing(true)
            ShowHUD.showHUDLoading()
            self.myViewModel.verifyPhoneQrCode(phone: self.accountValidView.firstTextField.text ?? "", .verifyAccount, self.accountValidView.secondTextField.text ?? "") {
                ShowHUD.hiddenHUDLoading()
                // 如果进行过实名认证则需要先进行实名认证再跳转
                if let m = self.userDeleteCheck {
                    if m.allow {
                        if m.verifyStatus == 1 {
                            // 已经实名认证  走人脸识别
                            self.faceDetect()
                        } else {
                            // 没有进行实名认证
                            self.submitDestruction()
                        }
                        
                    } else {
                        
                    }
                }
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
        }
        
        // 发送校验手机号验证码
        accountValidView.getSmsCodeBlock = {
            ShowHUD.showHUDLoading()
            self.myViewModel.sendCheckAccountCode(phone: self.accountValidView.firstTextField.text!) {
                ShowHUD.hiddenHUDLoading()
                ShowHUD.showHUD(withInfo: "发送成功")
                if self.countDown != nil {
                    self.countDown?.stop()
                    self.countDown = nil
                }
                self.countDown = HFSwiftCountDown.init()
                self.countDown?.countDown(timeInterval: 1, repeatCount: 60, handler: { [weak self] (time, count) in
                    if count != 0 {
                        self?.accountValidView.smsCodeBtn.setTitle(("\(count)s"), for: .normal)
                        self?.accountValidView.smsCodeBtn.isUserInteractionEnabled = false
                    }else{
                        self?.accountValidView.smsCodeBtn.setTitle("重新获取", for: .normal)
                        self?.accountValidView.smsCodeBtn.isUserInteractionEnabled = true
                    }
                })
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
        }
        
        return accountValidView
    }()
    
    var countDown: HFSwiftCountDown?
    
    var currentState: Int = 1 {
        
        didSet{
            if currentState == 1 { //注销提示页面
                
                self.title = "注销账号"
                accountValidView.isHidden = true
                
            }else if currentState == 2 { //账号验证
                
                self.title = "账号验证"
                self.accountValidView.isHidden = false
                self.accountValidView.validType = .account
                
            }else if currentState == 3 { //是否进行了实名认证
                
                self.title = "身份验证"
                self.accountValidView.isHidden = false
                self.accountValidView.validType = .account
                
            }else{
                
            }
        }
        willSet{
            
        }
    }
    
    var userDeleteCheck: HFUserCheckDelete?

    var myViewModel = HFSetupViewModel()
    var faceModel = HFIdentityAuthViewModel()

    var haveKingd: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注销账号"
        self.view.backgroundColor = .white
        self.view.addSubview(warningView)
        self.view.addSubview(accountValidView)
    }
    
    // 实名认证
    func faceDetect() -> Void {
        HFFaceManager.shared.startFaceDetect(currentVC: self) { (image) in
            if let img = image {
                ShowHUD.showHUDLoading()
                self.faceModel.faceVerifyCancel(verifyType: 1, image: img) {
                    ShowHUD.hiddenHUDLoading()
                    
                    self.submitDestruction()
                } _: { (error) in
                    ShowHUD.hiddenHUDLoading()
                }
            }
        } _: { (error) in
        }
    }
    
    // 提交注销申请
    func submitDestruction() -> Void {
        self.showCustomAlert("", "确认注销？", "取消", "确定", {
            
        }) {
            self.myViewModel.userCommitDestruction {
                HFUserInformation.sync(parameters: ["ucDestruction":1])
                let vc = HFCancelAccountResultController()
                vc.cancelState = .reviewIng // 提交成功  状态为审核中
                self.navigationController?.pushViewController(vc, animated: true)
            } _: {
                ShowHUD.showHUD(withInfo: "提交失败")
            }
        }
    }
    
    func showUncleared() -> Void {
        let withdrawMoney: Int = 0 // 待提现金额
        let underwayMoney: Int = 0 // 在途金额
        let withdrawMoneyStr: String = String(format: "%.2f", Double(withdrawMoney)*0.01)
        let underwayMoneyStr: String = String(format: "%.2f", Double(underwayMoney)*0.01)
        var contentText: String = "您还有\n"
        // 获取待提现金额字符串位置
        let withdrawRange: NSRange = NSRange(location: contentText.length(), length: withdrawMoneyStr.length())
        contentText = contentText + withdrawMoneyStr + " 元可提现\n"
        // 获取在途金额字符串位置
        let underwayRange: NSRange = NSRange(location: contentText.length(), length: underwayMoneyStr.length())
        contentText = contentText + underwayMoneyStr + "元在途\n若不结清坚持注销视为自动放弃"
        
        let attrString = NSMutableAttributedString(string: contentText)
        attrString.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("FF4D00"), range:withdrawRange)
        attrString.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("FF4D00"), range:underwayRange)
        attrString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17), range: withdrawRange)
        attrString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17), range: underwayRange)
        //通过富文本来设置行间距
        let paraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paraph.lineSpacing = 8
        paraph.alignment = .center;
        let attributes = [NSAttributedString.Key.paragraphStyle: paraph]
        attrString.addAttributes(attributes, range: NSMakeRange(0, contentText.length()))
        
        let richTextAleat = HFRichTextAleatViewController.init()
        richTextAleat.modalPresentationStyle = .overFullScreen
        richTextAleat.titleText = "温馨提示"
        richTextAleat.richText = attrString
        richTextAleat.item1Title = "去结算"
        richTextAleat.item2Title = "坚持注销"
        richTextAleat.selectItem1 = {
            print("点击去结算")
            richTextAleat.dismiss(animated: false, completion: {})
        }
        richTextAleat.selectItem2 = {
            print("点击去坚持注销")
            richTextAleat.dismiss(animated: false, completion: {})
        }
        richTextAleat.cancel = {
            print("点击取消")
        }
        self.present(richTextAleat, animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let y = self.navigationController!.navigationBar.isTranslucent ? kNavigatioHeight : 0
        let height = S_SCREEN_HEIGHT - kNavigatioHeight - kSafeBottom
        warningView.frame = CGRect(x: 0, y: y, width: S_SCREEN_WIDTH, height: height)
        accountValidView.frame = CGRect(x: 0, y: y, width: S_SCREEN_WIDTH, height: height)
    }
    
}
