//
//  HFHomePageHomeController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/13.
//  Copyright © 2020 huifan. All rights reserved.
//家长端首页

import UIKit

class HFHomePageHomeController: HFNewBaseViewController,HFScanInvitationCodeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var babyJoinViewModel: HFBabyJoinViewModel?
    
    let slideInTransitioningDelegate = HFSlideInPresentationManager()
    
    let viewModel = HFHomeViewModel.shared
    
    lazy var tableHead: HFHomePageTableHeaderCell = {
        
        let tableHead = Bundle.main.loadNibNamed("HFHomePageTableHeaderCell", owner: self, options: nil)?.last as! HFHomePageTableHeaderCell
        tableHead.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 363)
        tableHead.msgCenterClosure = {
            let vc = HFMessageCenterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableHead.scanClosure = {
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
        tableHead.moreClosure = { [self] in
            self.moreAction()
        }
        tableHead.clickBaby = {
            if HFBabyViewModel.shared.currentBaby == nil {
                let vc = HFAddBabyViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
            }
        }
        
        return tableHead
    }()
        
    lazy var footer: UIView = {
        let label = UILabel.init(frame:CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 44))
        label.text = "让每一个普通家庭的儿童都有获得高端教育的机会！"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        getUnReadNum()
        syncSystemTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
//        if !HFUserInformation.isLogin() {
//            self.presentLoginVc()
//        }
        HFPopupManager.shared.enterHomePage(viewController: self)
        updateMsgBadge()
        syncCloudInfo()
        syncBaby()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    /// 跳转到登录界面
    /// - Returns: 无
//    func presentLoginVc() -> Void {
//
//        let vc = HFNewLoginViewController()
//        let nv = HFNewBaseNavigationController(rootViewController: vc)
//        nv.modalPresentationStyle = .overFullScreen
//        self.present(nv, animated: true, completion: {})
//    }
    
    private func config() {
        self.tableView.tableHeaderView = self.tableHead
        self.tableHead.clickItem = { index in
            
//            let vc = HFBabyEntryTableViewController()
//            self.navigationController?.pushViewController(vc, animated: true)

            switch index {
            case 101://云家园

                print("HFCloudHomeMainController")
                let cloudHomeMain = HFCloudHomeMainController()
                self.navigationController?.pushViewController(cloudHomeMain, animated: true)

                print("self.tableView.tableHeaderView = self.tableHead")
            case 102:

                print("self.tableView.tableHeaderView = self.tableHead")
            default:
                print("HFCloudHomeMainController")//一日流程
                let vc = HFOnedayFlowArrangementController()
                self.navigationController?.pushViewController(vc, animated: true)
//                let cloudHomeMain = HFCloudHomeMainController()
//                self.navigationController?.pushViewController(cloudHomeMain, animated: true)
            }
        }
        self.tableView.register(byIdentifiers: ["HFInteractiveCampsCell", "HFInteractiveCampsEmptyCell", "HFHomePageSectionHeaderCell"])
        self.tableView.reloadData()
        tableView.tableFooterView = footer
    }
    
    /// 请求未读消息数量
    /// - Returns: 无
    func getUnReadNum() -> Void {
        MsgNumberViewModel.shared.unReadNum({
            self.updateMsgBadge()
        }, {
            self.updateMsgBadge()
        })
    }
    
    /// 同步宝宝数据
    func syncBaby() -> Void {
        HFBabyViewModel.syncChilds {
            print("同步宝宝数据成功")
            self.tableHead.babyModel = HFBabyViewModel.shared.currentBaby
            self.syncUserInfo()
        } failClosure: {
            print("同步宝宝数据失败")
            self.syncUserInfo()
        }
    }
    
    /// 同步用户信息
    func syncUserInfo() -> Void {
        HFUserInformation.sync {
            
        } _: { (error) in
            
        }
    }
    
    /// 更新未读消息数量
    /// - Returns: 无
    func updateMsgBadge() -> Void {
        
        if (MsgNumberViewModel.shared.unReadNum) > 0  {
            self.tableHead.numlabel.isHidden = false
            self.tableHead.numlabel.text = "\(MsgNumberViewModel.shared.unReadNum)"
        }else{
            self.tableHead.numlabel.isHidden = true
        }
    }
    
    func syncCloudInfo() -> Void {
        viewModel.getHomeDate {
            self.tableView.reloadData()
        } _: {
        }
    }
    
    func syncSystemTime() -> Void {
        Date.syncSystemTime {
            print("同步系统时间成功")
        } _: {
            print("同步系统时间失败")
        }
    }
    
    func moreAction() -> Void {
        let vc = HFBabyListViewController()
        
        slideInTransitioningDelegate.direction = .left
        vc.transitioningDelegate = slideInTransitioningDelegate
        vc.modalPresentationStyle = .custom
        vc.addBabyClosure = {
            let vc = HFAddBabyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        vc.joinClosure = { babyModel in
            let vc = HFBabyScanJoinViewController()
            vc.viewModel.waitBabyModel = babyModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        vc.selectClosure = { babyModel in
            self.tableHead.babyModel = babyModel
            HFPopupManager.shared.loadCurrentBabyInviteStatus()
        }
        self.present(vc, animated: true, completion: {})
    }
    
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        
        print("scanResult:\(scanResult)")
        
        if error != nil && !error!.isEmptyStr() {
            self.showAlertCenterMessage(error!, "确定", {})
            return
        }
        
        if scanResult.strScanned == "" {
            self.showAlertCenterMessage("二维码无效", "确定", {})
            return
        }
        
        let parameters = scanResult.strScanned?.urlParameters
        let invitationCode = parameters?["invitationCode"]
        if invitationCode == nil {
            self.showAlertCenterMessage("二维码无效", "确定", {})
            return
        }
        
        ShowHUD.showHUDLoading()
        babyJoinViewModel = HFBabyJoinViewModel()
        babyJoinViewModel?.waitBabyModel = HFBabyViewModel.shared.currentBaby
        babyJoinViewModel?.invitationCode = invitationCode as! String
        babyJoinViewModel?.getInvitationInfo {
            ShowHUD.hiddenHUDLoading()
            self.gotoJoin()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func gotoJoin() -> Void {
        let vc = HFBabyJoinViewController()
        vc.viewModel = babyJoinViewModel!
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HFHomePageHomeController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let model = viewModel.homeModel, model.todayKindergartenInteractionList.count != 0 {
                return model.todayKindergartenInteractionList.count
            }
            return 1
        }else{
            if let model = viewModel.homeModel, model.KindergartenInteractionList.count != 0 {
                return model.KindergartenInteractionList.count
            }
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let model = viewModel.homeModel, model.todayKindergartenInteractionList.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsCell") as! HFInteractiveCampsCell
                cell.model = model.todayKindergartenInteractionList[indexPath.row]
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsEmptyCell") as! HFInteractiveCampsEmptyCell
            return cell
        }else{
            if let model = viewModel.homeModel, model.KindergartenInteractionList.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsCell") as! HFInteractiveCampsCell
                cell.model = model.KindergartenInteractionList[indexPath.row]
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsEmptyCell") as! HFInteractiveCampsEmptyCell
            return cell
        }
    }
}


extension HFHomePageHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if let model = viewModel.homeModel, model.todayKindergartenInteractionList.count != 0 {
                return 147
            }
            return 158
        }else{
            if let model = viewModel.homeModel, model.KindergartenInteractionList.count != 0 {
                return 147
            }
            return 158
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = HFInteractCourseDetailController()
        self.navigationController?.pushViewController(VC, animated: true)
        
//        switch indexPath.row {
//        case 0:
//            let personData = HFPersonalDataController()
//            self.navigationController?.pushViewController(personData, animated: true)
//        case 1:
//            let myClass = HFMyClassController()
//            self.navigationController?.pushViewController(myClass, animated: true)
//        case 2:
//            let personData = HFPersonalDataController()
//            self.navigationController?.pushViewController(personData, animated: true)
//        case 3:
//            let personData = HFBabyArchivesController()
//            self.navigationController?.pushViewController(personData, animated: true)
//        default:
//            let teacherArchiver = HFTeacherArchivesController()
//            self.navigationController?.pushViewController(teacherArchiver, animated: true)
//        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 53
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFHomePageSectionHeaderCell") as! HFHomePageSectionHeaderCell
        switch section {
        case 0:
            sectionHead.tipLabel.text = "今日互动活动"
        default:
            sectionHead.tipLabel.text = "推荐互动活动"
        }
        return sectionHead
    }
    
    
    
}

