//
//  HFCloudHomeMainController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/14.
//  Copyright © 2020 huifan. All rights reserved.
//云家园

import UIKit

class HFCloudHomeMainController: HFNewBaseViewController {
    
    let viewModel = HFHomeViewModel.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var tableHead: HFCloudHomeMainHeadView = {
        let tableHead = Bundle.main.loadNibNamed("HFCloudHomeMainHeadView", owner: self, options: nil)?.last as! HFCloudHomeMainHeadView
        tableHead.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 283)
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
        addRefrashOpera()
    }
    
    private func config() {
        title = "云家园"
        view.backgroundColor = .colorBg()
        tableView.backgroundColor = .colorBg()
        tableView.tableHeaderView = self.tableHead
        tableHead.click = { index in
            switch index {
            case 101:
                let growthCamp = HFGrowthCampListController()
                self.navigationController?.pushViewController(growthCamp, animated: true)
                
            case 102:
                let interactiveCamp = HFInteractiveCampsListController()
                self.navigationController?.pushViewController(interactiveCamp, animated: true)
                
            default:
                print("HFCloudHomeMainController")
                let VC = HFAllInteractiveViewController()
                self.navigationController?.pushViewController(VC, animated: true)
                
            }
        }
        tableView.register(byIdentifiers: ["HFHomePageActivityCell", "HFHomePageSectionHeaderCell","HFInteractiveCampsCell","HFCloudHomeReportsNotifacationView","UITableViewCell"])
        tableView.tableFooterView = footer
        tableView.showNoDataNotice = false
    }
    
    // MARK: 数据请求和刷新操作
    func addRefrashOpera() -> Void {
        self.tableView.headerRefreshingBlock { [weak self] (pageNum) in
            self?.requestData(pageNum)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    private func requestData(_ pageNum: Int) -> Void {
        viewModel.getCloudHomeDate { [weak self] in
            self?.tableView.endRefrash()
            self?.tableView.reloadData()
        } _: { [weak self] in
            self?.tableView.endRefrash()
            self?.tableView.reloadData()
        }
    }
}


extension HFCloudHomeMainController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let model = viewModel.cloudHomeDataSource[section] as? HFCloudHomeItem {
            if (model.data as? String) != nil {
                return 1
            }
            if let dataArr = model.data as? Array<HFInteractiveModel> {
                return dataArr.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let model = viewModel.cloudHomeDataSource[indexPath.section] as? HFCloudHomeItem {
            if let reportTime = model.data as? String {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HFCloudHomeReportsNotifacationView") as! HFCloudHomeReportsNotifacationView
                cell.title1Lab.text = "\(reportTime) 成长营报告"
                cell.title2Lab.text = "\(reportTime) 小任务"
                return cell
            }
            if let dataArr = model.data as? Array<HFInteractiveModel> {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveCampsCell") as! HFInteractiveCampsCell
                cell.model = dataArr[indexPath.row]
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        return cell
    }
}


extension HFCloudHomeMainController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = viewModel.cloudHomeDataSource[indexPath.section] as? HFCloudHomeItem {
            if (model.data as? String) != nil {
                return 94
            }
            if (model.data as? Array<HFInteractiveModel>) != nil {
                return 147
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = viewModel.cloudHomeDataSource[indexPath.section] as? HFCloudHomeItem {
            if (model.data as? String) != nil {
                let growthCamp = HFGrowthCampListController()
                self.navigationController?.pushViewController(growthCamp, animated: true)
            }
            if (model.data as? Array<HFInteractiveModel>) != nil {
                print("点击互动活动")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let model = viewModel.cloudHomeDataSource[section] as? HFCloudHomeItem, !model.title.isEmptyStr(){
            return 53
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cloudHomeDataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let model = viewModel.cloudHomeDataSource[section] as? HFCloudHomeItem, !model.title.isEmptyStr(){
            let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFHomePageSectionHeaderCell") as! HFHomePageSectionHeaderCell
            sectionHead.tipLabel.text = model.title
            return sectionHead
        }
        return nil
    }
}


