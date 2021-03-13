//
//  HFMineHomeController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMineHomeController: HFNewBaseViewController {

    
    lazy var head: HFMineHomeHeadCell = {
        let head = Bundle.main.loadNibNamed("HFMineHomeHeadCell", owner: nil, options: nil)?.last as! HFMineHomeHeadCell
        head.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 260)
        head.setupClosure = {
            let setup = HFSetupHomeController()
            self.navigationController?.pushViewController(setup, animated: true)
        }
        head.lookInterestsClosure = {
            if (self.myViewModel.userInfo?.mlId.length() ?? 0) > 0 {
                // 查看权益

            }else{
                // 开通会员
                
            }
        }
        head.editClosure = {
            let setup = HFPersonalDataController()
            self.navigationController?.pushViewController(setup, animated: true)
        }
        return head
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorWithHexString("F6F6F6")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var tips = [["其他亲属"], ["我的消息", "我的订单", "我的卡包", "我的互动活动", "我的五彩宝石", "个人认证"]]
    
    var myViewModel = HFMineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
//        getMyInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getMyInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func config() -> Void {
        self.title = "我的"
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
             make.edges.equalToSuperview().inset(UIEdgeInsets(top: kStatusBarHeight,left: 15,bottom: 15,right: 15))
        }
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        self.tableView.tableHeaderView = self.head
        self.tableView.register(byIdentifiers: ["HFComEditCell"])
        self.tableView.reloadData()
    }
    
    @objc func badgeMallBtnClick(_ sender: UIButton) -> Void {
        let badgeMall = HFBadgeMallController()
        self.navigationController?.pushViewController(badgeMall,animated: true)
    }
    
    
    /// 获取我的信息接口
    /// - Returns: 无
    func getMyInfo() -> Void {
        
        myViewModel.getMyInfo {
            Asyncs.async({
                
            }) {
                self.updateInfo()
                self.tableView.reloadData()
            }
        } _: {
            Asyncs.async({
                
            }) {
                self.updateInfo()
                self.tableView.reloadData()
            }
        }
    }
    
    /// 更新显示内容
    /// - Returns: 无
    func updateInfo() -> Void {
        
        self.head.headImg.kf.setImage(with: URL(string: self.myViewModel.userInfo?.headImg ?? ""))
        
        if HFBabyViewModel.shared.currentBaby == nil {
            self.head.babyHeadImage.isHidden = true
        }else{
            self.head.babyHeadImage.isHidden = false
            self.head.babyHeadImage.kf.setImage(with: URL(string: HFBabyViewModel.shared.currentBaby?.headImg ?? ""), placeholder: UIImage.getBabyHead(with: HFBabyViewModel.shared.currentBaby?.ciSex ?? 2), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        self.head.nameLabel.text = self.myViewModel.userInfo?.piRmkName ?? ""
        self.head.phoneLabel.text = self.myViewModel.userInfo?.usrPhone ?? ""
        self.head.cardNameLabel.text = self.myViewModel.userInfo?.mlName ?? ""
        if (self.myViewModel.userInfo?.mlId.length() ?? 0) > 0 {
            self.head.lookInterestsBtn.setTitle("查看权益", for: .normal)
            self.head.lookInterestsBtn.backgroundColor = .colorWithHexString("FFFFFF")
            self.head.lookInterestsBtn.setTitleColor(.colorWithHexString("F88B28"), for: .normal)
        }else{
            self.head.lookInterestsBtn.setTitle("开通会员", for: .normal)
            self.head.lookInterestsBtn.backgroundColor = .colorWithHexString("F88B28")
            self.head.lookInterestsBtn.setTitleColor(.colorWithHexString("FFFFFF"), for: .normal)
        }
    }
}


extension HFMineHomeController {
    
    
}

extension HFMineHomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        tips.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
        cell.tipLabel.text = tips[indexPath.section][indexPath.row]
        cell.numLable.isHidden = true
        if indexPath.section == 0 {
            cell.contentView.setCorner([.topLeft, .topRight,.bottomLeft, .bottomRight], withRadius: 8)
        }else{
            if indexPath.row == 0 {
                cell.contentView.setCorner([.topLeft, .topRight], withRadius: 8)
                let garMa = MsgNumberViewModel.shared.unReadNum
                if garMa > 0 {
                    cell.numLable.isHidden = false
                    cell.numLable.text = "\(MsgNumberViewModel.shared.unReadNum)"
                }else{
                    cell.numLable.isHidden = true
                }
            }else if indexPath.row == self.tips[indexPath.section].count - 1{
                cell.contentView.setCorner([.bottomLeft, .bottomRight], withRadius: 8)
            }else{
                cell.contentView.setCorner([], withRadius: 8)
            }
        }
        return cell
    }
}


extension HFMineHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let anotherRelations = HFAnotherRelativesController()
            self.navigationController?.pushViewController(anotherRelations,animated: true)
        }else{
            switch indexPath.row {
            case 0: // 我的消息
                let personalData = HFMessageCenterViewController()
                self.navigationController?.pushViewController(personalData,animated: true)
            case 1: // 我的订单
                let vc = HFMyOrderViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case 2: // 我的卡包
                let vc = HFMyCardPackageController()
                self.navigationController?.pushViewController(vc, animated: true)
            case 3: // 我的互动活动
                let activitie = HFAllInteractiveViewController()
                self.navigationController?.pushViewController(activitie, animated: true)
            case 4: // 我的五彩宝石
                let gem = HFMyMulticoloredGemsController()
                self.navigationController?.pushViewController(gem, animated: true)
            case 5: // 个人认证
                let idenViewModel = HFIdentityAuthViewModel()
                ShowHUD.showHUDLoading()
                idenViewModel.checkUserFaceAuthentication {
                    ShowHUD.hiddenHUDLoading()
                    if let _ = idenViewModel.identityAuthModel?.usrId {
                        ShowHUD.showHUD(withInfo: "您已经实名认证")
                    } else {
                        let idenAuth = HFIdentityAuthController()
                        self.navigationController?.pushViewController(idenAuth, animated: true)
                    }
                } _: { (error) in
                    ShowHUD.hiddenHUDLoading()
                }
            default:
                print("")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            return self.getSectionHead(with: 10, .colorWithHexString("F6F6F6"))
        }
    }
    
}

