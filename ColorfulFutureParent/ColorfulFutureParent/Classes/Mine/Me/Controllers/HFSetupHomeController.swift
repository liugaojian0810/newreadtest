//
//  HFSetupHomeController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/19.
//  Copyright © 2020 huifan. All rights reserved.
//  设置主页

import UIKit

class HFSetupHomeController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var letoutBtn: UIButton!
    
    lazy var myViewModel = HFSetupViewModel()
    var locaVersion: String = Bundle.appVersion()//版本号
    var sizeStr: String = "0.00M"
    var update: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        getVersionInfo()
    }
    
    func config() -> Void {
        self.title = "设置"
        self.sizeStr = self.myViewModel.calcuSpace()
        self.letoutBtn.layer.borderColor = UIColor.colorWithHexString("04BFF7").cgColor
        self.letoutBtn.layer.borderWidth = 1.0
        self.letoutBtn.layer.cornerRadius = 20
        self.letoutBtn.layer.masksToBounds = true
        self.tableView.register(byIdentifiers: ["HFSemesterEditCell"])
        self.tableView.reloadData()
        
    }
    
    func getVersionInfo() -> Void {
        myViewModel.appVersion({
            self.checkVersion()
        }) {
        }
    }
    
    @IBAction func letoutBtn(_ sender: UIButton) {
        print("您点击了退出登录按钮")
        if !HFUserInformation.isLogin() {
            ShowHUD.showHUD(withInfo: "未登录")
            return
        }
        self.showCustomAlert("", "确定退出登录吗？", "取消", "确定", {
            
        }) {
            ShowHUD.showHUDLoading()
            self.myViewModel.logou {
                ShowHUD.hiddenHUDLoading()
                print("退出调用接口成功")
                self.logoutSuccess()
            } _: {
                print("退出调用接口失败")
                ShowHUD.hiddenHUDLoading()
                self.logoutSuccess()
            }
        }
    }
    
    func logoutSuccess() -> Void {
        let hud = ShowHUD.showHUD(withInfo: "退出成功")
        hud?.completionBlock = {
            //            self.navigationController?.popViewController(animated: true)
            //            #define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
            if ((UIDevice.current.systemVersion.float() ?? 0) > 13.0) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HFUserLogoutNotification"), object: nil)
            }else{
                let userDefaluts = UserDefaults.standard
                userDefaluts.set(object: UIDevice.jk_version(), forKey: "version")
                userDefaluts.setValue(false, forKey: "LoginOutTag")
                userDefaluts.synchronize()
                let baseNv = HFNewBaseNavigationController(rootViewController: HFNewLoginViewController())
                baseNv.modalPresentationStyle = .overFullScreen
                UIApplication.shared.keyWindow?.rootViewController = baseNv
                //                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main_Parent", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            }
        }
    }
}

extension HFSetupHomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        myViewModel.tipsAtHome.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        myViewModel.tipsAtHome[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSemesterEditCell") as! HFSemesterEditCell
        let arr = myViewModel.tipsAtHome[indexPath.section]
        cell.tipLabel.text = arr[indexPath.row]
        cell.textField.isHidden = true
        cell.switchBgView.isHidden = true
        cell.textField.isEnabled = false
        cell.topVewMsgTipView.isHidden = true
        cell.arrowImgView.isHidden = false
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                cell.switchBgView.isHidden = false
                cell.switchBtn.isOn = !myViewModel.isCloseNotify
                cell.switchClosure = { isOn in
                    if isOn == 1 {
                        self.notif_switch(true, cell)
                    }else{
                        self.notif_switch(false, cell)
                    }
                }
            }else if indexPath.row == 3 {
                cell.topVewMsgTipView.isHidden = self.update
            }else if indexPath.row == 4 {
                cell.textField.isHidden = false
                cell.textField.text = sizeStr
            }
        }
        return cell
    }
    
    // 推送通知开关
    func notif_switch(_ on: Bool, _ cell: HFSemesterEditCell) -> Void {
        myViewModel.notifySwitch(on, {
        }) {
            cell.switchBtn.isOn = !on
        }
    }
}


extension HFSetupHomeController: UITableViewDelegate {
    
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
        
        if indexPath.section == 0 {
            
            let accountSec = HFAccountSecurityController()
            self.navigationController?.pushViewController(accountSec, animated: true)
        }else{
            if indexPath.row == 0 {
                let feedback = HFFeedBackController()
                self.navigationController?.pushViewController(feedback, animated: true)
            }else if indexPath.row == 1 {
                
            }else if indexPath.row == 2 {
                let aboutUs = HFAboutUsController()
                self.navigationController?.pushViewController(aboutUs, animated: true)
            }else if indexPath.row == 3 {
                if update == true {
                    self.showCustomAlert("", "确定更新版本吗？\n", "取消", "确定", {
                    }) {
                        var url: URL?
                        if self.myViewModel.version?.attachType == 2 {
                            url = URL(string: self.myViewModel.version!.attach)
                        }else{
                            // TODO: App Store下载地址
                            url = URL(string: self.myViewModel.version!.attach)
                        }
                        let isExsit = UIApplication.shared.canOpenURL(url!)
                        if isExsit{
                            UIApplication.shared.openURL(url!)
                        }
                    }
                }else{
                    self.showAlertCenterMessage("当前已是最新版本\n", "知道了") {
                        
                    }
                }
            }else if indexPath.row == 4 {
                clearCache()
            }
        }
    }
    
    /// 版本更新
    func checkVersion() -> Void {
        if let versionCode = self.myViewModel.version?.versionCode {
            let comResult =  locaVersion.compare(versionCode)
            if (comResult == .orderedAscending) {
                update = true
            }else{
                update = false
            }
        }
    }
    
    ///清理缓存
    func clearCache() -> Void {
        self.showCustomAlert("清理缓存", "确定要清理缓存吗？\n", "取消", "确定", {
        }) {
            self.myViewModel.clearCache()
            self.sizeStr = "0.0M"
            self.tableView .reloadData()
        }
    }
    
}


