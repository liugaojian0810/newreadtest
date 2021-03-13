//
//  HFLoginRegistConfig.swift
//  ColorfulFuturePrincipal
//
//  Created by DH Fan on 2021/1/27.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation

class HFLoginRegistConfig {
    // 登录页面标题颜色
    static let loginTitleColor = UIColor.hexColor(0xF5A623)
    // 获取验证码标题颜色
    static let smsGetBtnTitleColor = UIColor.hexColor(0xF5A623)
    // 获取验证码禁用状态标题颜色
    static let smsGetBtnTitleDisableColor = UIColor.hexColor(0xF5A623, alpha: 0.35)
    // 圆形视图背景色
    static let roundBgColor = UIColor.hexColor(0x04BFF7, alpha: 0.25)
    // 注册账户时的标题
    static let registTitle = "家长端账号注册"
    
    // 协议选中状态图片
    static let agreementNormalImage = UIImage.init(named: "Selectionbox_circular_n")
    static let agreementSelectImage = UIImage.init(named: "Selectionbox_circular_s")
    static let agreementColor = UIColor.hexColor(0x04BFF7)
}

extension HFNewLoginViewController {
    func loginSuccess() -> Void {
        
        let userInfo = HFUserInformation.userInfo()
        // 注销状态校验
        if userInfo?.ucDestruction == 1 || userInfo?.ucDestruction == 2 {
            let vc = HFCancelAccountResultController()
            if userInfo?.ucDestruction == 1 {
                vc.cancelState = .through
            }
            if userInfo?.ucDestruction == 2 {
                vc.cancelState = .greaterUndo
            }
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        // 是否需要强制修改密码
        if userInfo?.usrNeedChangePwd == 1 {
            if self.myViewModel.loginType != 2 {
                let vc = HFSetNewPasswordViewController()
                vc.phone = self.phoneNumberText.text!
                navigationController?.pushViewController(vc, animated: true)
                return
            }
        }
        // 资料完整度校验
        if userInfo?.ucFinishInfo == 0 {
            let vc = HFPerfectInformationViewController()
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main_Parent", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        
        //        if self.presentingViewController != nil {
        //            self.dismiss(animated: true, completion: {})
        //        }else{
        //            self.navigationController?.popViewController(animated: true)
        //        }
    }
}
