//
//  HFBabyScanJoinViewController.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HFBabyScanJoinViewController: HFNewBaseViewController,HFScanInvitationCodeViewControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var midTipLabel: UILabel!
    @IBOutlet weak var minTipLabel: UILabel!
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var inputBgView: UIView!
    @IBOutlet weak var sureBtn: UIButton!
    
    let viewModel = HFBabyJoinViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() -> Void {
        
        self.title = "加入新学校"
        
        view.backgroundColor = .white
        
        sureBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        sureBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        sureBtn.isEnabled = false
        
        titleLabel.font = UIFont.init(name: "ARYuanGB-BD", size: 16)
        midTipLabel.font = UIFont.init(name: "ARYuanGB-MD", size: 13)
        minTipLabel.font = UIFont.init(name: "ARYuanGB-MD", size: 12)
        inputBgView.layer.masksToBounds = true
        inputBgView.layer.cornerRadius = 25
        inputBgView.layer.borderWidth = 0.5
        inputBgView.layer.borderColor = UIColor.hexColor(0xEDEDED).cgColor
        inputTF.jk_maxLength = 20
        inputTF.rx.text.orEmpty.asObservable()
            .subscribe { [weak self] (text) in
                self?.sureBtn.isEnabled = !text.isEmptyStr()
            } onError: { (error) in
            } onCompleted: {
            } onDisposed: {
            }
    }
    
    @IBAction func scanAction(_ sender: UIButton) {
        var style = LBXScanViewStyle()

        style.centerUpOffset = 60
        style.xScanRetangleOffset = 30

        if UIScreen.main.bounds.size.height <= 480 {
            //3.5inch 显示的扫码缩小
            style.centerUpOffset = 40
            style.xScanRetangleOffset = 20
        }

        style.color_NotRecoginitonArea = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.4)

        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner
        style.photoframeLineW = 2.0
        style.photoframeAngleW = 16
        style.photoframeAngleH = 16

        style.isNeedShowRetangle = false

        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
        style.animationImage = UIImage(named: "qrcode_scan_full_net")

        let vc = HFScanInvitationCodeViewController()

        vc.scanStyle = style
        
        vc.scanResultDelegate = self

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        ShowHUD.showHUDLoading()
        viewModel.invitationCode = inputTF.text!
        viewModel.getInvitationInfo {
            ShowHUD.hiddenHUDLoading()
            self.gotoJoin()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func gotoJoin() -> Void {
        let vc = HFBabyJoinViewController()
        vc.viewModel = viewModel
        if viewModel.waitBabyModel == nil {
            viewModel.waitBabyModel = HFBabyViewModel.shared.currentBaby
        }
        vc.successClosure = {
            self.viewModel.waitBabyModel = nil
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        
        print("scanResult:\(scanResult)")
        
        if error != nil && !error!.isEmptyStr() {
            self.showAlertCenterMessage(error!, "确定", {})
            return
        }
        
        if scanResult.strScanned == "" {
            self.showAlertCenterMessage("扫描结果为空", "确定", {})
            return
        }
        
        let parameters = scanResult.strScanned?.urlParameters
        let invitationCode = parameters?["invitationCode"]
        if invitationCode == nil {
            self.showAlertCenterMessage("解析结果为空", "确定", {})
            return
        }
        
        self.inputTF.text = invitationCode as? String
        self.sureBtn.isEnabled = true
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
