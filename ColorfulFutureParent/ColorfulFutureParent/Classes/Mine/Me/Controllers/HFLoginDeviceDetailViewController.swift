//
//  HFLoginDeviceDetailViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/25.
//  Copyright © 2020 huifan. All rights reserved.
//
// 登录设备详情

import UIKit

class HFLoginDeviceDetailViewController: HFNewBaseViewController {

    var loginDeviceModel: HFLoginDeviceModel?
    @IBOutlet weak var tableView: UITableView!
    
    var titles:[[String]] = [["设备名称"],["设备类型","最后登录时间"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    func config() -> Void {
        self.title = "设备详情"
        
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 0.001))
        self.tableView.separatorColor = .colorSeperLine()
        self.tableView.backgroundColor = .colorBg()
        self.view.backgroundColor = .colorBg()
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HFLoginDeviceDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.accessoryType = indexPath.section == 0 ? .disclosureIndicator : .none
        cell.textLabel?.textColor = .hexColor(0x333333)
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.textLabel?.text = titles[indexPath.section][indexPath.row]
        cell.detailTextLabel?.textColor = .hexColor(0x999999)
        cell.detailTextLabel?.font = .systemFont(ofSize: 16)
        cell.detailTextLabel?.text = "未知"
        if indexPath.section == 0 {
            cell.detailTextLabel?.text = self.loginDeviceModel?.ullDeviceName
            cell.selectionStyle = .default
        }else{
            if indexPath.row == 0 {
                cell.detailTextLabel?.text = self.loginDeviceModel?.ullDeviceType
            }else{
                cell.detailTextLabel?.text = self.loginDeviceModel?.loginTime
            }
            cell.selectionStyle = .none
        }
        return cell
    }
}

extension HFLoginDeviceDetailViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let vc = HFUpdateDeviceNameViewController()
            vc.viewModel.loginDeviceModel = self.loginDeviceModel
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
