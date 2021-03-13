//
//  HFInteractiveCampsListController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractiveCampsListController: HFNewBaseViewController {
    
    let viewModel = HFCloudHomeActivityViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var gemCountLab: UILabel! // 宝石数量
    
    @IBOutlet weak var topBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        addRefrashOpera()
    }
    
    
    private func config() {
        
        self.title = "互动营"
        
        self.tableView.noContentType = .notInteractive
        self.tableView.showNoDataNotice = false
        self.tableView.register(byIdentifiers: ["HFInteractiveCampsCell"])
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 10))
    }
    
    // MARK: 数据请求和刷新操作
    func addRefrashOpera() -> Void {
        
        self.tableView.headerRefreshingBlock { [weak self] (pageNum) in
            self?.requestData(pageNum)
        }
        self.tableView.footerRefreshingBlock { [weak self] (pageNum) in
            self?.requestData(pageNum)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    private func requestData(_ pageNum: Int) -> Void {
        viewModel.interactiveType = .being
        viewModel.loadInteractiveCampList(pageNum: pageNum) { [weak self] in
            Asyncs.async({
                print("互动营列表接口请求完成")
            }) {
                self?.tableView.showNoDataNotice = true
                self?.tableView.endRefresh(byIsDownRefresh: pageNum == 1, isRequestSuccess: true, total: self!.viewModel.interactionTotal, pageSize: 20)
                self?.tableView.reloadData()
            }
        } _: { [weak self] in
            Asyncs.async({
                print("互动营列表接口请求完成")
            }) {
                self?.tableView.showNoDataNotice = true
                self?.tableView.endRefresh(byIsDownRefresh: pageNum == 1, isRequestSuccess: false, total: self!.viewModel.interactionTotal, pageSize: 20)
                self?.tableView.reloadData()
            }
        }
    }
    
    ///充值
    @IBAction func popUp(_ sender: UIButton) {
        
        let vc = HFBuyTypeSelectController()
        let slideInTransitioningDelegate = HFSlideInPresentationManager()
        // 高度为底部宝石面板+活动说明+余额提示+底部安全高度
        slideInTransitioningDelegate.contentHeight = 255 + 66 + 70 + kSafeBottom
        vc.transitioningDelegate = slideInTransitioningDelegate
        vc.modalPresentationStyle = .custom
        vc.buySuccessClosure  = { [weak self] in
            // 支付成功，更新宝石个数
            self?.gemCountLab.text = "10"
        }
        self.present(vc, animated: true, completion: {})
    }
}


extension HFInteractiveCampsListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = viewModel.interactionModels[section]
        return model.kindergartenInteractionResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsCell") as! HFInteractiveCampsCell
        cell.cellInteractiveType = .interactiveCamps
        let model = viewModel.interactionModels[indexPath.section]
        let interactionModel = model.kindergartenInteractionResultList[indexPath.row]
        interactionModel.isCancel = viewModel.interactiveType == .cancel
        cell.model = interactionModel
        cell.makeAppointClosure = { [weak self] in
            // 预约、取消预约
            let model = self!.viewModel.interactionModels[indexPath.section]
            let interactionModel = model.kindergartenInteractionResultList[indexPath.row]
            if interactionModel.isSubscribe {
                self?.cancelSubscribeInteractive(interactiveModel: interactionModel)
            }else{
                self?.subscribeInteractive(interactiveModel: interactionModel)
            }
        }
        return cell
    }
    
    /// 跳转预约互动活动
    func subscribeInteractive(interactiveModel: HFInteractiveModel) -> Void {
        let vc = HFInteractCourseDetailController()
        vc.viewModel.kiiId = interactiveModel.kiiId
        vc.viewModel.detailType = .subscribe
        vc.subscribeSuccessComplete = {
            interactiveModel.isSubscribe = true
            self.tableView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 取消预约活动活动
    func cancelSubscribeInteractive(interactiveModel: HFInteractiveModel) -> Void {
        viewModel.kiiId = interactiveModel.kiiId
        ShowHUD.showHUDLoading()
        viewModel.cancelSubscribeInteractive {
            ShowHUD.hiddenHUDLoading()
            interactiveModel.isSubscribe = false
            self.tableView.reloadData()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
}


extension HFInteractiveCampsListController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.interactionModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        147
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 0.001))
        headerView.backgroundColor = .colorBg()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.interactionModels[indexPath.section]
        let interactionModel = model.kindergartenInteractionResultList[indexPath.row]
        subscribeInteractive(interactiveModel: interactionModel)
    }
    
}


