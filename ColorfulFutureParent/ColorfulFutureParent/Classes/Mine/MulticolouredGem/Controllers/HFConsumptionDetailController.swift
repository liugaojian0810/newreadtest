//
//  HFConsumptionDetailController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFConsumptionDetailController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myViewModel = HFGemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        addRefrash()
    }
    
    func config() {
        self.title = "消费明细"
        self.tableView.register(byIdentifiers: ["HFConsumptionDetailCell"])
    }
    
    func addRefrash() {
        self.tableView.headerRefreshingBlock { (page) in
            self.request(page)
        }
        self.tableView.footerRefreshingBlock { (page) in
            self.request(page)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func request(_ page: Int) {
        self.myViewModel.getConsumptions(page) {
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        } _: {
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
        }
    }
    
}

extension HFConsumptionDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.myViewModel.consumptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFConsumptionDetailCell") as! HFConsumptionDetailCell
        cell.consumption = self.myViewModel.consumptions?[indexPath.row]
        return cell
    }
}


extension HFConsumptionDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.getSectionHead(with: 12, .colorBg())
    }
}

