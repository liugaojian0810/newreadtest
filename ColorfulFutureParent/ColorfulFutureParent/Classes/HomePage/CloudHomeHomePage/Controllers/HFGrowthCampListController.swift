//
//  HFGrowthCampListController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

enum GrowthCampListType {
    case list,task
}

class HFGrowthCampListController: HFNewBaseViewController {
    
    @IBOutlet weak var segView: UIView!
    
    lazy var seg: HFPubSegmentView = {
        let seg = HFPubSegmentView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 44), itemNames: ["成长营报告","小任务"])
        return seg
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    var type: GrowthCampListType = .list
    
    var smallTask = false

    lazy var tips = ["10月13日", "10月13日", "10月13日", "10月13日", "10月13日"]
    
    let myViewModel = HFGrowthCampViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        addRefrash()
    }
    
    private func config() {
        self.title = "成长营"
        self.tableView.register(byIdentifiers: ["HFGrowUpImageTableViewCell", "HFGropUpBodyTableViewCell", "HFHomePageSectionHeaderCell", "HFgropUpTaskTableViewCell"])
        segView.addSubview(seg)
        seg.clickClosure = { index in
            switch index {
            case 0:
                self.type = .list
                self.tableView.reloadData()
            default:
                self.type = .task
                if self.smallTask == false {
                    self.smallTask = true
                    self.tableView.mj_header?.beginRefreshing()
                }else{
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    /// 增加下啦刷新功能
    func addRefrash() {
        self.tableView.headerRefreshingBlock { (page) in
            self.requestData()
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func requestData() {
        if self.type == .list {
            self.requestActivitysData()
        }else{
            self.requestTasksData()
        }
    }
    
    /// 请求教育活动列表
    func requestActivitysData() {
        myViewModel.getGrowUpActivitys {
            Asyncs.async({
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.reloadData()
            }
        } _: {
            Asyncs.async({
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    
    /// 请求小任务列表
    func requestTasksData() {
        myViewModel.getGrowUpTasks {
            Asyncs.async({
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.reloadData()
            }
        } _: {
            Asyncs.async({
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}


extension HFGrowthCampListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .list {
            return self.myViewModel.activitys[section].grownActionList.count
        } else {
            let task = self.myViewModel.tasks[section]
            return task.grownActionTaskList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .list {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFGrowUpImageTableViewCell") as! HFGrowUpImageTableViewCell
            cell.activity = self.myViewModel.activitys[indexPath.section].grownActionList[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFgropUpTaskTableViewCell", for: indexPath) as! HFgropUpTaskTableViewCell
            cell.task = self.myViewModel.tasks[indexPath.section].grownActionTaskList?[indexPath.row]
            return cell
        }
    }
}


extension HFGrowthCampListController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if type == .list {
            return self.myViewModel.activitys.count
        } else {
            return self.myViewModel.tasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == .list {
            return 424
        } else {
            return 393
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 51
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFHomePageSectionHeaderCell") as! HFHomePageSectionHeaderCell
        if type == .list {
            sectionHead.tipLabel.text = self.myViewModel.activitys[section].startDate
        } else {
            sectionHead.tipLabel.text = self.myViewModel.tasks[section].grownActionTaskTime
        }
        sectionHead.lineView.isHidden = true
        sectionHead.lineViewLeading.constant = 4
        return sectionHead
    }
}


