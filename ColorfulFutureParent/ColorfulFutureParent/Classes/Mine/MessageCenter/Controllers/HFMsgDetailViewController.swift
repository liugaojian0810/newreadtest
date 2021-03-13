//
//  HFMsgDetailViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/7.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMsgDetailViewController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var type: HFMessageType = .todo // 消息类型
    
    var myViewModel = HFMessageCenterViewModel() // 消息事务处理
    
    var msg: HFMessageListModel? // 消息数据模型
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        getMsgDetail()
    }
    
    private func config() -> Void {
        
        self.title = "消息详情"
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 45
        tableView.backgroundColor = .white
        tableView.register(byIdentifiers: ["HFMsgDetailHeaderView","HFMsgDetailTextTableViewCell","HFMsgDetailImageTableViewCell"])
    }
    
    func getMsgDetail() -> Void {
        ShowHUD.showHUDLoading()
        myViewModel.getMsgDetail(self.msg!.plId) {
            self.refrash()
        } _: {
            self.refrash()
        }
    }
    
    func refrash() -> Void {
        ShowHUD.hiddenHUDLoading()
        Asyncs.async({}) {self.tableView.reloadData()}
    }
    
}

extension HFMsgDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if self.myViewModel.msgList != nil && self.myViewModel.msgList!.msgImg.length() > 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFMsgDetailTextTableViewCell") as! HFMsgDetailTextTableViewCell
            if self.myViewModel.msgList != nil {
                cell.contentLabel.text = self.myViewModel.msgList?.msgContent
            }else {
                cell.contentLabel.text = ""
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFMsgDetailImageTableViewCell") as! HFMsgDetailImageTableViewCell
        cell.contentImageView.kf.setImage(with: URL.init(string: self.myViewModel.msgList!.msgImg))
        return cell
    }
}

extension HFMsgDetailViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 209
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 55
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFMsgDetailHeaderView") as! HFMsgDetailHeaderView
            if self.myViewModel.msgList != nil {
                sectionHead.titleLabel.text = self.myViewModel.msgList!.msgTitle
                sectionHead.timeLabel.text = self.myViewModel.msgList!.pushTime
            }
            return sectionHead
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
