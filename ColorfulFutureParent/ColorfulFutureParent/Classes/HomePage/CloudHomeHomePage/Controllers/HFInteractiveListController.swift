//
//  HFInteractiveListController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractiveListController: HFNewBaseViewController {
    
    let slideInTransitioningDelegate = HFSlideInPresentationManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HFCloudHomeActivityViewModel()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        addRefrashOpera()
    }
    
    func config() -> Void {
        
        switch viewModel.interactiveType {
        case .being:
            self.title = "预约"
            self.initTimer()
        case .end:
            self.title = "已结束"
        case .cancel:
            self.title = "已取消"
        case .statisticeData:
            self.title = "互动活动"
        default:
            break
        }
        
        self.tableView.showNoDataNotice = false
        self.tableView.register(byIdentifiers: ["HFInteractiveCampsCell", "HFHomePageSectionHeaderCell"])
        
    }
    
    // 初始化定时器
    func initTimer() -> Void {
        // 刷新状态定时器
        timer = Timer.jk_scheduledTimer(withTimeInterval: 1, block: {
            NotificationCenter.default.post(name: NSNotification.Name.init("UpdateInteractiveStatus"), object: nil)
        }, repeats: true) as? Timer
//            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    deinit {
        if timer != nil {
            timer!.invalidate()
        }
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
        viewModel.loadJoinInteractiveList(pageNum: pageNum) { [weak self] in
            Asyncs.async({
                print("我参与的互动营活动列表接口请求完成")
            }) {
                self?.tableView.showNoDataNotice = true
                self?.tableView.endRefresh(byIsDownRefresh: pageNum == 1, isRequestSuccess: true, total: self!.viewModel.interactionTotal, pageSize: 20)
                self?.tableView.reloadData()
            }
        } _: { [weak self] in
            Asyncs.async({
                print("我参与的互动营活动列表接口请求完成")
            }) {
                self?.tableView.showNoDataNotice = true
                self?.tableView.endRefresh(byIsDownRefresh: pageNum == 1, isRequestSuccess: false, total: self!.viewModel.interactionTotal, pageSize: 20)
                self?.tableView.reloadData()
            }
        }
    }
}

extension HFInteractiveListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = viewModel.interactionModels[section]
        return model.kindergartenInteractionResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsCell") as! HFInteractiveCampsCell
        let model = viewModel.interactionModels[indexPath.section]
        let interactionModel = model.kindergartenInteractionResultList[indexPath.row]
        interactionModel.isCancel = viewModel.interactiveType == .cancel
        cell.model = interactionModel
        cell.evaluateClosure = { [weak self] in
            // 查看评价、写评价
            let model = self!.viewModel.interactionModels[indexPath.section]
            let interactionModel = model.kindergartenInteractionResultList[indexPath.row]
            let vc = HFInteractiveEvaluateController()
            vc.viewModel.interactiveEvaluateOperationType = interactionModel.isParentsSendReport == 1 ? .read : .edit
            vc.viewModel.interactiveDetailModel = interactionModel
            vc.viewModel.kisId = interactionModel.kisId
            vc.editComplete = {
                interactionModel.isParentsSendReport = 1
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
            self!.navigationController?.pushViewController(vc, animated: true)
        }
        cell.makeAppointClosure = {
            // 预约、取消预约
        }
        cell.readReportClosure = { [weak self] in
            // 查看报告
            let model = self!.viewModel.interactionModels[indexPath.section]
            let interactiveModel = model.kindergartenInteractionResultList[indexPath.row]
//            let interactBabyModel = interactiveModel.signRecordList[index]
            let vc = HFInteractReportViewController()
//            vc.viewModel.type = .sh
//            vc.viewModel.interactiveModel = interactiveModel
//            vc.viewModel.interactBabyModel = interactBabyModel
            self!.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
}


extension HFInteractiveListController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.interactionModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        147
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        54
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFHomePageSectionHeaderCell") as! HFHomePageSectionHeaderCell
        let model = viewModel.interactionModels[section]
        sectionHead.tipLabel.text = model.startDate.substring(from: 5)
        sectionHead.tipLabel.font = UIFont.systemFont(ofSize: 16)
        sectionHead.tipLabel.textColor = .colorWithHexString("666666")
        sectionHead.lineView.isHidden = true
        sectionHead.lineViewLeading.constant = 4
        return sectionHead
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.interactionModels[indexPath.section]
        let vc = HFInteractCourseDetailController()
        vc.viewModel.detailType = .myInteractive
        vc.viewModel.interactiveDetailModel = model.kindergartenInteractionResultList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

