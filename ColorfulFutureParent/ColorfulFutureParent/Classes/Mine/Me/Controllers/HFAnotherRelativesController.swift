//
//  HFAnotherRelativesController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/7.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFAnotherRelativesController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var addBtn: HFCommButton = {
        let addBtn = Bundle.main.loadNibNamed("HFCommButton", owner: nil, options: nil)?.last as! HFCommButton
        addBtn.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 112)
        addBtn.clickClosure = {
            self.addRelations()
        }
        return addBtn
    }()
    
    var myViewModel = HFMineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getReleations()
    }
    
    func config()  {
        self.title = "其他亲属"
        self.tableView.tableFooterView = self.addBtn
        self.tableView.register(byIdentifiers: ["HFAnotherRelativesCell"])
//        self.tableView.reloadData()
    }
    
    /// 获取其它亲属信息
    func getReleations() {
        /// 下拉加载
        self.tableView.headerRefreshingBlock { (page) in
            self.myViewModel.getAnotherRelations(page) {
                self.tableView.mj_header?.endRefreshing()
                Asyncs.async({
                    
                }) { self.tableView.reloadData() }
            } _: { self.tableView.mj_header?.endRefreshing() }
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    /// 添加家庭亲属
    func addRelations()  {
        
        let add = HFAddAnotherRelativesController()
        self.navigationController?.pushViewController(add, animated: true)
    }
}

// MARK: UITableViewDataSource - UITableViewDelegate

extension HFAnotherRelativesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.myViewModel.anotherRelations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFAnotherRelativesCell", for: indexPath) as! HFAnotherRelativesCell
        cell.parent = self.myViewModel.anotherRelations[indexPath.row]
        return cell
    }
}

extension HFAnotherRelativesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}
