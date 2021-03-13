//
//  HFAboutUsController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/9/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFAboutUsController: HFNewBaseViewController {
    
    ///版本号显示
    @IBOutlet weak var versionLabel: UILabel!
    ///版本号显示
    @IBOutlet weak var versionLabelOther: UILabel!
    ///版本号
    var locaVersion: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "关于我们"
        locaVersion = Bundle.appVersion()
        self.versionLabel.text = "v" + locaVersion
        self.versionLabelOther.text = "版本号v" + locaVersion
    }
    
    /// 按钮点击
    @IBAction func btnClick(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            self.checkVersion()
        case 102:
            self.userAgreementAndPrivacyPolicy(1)
        case 103:
            self.userAgreementAndPrivacyPolicy(2)
        default:
            self.userAgreementAndPrivacyPolicy(3)
        }
    }
    
    /// 版本更新
    func checkVersion() -> Void {
        let defaults: UserDefaults = UserDefaults.standard
        let dict = defaults.object(forKey: "Update_Msg") as! NSDictionary
        let versionCode = dict["versionCode"]
        let version = (versionCode as! NSString) as String
        let comResult =  locaVersion.compare(version)
        if (comResult == .orderedAscending) {
            let attach: String = dict["attach"]! as! String
            self.showCustomAlert("", "确定更新版本吗？\n", "取消", "确定", {
                
            }) {
                let isExsit = UIApplication.shared.canOpenURL(URL(string: attach)!)
                if isExsit{
                    UIApplication.shared.openURL(URL(string: attach)!)
                }
            }
        }else{
            self.showAlertCenterMessage("已是最新版本", "确认", {})
        }
    }
    
    /// 用户协议或者隐私政策
    func userAgreementAndPrivacyPolicy(_ agreeType: Int) -> Void {
        var agreeId: String = ""
        if agreeType == 1 {
            agreeId = "111"
        }else if agreeType == 2 {
            agreeId = "112"
        }else{
            agreeId = "113"
        }
//        HFWebManager.shared().presentWeb(withId: agreeId, fromVc: self) {
//            
//        }
    }
    
}
