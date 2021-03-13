//
//  HFMessageCenterViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMessageCenterViewController: HFNewBaseViewController {

    let viewModel = HFMessageCenterViewModel()
    
    @IBOutlet weak var tableView: UITableView!

    lazy var footer: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 120)
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "mine_msg_open"), for: .normal)
        button.addTarget(self, action: #selector(openNoti(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        addRefrash()
    }
    
    private func config() -> Void {
        title = "消息中心"
        view.backgroundColor = .colorBg()
        tableView.tableFooterView = self.footer
        tableView.backgroundColor = .colorBg()
        tableView.register(byIdentifiers: ["HFMessageCenterTableViewCell"])
    }

    func addRefrash() {
        
        self.tableView.headerRefreshingBlock { (page) in
            self.getMsgType()
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func getMsgType() -> Void {
        ShowHUD.hiddenHUDLoading()
        viewModel.getMsgCategorys {
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            ShowHUD.hiddenHUDLoading()
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        } _: {
            ShowHUD.hiddenHUDLoading()
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func openNoti(_ button: UIButton) -> Void {
        
        self.showCustomAlert("", "确认开启消息通知？", "取消", "确定") {
            
        } _: {
            self.viewModel.notifySwitch(true) {
                self.tableView.tableFooterView = self.viewModel.isOpenNotify ? nil: self.footer
            } _: {}
        }
    }
}

extension HFMessageCenterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFMessageCenterTableViewCell") as! HFMessageCenterTableViewCell
        cell.model = viewModel.dataArr[indexPath.row]
        return cell
    }
}

extension HFMessageCenterViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HFMessageListViewController()
        vc.viewModel.msgListType = .msgList
//        vc.viewModel.msgModel = viewModel.dataArr[indexPath.row]
        vc.viewModel.msgModel = viewModel.dataArr[indexPath.row]
        vc.unReadReloadClosure = {
            self.viewModel.dataArr[indexPath.row].noReadCnt -= 1
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

