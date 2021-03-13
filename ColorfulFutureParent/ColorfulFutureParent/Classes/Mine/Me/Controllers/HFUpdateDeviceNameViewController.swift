//
//  HFUpdateDeviceNameViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/25.
//  Copyright © 2020 huifan. All rights reserved.
//
// 修改设备名称

import UIKit

class HFUpdateDeviceNameViewController: HFNewBaseViewController {

    var viewModel = HFSetupViewModel()
    
    @IBOutlet weak var inputTF: UITextField!
    
    lazy var rightBarBtn: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(.hexColor(0x333333), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(rightBarBtnClick(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置设备名称"
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.inputTF.jk_maxLength = 20
        self.inputTF.text = viewModel.loginDeviceModel?.ullDeviceName
    }

    @objc func rightBarBtnClick(_ btn: UIButton) -> Void {
        let deviceName = self.inputTF.text!
        if deviceName.isEmptyStr() {
            HFAlert.show(withMsg: "请输入设备名", in: self, alertStatus: AlertStatusError)
            return
        }
        view.endEditing(true)
        viewModel.deviceName = deviceName
        ShowHUD.showHUDLoading()
        viewModel.updateLoginDeviceName {
            ShowHUD.hiddenHUDLoading()
            HFAlert.show(withMsg: "修改成功", in: self, alertStatus: AlertStatusSuccfess) {
                self.viewModel.loginDeviceModel?.ullDeviceName = deviceName
                self.navigationController?.popViewController(animated: true)
            }
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
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
