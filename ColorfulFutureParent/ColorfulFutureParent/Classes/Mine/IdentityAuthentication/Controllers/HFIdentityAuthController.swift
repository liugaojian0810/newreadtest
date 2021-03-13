//
//  HFIdentityAuthController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/3.
//  Copyright © 2020 huifan. All rights reserved.
//  身份认证 企业认证

import UIKit

class HFIdentityAuthController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var agreeAttriLabel: HFAttributeTapLabel!
    
    var idCardFrotModel: HFIDCardInfoDetial?
    var idCardBackModel: HFIDCardInfoDetial?
    
    lazy var tableHead: HFIdenAuthHeadView = {
        let tableHead = Bundle.main.loadNibNamed("HFIdenAuthHeadView", owner: self, options: nil)?.last as! HFIdenAuthHeadView
        tableHead.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 245)
        tableHead.idCardFrontClosure = {
            HFOCRManager.shared.hf_localIdcardOCROnlineFront(currentVC: self) { (model, image) in
                self.myViewModel.grPlacehoulders[0] = model!.idName
                self.myViewModel.grPlacehoulders[1] = model!.idNumber
                self.myViewModel.usrEditMsgs[0] = model!.idName
                self.myViewModel.usrEditMsgs[1] = model!.idNumber
                self.idCardFrotModel = model
                tableHead.positiveView.layer.contents = image?.cgImage
                self.msgVerify()
                self.tableView.reloadData()
             } _: { (error) in

            }
        }
        tableHead.idCardBackClosure = {
            HFOCRManager.shared.hf_localIdcardOCROnlineBack(currentVC: self) { (model, image) in
                self.myViewModel.grPlacehoulders[2] = model!.signOrganization
                self.myViewModel.grPlacehoulders[3] = "\(model!.signDate)-\(model!.invalidDate)"
                self.myViewModel.usrEditMsgs[2] = model!.signOrganization
                self.myViewModel.usrEditMsgs[3] = "\(model!.signDate)-\(model!.invalidDate)"
                self.idCardBackModel = model
                tableHead.reverseView.layer.contents = image?.cgImage
                self.msgVerify()
                self.tableView.reloadData()
            } _: { (error) in
                
            }
        }
        return tableHead
    }()
    
    var myViewModel = HFIdentityAuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    
    func config() -> Void {
        
        if myViewModel.ideAuthType == .personal {
            self.title = "身份认证"
            self.continueBtn.setTitle("下一步，去刷脸", for: .normal)
        }else{
            self.continueBtn.setTitle("下一步，法人认证", for: .normal)
            self.title = "企业认证"
        }
        self.continueBtn.alpha = 0.5
        self.continueBtn.isUserInteractionEnabled = false
        
        self.agreeAttriLabel.tapBlock = { string in
            if (string == "《个人认证协议》") {
                print("《个人认证协议》")
            }
        };
        let str = "勾选即代表同意《个人认证协议》";
        
        let myAttribute = [NSAttributedString.Key.foregroundColor: HFLoginRegistConfig.agreementColor]
        let model1 = HFAttributeModel.init();
        model1.range = NSRange.init(location: 7, length: 8)
        model1.string = "《个人认证协议》";
        model1.attributeDic = myAttribute
        //label内容赋值
        self.agreeAttriLabel.setText(str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xC0C0C0),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11)], tapStringArray: [model1])
        
        self.tableView.register(byIdentifiers: ["HFManagerClassTableViewCell"])
        self.tableView.tableHeaderView = tableHead
        tableHead.type = .personal
        self.tableView.reloadData()
    }
    
    @IBAction func refrashBFace(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.agreeBtn.isSelected == false {
            AlertTool.showBottom(withText: "请先阅读并勾选《个人认证协议》")
            return
        }
        if NSString.jk_accurateVerifyIDCardNumber(self.myViewModel.usrEditMsgs[1]) {
            HFFaceManager.shared.startFaceDetect(currentVC: self) { (image) in
                if let img = image, let fm = self.idCardFrotModel, let bm = self.idCardBackModel {
                    ShowHUD.showHUDLoading()
//                    self.myViewModel.faceVerify(name: fm.idName, idCard: fm.idNumber , uaiAuthority: bm.signOrganization,signDate: bm.signDate, uaiValidity: bm.invalidDate, image: img, checktype: .personal) {
//                        ShowHUD.hiddenHUDLoading()
//                        let vc = HFIdentityAuthResultController()
//                        vc.state = 1
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    } _: { (error) in
//                        ShowHUD.hiddenHUDLoading()
//                        let vc = HFIdentityAuthResultController()
//                        vc.state = 0
//                        vc.reTryClosure = {
//                            self.refrashBFace(self.continueBtn)
//                        }
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
                    let str = self.myViewModel.usrEditMsgs[3].replacingOccurrences(of: "-", with: "")
                    var startSige = ""
                    var endSige = ""
                    if str.contains("至") {
                        let arr = str.components(separatedBy: "至")
                        if arr.count >= 2 {
                            startSige = arr.first ?? ""
                            endSige = arr[1]
                        }else{
                            startSige = bm.signDate
                            endSige = bm.invalidDate
                        }
                    }else{
                        startSige = bm.signDate
                        endSige = bm.invalidDate
                    }

                    self.myViewModel.faceVerify(name: self.myViewModel.usrEditMsgs[0], idCard: self.myViewModel.usrEditMsgs[1], uaiAuthority: self.myViewModel.usrEditMsgs[2],signDate: startSige, uaiValidity: endSige, image: img, checktype: .personal) {
                        ShowHUD.hiddenHUDLoading()
                        let vc = HFIdentityAuthResultController()
                        vc.state = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                        HFUserInformation.userInfo()!.usrAuthStatus = 1
                    } _: { (error) in
                        ShowHUD.hiddenHUDLoading()
                        let vc = HFIdentityAuthResultController()
                        vc.state = 0
                        vc.reTryClosure = {
                            self.refrashBFace(self.continueBtn)
                        }
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } _: { (error) in }
        }else{
            AlertTool.showBottom(withText: "请输入有效身份证号")
        }
    }
    
    /// 信息校验
    func msgVerify() {
        if (self.myViewModel.usrEditMsgs[0].length() > 0) && self.myViewModel.usrEditMsgs[1].length() > 0 && self.myViewModel.usrEditMsgs[2].length() > 0 && self.myViewModel.usrEditMsgs[3].length() > 0 {
            self.continueBtn.alpha = 1
            self.continueBtn.isUserInteractionEnabled = true
        }else{
            self.continueBtn.alpha = 0.5
            self.continueBtn.isUserInteractionEnabled = false
        }
    }
    
    
    @IBAction func sender(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
}

extension HFIdentityAuthController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if myViewModel.ideAuthType == .personal {
            return myViewModel.grTips.count
        }else{
            return myViewModel.kingderTips.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFManagerClassTableViewCell") as! HFManagerClassTableViewCell
        if myViewModel.ideAuthType == .personal {
            cell.name.text = self.myViewModel.grTips[indexPath.row]
            cell.body.text = self.myViewModel.grPlacehoulders[indexPath.row]
            cell.body.placeholder = "请输入或拍照识别" + self.myViewModel.grTips[indexPath.row]
            if indexPath.row == 3 {
                let str = self.myViewModel.usrEditMsgs[indexPath.row]
                if str.length() > 0 {
                    let arr = str.components(separatedBy: "-")
                    let totalStr = (arr.first?.timeStrTranslate() ?? "") + "至" + (arr.last?.timeStrTranslate() ?? "")
                    cell.body.text = totalStr
                }
            }
            cell.editClosure = { text in
                self.myViewModel.usrEditMsgs[indexPath.row] = text
                self.msgVerify()
            }
        }else{
            cell.name.text = self.myViewModel.kingderTips[indexPath.row]
        }
        cell.contentView.backgroundColor = .white
//        cell.body.isEnabled = false
        cell.rightIconImage.isHidden = true
        cell.bodyRightNum.constant = 16
        return cell
    }
}


extension HFIdentityAuthController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}



