//
//  HFCustomAlertController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import WebKit
import Foundation

@objc (HFCustomAlertType)
enum HFCustomAlertType: Int {
    case typeDefault //默认样式 取消和确定的按钮
    case typeWebNoBottomBtn //协议网页样式 没有底部按钮
    case typeWebBottomBtn //协议网页样式 有按钮
    case typeAcountDestroy //账号注销
    case typeApplyDestroy //申请注销
    case typeAddFamilyMembers //增加家庭成员
    case typeFirstComeInAgree //初次进入app的时候协议弹窗
}

@objcMembers class HFCustomAlertController: UIViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descripLabel: HFAttributeTapLabel!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomBtnHeight: UIButton!
    @IBOutlet weak var actureBtn: UIButton!
    @IBOutlet weak var alertBgView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var topBgView: UIView!
    @IBOutlet weak var agreeNameLabel: UILabel!
    @IBOutlet weak var alertBottomDescripLabel: HFAttributeTapLabel!
    
    
    var acountDestroy: HFAcountDestroy? = nil
    var applyDestroy: HFApplyDestroy? = nil
    var addFamilyMembers: HFAddFamilyMembers? = nil
    
    var webView: WKWebView?
    @objc var titleStr: String = ""
    @objc var descriStr: String = ""
    @objc var urlStr: String = ""
    @objc var bottomBtnStr: String = ""
    var alertType: HFCustomAlertType = .typeDefault
    
    
    typealias AlertClosure = () -> Void
    var actureClosure:AlertClosure?
    var cancelClosure:AlertClosure?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        self.titleLabel.text = titleStr;
        self.topBgView.isHidden = true
        self.alertBottomDescripLabel.isHidden = true

        if self.alertType == .typeDefault { //默认样式： 取消、确认的按钮
            if descriStr.contains("清空不会影响app使用，您要清理吗？") {
                self.descripLabel.textColor = .colorWithHexString("FA9030")
                let att: NSMutableAttributedString = NSMutableAttributedString(string: descriStr)
                att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorWithHexString("FA9030"), range: NSRange(location: 0, length: descriStr.count))
                att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorWithHexString("666666"), range: NSRange(location: 0, length: 7))
                att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorWithHexString("666666"), range: NSRange(location: descriStr.count - 18, length:18 ))
                self.descripLabel.attributedText = att
            }else{
                self.descripLabel.text = descriStr
            }
            self.alertBgView.isHidden = true
        }else{
            switch self.alertType {
                
            case .typeDefault: //默认样式： 取消、确认的按钮
                self.descripLabel.text = descriStr;
                self.alertBgView.isHidden = true
                self.closeBtn.isHidden = true
                
            case .typeWebNoBottomBtn://登录页协议弹窗样式
                self.topBgView.isHidden = false
                self.alertBgView.isHidden = false
                self.bgViewHeight.constant = 267
                var frame = UIApplication.shared.keyWindow!.bounds
                frame.origin.y = 50
                frame.size.height = UIApplication.shared.keyWindow!.bounds.size.height - 50
                self.webView = WKWebView(frame:frame)
                self.view.addSubview(self.webView!)
                self.view .bringSubviewToFront(self.topBgView)
                self.webView?.uiDelegate = self
                self.webView?.navigationDelegate = self
                self.webView?.scrollView.delegate = self
                self.webView?.load(URLRequest(url: URL(string: self.urlStr)!))
                self.closeBtn.isHidden = false
                self.agreeNameLabel.text = self.titleStr;
                
                case .typeWebBottomBtn://协议弹窗底部有按钮
                    self.topBgView.isHidden = true
                    self.alertBgView.isHidden = false
                    self.bgViewHeight.constant = 267
                    let frame = CGRect(x: 0, y: 0, width: 352, height: 160)
                    self.webView = WKWebView(frame:frame)
                    self.alertBgView.addSubview(self.webView!)
                    self.webView?.uiDelegate = self
                    self.webView?.navigationDelegate = self
                    self.webView?.scrollView.delegate = self
                    self.webView?.load(URLRequest(url: URL(string: self.urlStr)!))
                    self.closeBtn.isHidden = false
                    self.agreeNameLabel.text = self.titleStr;
                
            case .typeFirstComeInAgree: //首次进入app的时候 显示的协议弹窗
                self.titleLabel.text = "用户登录协议及隐私政策";
                self.alertBgView.isHidden = false
                self.bgViewHeight.constant = 267
                self.closeBtn.isHidden = false
                self.actureBtn.setTitle(self.bottomBtnStr, for: .normal)
                self.alertBottomDescripLabel.isHidden = false
                self.displayAgreeTipContens()
                
                
            case .typeAcountDestroy: //账号注销
                self.alertBgView.isHidden = false
                self.bgViewHeight.constant = 267
                let acountDestroy = Bundle.main.loadNibNamed("HFAcountDestroy", owner: nil, options: nil)?.last
                self.acountDestroy = (acountDestroy as! HFAcountDestroy)
                self.acountDestroy?.nextClosure = { ()->() in
                    print("self.acountDestroy?.nextClosure")
                    let custom: HFCustomAlertController = HFCustomAlertController.init()
                    custom.titleStr = "申请注销"
                    custom.alertType = .typeApplyDestroy
                    custom.actureClosure = { ()->() in
                        print("custom.actureClosure =")
                    }
                    self.present(custom, animated: false, completion: nil)
                }
                self.alertBgView.addSubview(self.acountDestroy!)
                self.closeBtn.isHidden = false
                self.actureBtn.isHidden = true
                
            case .typeApplyDestroy: //申请注销
                self.alertBgView.isHidden = false
                self.bgViewHeight.constant = 238
                let applyDestroy = Bundle.main.loadNibNamed("HFApplyDestroy", owner: nil, options: nil)?.last
                self.applyDestroy = (applyDestroy as! HFApplyDestroy)
                self.applyDestroy?.nextClosure = { ()->() in
                    print("self.applyDestroy?.nextClosure")
                    self.dismiss(animated: false, completion: nil)
                }
                self.alertBgView.addSubview(self.applyDestroy!)
                self.closeBtn.isHidden = false
                self.actureBtn.isHidden = true
                
            case .typeAddFamilyMembers: //增加家庭成员
                self.alertBgView.isHidden = false
                self.bgViewHeight.constant = 264
                let addFamilyMembers = Bundle.main.loadNibNamed("HFAddFamilyMembers", owner: nil, options: nil)?.last
                self.addFamilyMembers = (addFamilyMembers as! HFAddFamilyMembers)
                self.alertBgView.addSubview(self.addFamilyMembers!)
                self.closeBtn.isHidden = false
                self.actureBtn.isHidden = true
                
            default:
                self.bgViewHeight.constant = 267
                self.alertBgView.isHidden = false
                self.webView = WKWebView(frame: CGRect(x: 15, y: 15, width: 352 - 30, height: 150))
                self.alertBgView.addSubview(self.webView!)
                self.webView?.uiDelegate = self
                self.webView?.navigationDelegate = self
                self.webView?.scrollView.delegate = self
                self.webView?.load(URLRequest(url: URL(string: self.urlStr)!))
                self.closeBtn.isHidden = false
            }
        }
    }
    
    
    func displayAgreeTipContens() {
        let str = "亲爱的用户，为了向您提供优质的服务，在使用柒彩未来平台之前，需要通过点击“同意并使用”已表示您充分悉知。理解并同意本温馨提示以及相关协议的各项规则。\n您可以通过了解《家长用户使用协议》及《家长用户隐私政策》及《平台交易支付服务协议》详细信息，如您同意，请点击“同意并使用”开始我们的服务。"
        self.alertBottomDescripLabel.tapBlock = { str in
            print("str----%@",str)
            if str.elementsEqual("《家长用户使用协议》"){
                HFWebManager.shared().presentWeb(withId: "101", fromVc: self) {
                    
                }
            }else if str.elementsEqual("《家长用户隐私政策》") {
                HFWebManager.shared().presentWeb(withId: "102", fromVc: self) {
                    
                }
            }else{
                HFWebManager.shared().presentWeb(withId: "118", fromVc: self) {
                    
                }
            }
        }
        let model1 = HFAttributeModel()
        model1.string = "《家长用户使用协议》"
        model1.attributeDic = [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("22BDF3")]
        model1.range = NSRange(location: 82, length: 10)
        
        let model2 = HFAttributeModel()
        model2.string = "《家长用户隐私政策》"
        model2.attributeDic = [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("22BDF3")]
        model2.range = NSRange(location: 93, length: 10)
        
        let model3 = HFAttributeModel()
        model3.string = "《平台交易支付服务协议》"
        model3.attributeDic = [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("22BDF3")]
        model3.range = NSRange(location: 104, length: 12)
        
        
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 3
        
        self.alertBottomDescripLabel.setText(str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("666666"),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),NSAttributedString.Key.paragraphStyle:paraph], tapStringArray: [model1,model2,model3])
        
    }
    
    
    @IBAction func cancelButtonClick(_ sender: UIButton) {
        
        if let closure = self.cancelClosure{
            closure()
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func actureButton(_ sender: Any) {
        
        if let closure = self.actureClosure{
            closure()
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        
        if self.alertType == .typeFirstComeInAgree {
            exit(1)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
