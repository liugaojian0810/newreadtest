//
//  HFAccountSecurityController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/19.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFAccountSecurityController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myViewModel = HFSetupViewModel()
    
    ///年级切换按钮
    lazy var rightBarBtn: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "mine_more"), for: .normal)
        btn.setTitleColor(.colorWithHexString("333333"), for: .normal)
        btn.addTarget(self, action: #selector(rightBarBtnClick(_:)), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: btn)
        return rightBarBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loginAuthorSuccess(_:)), name: NSNotification.Name(rawValue: LoginAuthorSuccessNotifacation), object: nil)
        
        config()
        usrInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.reloadData()
    }
    
    func config() -> Void {
        self.title = "账号与安全"
        
        self.tableView.separatorColor = UIColor.hexColor(0xEDEDED)
        self.tableView.backgroundColor = UIColor.hexColor(0xF6F6F6)
        self.tableView.register(byIdentifiers: ["HFSemesterEditCell"])
        self.tableView.reloadData()
        
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    func usrInfo() -> Void {
        myViewModel.accountSecuInfo({
            
            Asyncs.async({
                
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.reloadData()
            }
        }) {
            
        }
    }
    
    @objc func loginAuthorSuccess(_ notif: Notification) -> Void {
        let openID = (notif.object) as! String
        self.myViewModel.ucWxOpenid = openID
        
    }
    
    @objc func rightBarBtnClick(_ btn: UIButton) -> Void {
        
        let point = btn.convert(btn.imageView!.frame, to: navigationController?.view)
        let trianglePoint
            = CGPoint.init(x: point.origin.x + point.size.width * 0.5, y: S_NAV_HEIGHT - 8)
        let model = HFPopViewModel.init(title: "注销账号")!
        PopMenuShared.showPopMenuSelecteWithFrameWidth(width: 84, height: 160, point: trianglePoint, dataArr: [model]) { (index) in
            ///点击回调
            switch index {
            case 0:
                let vc = HFCancellatAccountController()
                self.navigationController?.pushViewController(vc, animated: true)
                print("您点击了注销账号按钮")
            default:
                break
            }
        }
    }
}



extension HFAccountSecurityController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        myViewModel.tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSemesterEditCell") as! HFSemesterEditCell
        cell.tipLabel.text = myViewModel.tips[indexPath.row]
        cell.arrowImgView.isHidden = false
        cell.arrowRightConstrint.constant = 16
        cell.textField.font = SystemFont(15)
        cell.textField.isEnabled = false
        cell.textField.textColor = .colorWithHexString("C0C0C010")
        cell.textField.text = myViewModel.contents[indexPath.row]
        cell.tipLabel.textColor = .colorWithHexString("333333")
        cell.textField.placeholder = ""
        switch indexPath.row {
        case 0:
            if self.myViewModel.secur != nil {
                cell.textField.text = self.myViewModel.secur?.usrName
            }else{
                cell.textField.text = HFUserInformation.userInfo()?.usrName
            }
        case 1:
            cell.textField.text = HFUserInformation.userInfo()?.usrNo
            cell.arrowRightConstrint.constant = 0
            cell.arrowImgView.isHidden = true
        case 2:
//            if self.myViewModel.secur != nil {
//                cell.textField.text = self.myViewModel.secur?.usrPhone
//            }else{
//                cell.textField.text = HFUserInformation.userInfo()?.usrPhone
//            }
            if self.myViewModel.secur != nil {
                let str = NSString.getSecrectMobileString(self.myViewModel.secur?.usrPhone)
                cell.textField.text = str
            }else{
                let str = NSString.getSecrectMobileString(HFUserInformation.userInfo()?.usrPhone)
                cell.textField.text = str
            }
        case 3:
            cell.textField.text = self.myViewModel.securLevel
        case 4:
            
            if self.myViewModel.binding == true {
                cell.textField.text = "已绑定"
//                self.showCustomAlert("", "确定要解除绑定吗？", "取消", "确定", {
//                }) {
//                    self.myViewModel.bindingWeChat(false, {
//                        self.tableView.reloadData()
//                        HFAlert.show(withMsg: "解绑成功", in: self, alertStatus: AlertStatusSuccfess)
//                    }) {}
//                }
            }else{
                cell.textField.text = "未绑定"
                /*
                 scope - 必须，应用授权作用域，如获取用户个人信息则填写snsapi_userinfo
                 state - 非必须，用于保持请求和回调的状态，授权请求后原样带回给第三方。该参数可用于防止csrf攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数加session进行校验
                 appid - 必须，应用唯一标识，在微信开放平台提交应用审核通过后获得
                 */
//                let req = SendAuthReq()
//                req.scope = "snsapi_userinfo"
//                req.state = "com.huifan.ColorfulFuturePrincipal"
//                req.openID = WeChat_Key
//                WXApi.send(req) { (success) in
//                    print("success  成功 成功")
//                }
            }
        default:
            cell.textField.placeholder = ""
        }
        //        if indexPath.row == 4 {
        //            if self.myViewModel.binding == true {
        //                cell.textField.text = "未绑定"
        //            }else{
        //                cell.textField.text = "已绑定"
        //            }
        //        }
        //        if indexPath.row == 2 {
        //            cell.textField.placeholder = ""
        //        }
        return cell
    }
}


