//
//  HFRecentLoginRecordController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/19.
//  Copyright © 2020 huifan. All rights reserved.
//  登录设备记录

import UIKit

class HFRecentLoginRecordController: HFNewBaseViewController {
    
    var myViewModel = HFSetupViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var footer: UIView = {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 72))
        let footerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: S_SCREEN_WIDTH - 32, height: 72))
        footerLabel.backgroundColor = .colorWithHexString("F6F6F6")
        footerLabel.numberOfLines = 0
        let str = "查看最近登录过的手机，如果发现可疑登录，请点击“删除”，并立即设置密码"
        let attri = NSMutableAttributedString(string: str )
        attri.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.colorWithHexString("999999"),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], range: NSRange(location: 0, length: str.length() - 4))
        attri.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.colorWithHexString("369CF0"),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], range: NSRange(location: str.length() - 4, length: 4))
        footerLabel.attributedText = attri
        footer.addSubview(footerLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(footerClick(_:)))
        footer.addGestureRecognizer(tap)
        return footer
    }()
    
    lazy var rightBarBtn: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setTitle("编辑", for: .normal)
        btn.setTitle("完成", for: .selected)
        btn.setTitleColor(.hexColor(0x333333), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(rightBarBtnClick(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        addRefrash()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func config() -> Void {
        self.title = "登录设备记录"
        self.tableView.showNoDataNotice = false
//        self.tableView.tableFooterView = footer
//        self.tableView.register(byIdentifiers: ["HFRecentLoginRecordCell"])
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 0.001))
        self.tableView.registerUnXib(byIdentifiers: ["UITableViewCell"])
        self.tableView.separatorColor = .colorSeperLine()
        self.tableView.backgroundColor = .colorBg()
        self.view.backgroundColor = .colorBg()
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    @objc func footerClick(_ tap: UITapGestureRecognizer) {
        let vc = HFAccountSetPasswordController()
        vc.type = .original
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addRefrash() -> Void {
        
        self.tableView.headerRefreshingBlock { [weak self] (page) in
            
            self?.getLoginLogRecordList(page)
        }
        
        self.tableView.footerRefreshingBlock { [weak self] (page) in

            self?.getLoginLogRecordList(page)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    @objc func rightBarBtnClick(_ btn: UIButton) -> Void {
        if !btn.isSelected && tableView.isEditing {
            // 用户已经左滑，点击编辑后取消编辑状态
            tableView.isEditing = false
            return
        }
        btn.isSelected = !btn.isSelected
        tableView.isEditing = btn.isSelected
    }
    
    func getLoginLogRecordList(_ page: Int) -> Void {
        
        self.myViewModel.loginLogList(page, { [weak self] in
            Asyncs.async({
                
            }) {
                self?.tableView.endRefresh(byIsDownRefresh: true, isRequestSuccess: true, total: self?.myViewModel.logsTotal ?? 0, pageSize: 15)
                self?.tableView.endRefresh(byIsDownRefresh: false, isRequestSuccess: true, total: self?.myViewModel.logsTotal ?? 0, pageSize: 15)
                self?.tableView.showNoDataNotice = true
                self?.tableView.reloadData()
            }
        }) { [weak self] in
            Asyncs.async({
                
            }) {
                self?.tableView.endRefresh(byIsDownRefresh: true, isRequestSuccess: false, total: self?.myViewModel.logsTotal ?? 0, pageSize: 15)
                self?.tableView.endRefresh(byIsDownRefresh: false, isRequestSuccess: false, total: self?.myViewModel.logsTotal ?? 0, pageSize: 15)
                self?.tableView.showNoDataNotice = true
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension HFRecentLoginRecordController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        myViewModel.logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HFRecentLoginRecordCell") as! HFRecentLoginRecordCell
//        cell.device = self.myViewModel.logs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.accessoryType = .disclosureIndicator
        let model = self.myViewModel.logs[indexPath.row]
        cell.textLabel?.textColor = .hexColor(0x333333)
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.textLabel?.text = model.ullDeviceName
        return cell
    }
}


extension HFRecentLoginRecordController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }

    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction.init(style: .default, title: "删除") { (action, indexpath) in
            print("删除操作")
            self.deleteRecord(at: indexPath)
        }
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HFLoginDeviceDetailViewController()
        let model = self.myViewModel.logs[indexPath.row]
        vc.loginDeviceModel = model
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    /// 删除操作
    func deleteRecord(at indexPath: IndexPath) -> Void {
        myViewModel.deleteLoginLog(indexPath, { [weak self] in
            Asyncs.async({}) {
                self?.tableView.reloadData()
            }
        }) {}
    }
    
}


