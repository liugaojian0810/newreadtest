//
//  HFMessageListViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMessageListViewController: HFNewBaseViewController {
    
    let viewModel = HFMessageCenterViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var rightBarBtn: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setTitle("全部已读", for: .normal)
        btn.setTitleColor(.hexColor(0x333333), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(rightBarBtnClick(_:)), for: .touchUpInside)
        let rightBarBtn = UIBarButtonItem(customView: btn)
        return rightBarBtn
    }()
    
    var unReadReloadClosure: OptionClosure?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        addRefrash()
    }
    
    private func config() -> Void {
        
        if viewModel.msgListType != .submitRecord {
            navigationItem.rightBarButtonItem = rightBarBtn
            title = viewModel.msgModel?.msgTypeName
        }else{
            title = "发布记录"
        }
        view.backgroundColor = .colorBg()
        tableView.backgroundColor = .colorBg()
        tableView.register(byIdentifiers: ["HFMessageListTableViewCell"])
    }
    
    func addRefrash() -> Void {
        self.tableView.headerRefreshingBlock { [self] (page) in
            getMsgs(page)
        }
        self.tableView.footerRefreshingBlock { [self] (page) in
            getMsgs(page)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func getMsgs(_ page: Int) -> Void {
        self.viewModel.getDatas(page) {
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        } _: {
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func rightBarBtnClick(_ btn: UIButton) -> Void {
        print("全部已读")
        ShowHUD.showHUDLoading()
        self.viewModel.readAll {
            ShowHUD.hiddenHUDLoading()
            self.tableView.mj_header?.beginRefreshing()
        } _: {
            ShowHUD.hiddenHUDLoading()
            self.tableView.mj_header?.beginRefreshing()
        }
    }
}

extension HFMessageListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFMessageListTableViewCell") as! HFMessageListTableViewCell
//        cell.type = viewModel.msgListType
        let model = viewModel.msgs[indexPath.row]
        cell.msg = model
        if viewModel.msgModel?.msgTypeCode == "msg_type_wallet"{
            cell.statusLabel.isHidden = true
        }else{
            cell.statusLabel.isHidden = false
        }
        return cell
    }
}

extension HFMessageListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.getSectionHead(with: 12, .colorWithHexString("f6f6f6"))
    }
    
    // MARK: 删除
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction.init(style: .default, title: "删除") { [self] (action, indexpath) in
            self.viewModel.deleteItems(at: indexPath.row) {
                self.deleteLaterrefrash(indexPath)
            } _: {}
        }
        delete.backgroundColor = UIColor.colorWithHexString("FF844B")
        return [delete]
    }
    
    /// 删除之后刷新列表
    /// - Parameter indexPath: 所以标识
    /// - Returns: 无
    func deleteLaterrefrash(_ indexPath: IndexPath) -> Void {
        viewModel.msgs.remove(at: indexPath.section)
        Asyncs.async({
        }) {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.msgModel?.msgTypeCode == "msg_type_wallet"{ //钱包消息
            let vc = HFMsgWalletViewController()
            vc.messageModel = viewModel.msgs[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = HFMsgDetailViewController()
//            vc.msg = viewModel.msgs[indexPath.row]
            let msg = viewModel.msgs[indexPath.row]
            vc.msg = msg
            if msg.msgReadState == 0 {
                MsgNumberViewModel.shared.unReadNum -= 1
                msg.msgReadState = 1
                if unReadReloadClosure != nil {
                    self.unReadReloadClosure!()
                }
                Asyncs.async({
                    
                }) {
                    self.tableView.reloadData()
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