extension HFAccountSecurityController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.getSectionHead(with: 12, .colorWithHexString("F6F6F6"))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            // usrUsrNameChange 是否允许更用户名 0否 1是
//            if HFAccountRelevantManager.shared.employeeInfo?.usrUsrNameChange == 1 {
//                let vc = HFUpdateUserNameController()
//                vc.updateSuccessClosure = { usrName in
//                    HFUserInformation.userInfo()?.usrName = usrName
//                    self.tableView.reloadData()
//                }
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            let vc = HFUpdateUserNameController()
            if myViewModel.secur?.usrUsrNameChange == 1 {
                vc.canEditUsrName = true
            }else{
                vc.canEditUsrName = false
            }
            vc.updateSuccessClosure = { usrName in
                self.myViewModel.secur?.usrName = usrName
                HFUserInformation.userInfo()?.usrName = usrName
                self.myViewModel.secur?.usrUsrNameChange = 0
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            
        }else if indexPath.row == 2 {
            
            let vc = HFChangePhoneNumController()
            vc.completeBlock = {
                self.showAlertCenterMessage("更换成功，请设置新密码", "确定") {
                    let vc = HFAccountSetPasswordController()
                    vc.original = false
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 3 {
            
            let vc = HFAccountSetPasswordController()
            vc.type = .original
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 4 {
            if self.myViewModel.binding == true {
                self.showCustomAlert("", "确定要解除绑定吗？", "取消", "确定", {
                }) {
                    self.myViewModel.bindingWeChat(false, {
                        self.tableView.reloadData()
                        HFAlert.show(withMsg: "解绑成功", in: self, alertStatus: AlertStatusSuccfess)
                    }) {}
                }
            }else{
                self.myViewModel.weChatBindStateVerify({
                    
                    self.bindingWeChat()
                }) {}
            }
        }else{
            
            let vc = HFRecentLoginRecordController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func bindingWeChat() -> Void {
        
        self.myViewModel.weChatBindStateVerify({
            if self.myViewModel.haveBinded == true {
                self.showAlertCenterMessage("当前微信已绑定其它账号\n请解除后操作", "知道了") {
                    
                }
            }else{
                self.myViewModel.bindingWeChat(true, {
                    self.tableView.reloadData()
                    HFAlert.show(withMsg: "微信绑定成功", in: self, alertStatus: AlertStatusSuccfess)
                }) {}
            }
        }) {}
        
    }
    
}


