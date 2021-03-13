//
//  HFInteractReportViewController.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2020/12/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractReportViewController: HFNewBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomBtn: UIButton!
    
    var viewModel = HFInteractReportViewModel()
    
    var operationComplete: OptionClosure? // 保存、编辑、发布完成后回调
    
    // 保存，编辑，分享
    lazy var rightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.hexColor(0x333333), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(rightBarBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        requestDetail()
    }
    
    func requestDetail() -> Void {
        viewModel.loadInteractReportDetail {
            self.tableView.reloadData()
            self.updateStatus()
        } _: {
        }
    }
    
    @objc func rightBarBtnClick(_ btn: UIButton) -> Void {
        if viewModel.type == .edit {
            // 未发送
            if viewModel.interactiveReportDetailModel?.kirtPublishStatus == 0 {
                // 已经保存过
                rightBtn.isSelected = !rightBtn.isSelected
                if rightBtn.isSelected {
                    // 编辑
                    let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 2)) as! HFInteractReportTeacherRemarkCell
                    cell.textView.becomeFirstResponder()
                }else{
                    let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 2)) as! HFInteractReportTeacherRemarkCell
                    cell.textView.resignFirstResponder()
                    self.viewModel.publishStatus = 0
                    self.senderReport()
                }
            }
        }else if viewModel.type == .share {
            // 分享
        }
    }
    
    func config() -> Void {
        self.title = "互动报告"
        bottomBtn.jk_setBackgroundColor(.hexColor(0x20B5FF), for: .normal)
        bottomBtn.jk_setBackgroundColor(.hexColor(0x8CD6FA), for: .disabled)
        
        tableView.register(byIdentifiers: ["HFInteractReportBabyInfoCell","HFInteractReportTaskInfoCell","HFInteractReportTeacherRemarkCell"])
        tableView.backgroundColor = .colorBg()
        tableView.estimatedRowHeight = 100
        view.backgroundColor = .colorBg()
        
        updateStatus()
    }
    
    func updateStatus() -> Void {
        if viewModel.type == .edit {
            // 已发送
            if viewModel.interactiveReportDetailModel?.kirtPublishStatus == 1 {
                navigationItem.rightBarButtonItem = nil
                tableBottomConstraint.constant = 0
            }else{
                rightBtn.setTitle("编辑", for: .normal)
                rightBtn.setTitle("保存", for: .selected)
                let rightBarBtn = UIBarButtonItem(customView: rightBtn)
                navigationItem.rightBarButtonItem = rightBarBtn
                tableBottomConstraint.constant = bottomBtn.height + 12
                bottomBtn.isEnabled = false
            }
        }else if viewModel.type == .share {
            rightBtn.setImage(UIImage.init(named: "nav_share"), for: .normal)
            let rightBarBtn = UIBarButtonItem(customView: rightBtn)
            navigationItem.rightBarButtonItem = rightBarBtn
            tableBottomConstraint.constant = bottomBtn.height + 12
            bottomBtn.setTitle("分享宝贝的高光时刻", for: .normal)
            bottomBtn.isEnabled = true
        }else{
            tableBottomConstraint.constant = 0
            bottomBtn.isHidden = true
        }
    }

    @IBAction func publishReport(_ sender: UIButton) {
        self.showCustomAlert("提示", "确定要发送报告吗？", "取消", "确定") {
        } _: {
            self.viewModel.publishStatus = 1
            self.senderReport()
        }

    }
    
    func senderReport() -> Void {
        ShowHUD.showHUDLoading()
        viewModel.sendTeacherReport {
            ShowHUD.hiddenHUDLoading()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func publishSuccess() -> Void {
        
        HFAlert.show(withMsg: "报告发送成功", in: self, alertStatus: AlertStatusSuccfess)
        if operationComplete != nil {
            operationComplete!()
        }
        navigationController?.popViewController(animated: true)
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

extension HFInteractReportViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractReportBabyInfoCell") as! HFInteractReportBabyInfoCell
            cell.model = viewModel.interactiveReportDetailModel != nil ? viewModel.interactiveReportDetailModel : viewModel.interactiveModel
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractReportTaskInfoCell") as! HFInteractReportTaskInfoCell
            var tasks = viewModel.interactiveModel?.taskList ?? []
            if tasks.count == 0 {
                tasks = viewModel.interactiveReportDetailModel?.taskList ?? []
            }
            cell.tasks = tasks
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractReportTeacherRemarkCell") as! HFInteractReportTeacherRemarkCell
            var tipText = ""
            if viewModel.type == .edit && viewModel.interactiveReportDetailModel?.kirtPublishStatus == 0 {
                cell.inputStatistLabel.isHidden = false
                let placeHolder = "请您给\(viewModel.interactiveReportDetailModel?.kbName ?? "")小朋友点评吧！"
                cell.placeHolder = placeHolder
                cell.textView.placeholder = placeHolder
                cell.textView.isUserInteractionEnabled = true
            }else{
                cell.inputStatistLabel.isHidden = true
                cell.textView.isUserInteractionEnabled = false
                tipText = "暂无互动报告"
            }
            cell.textView.text = viewModel.interactiveReportDetailModel?.kirpContent ?? tipText
            cell.inputCallBack = { [weak self] (text) in
                self!.viewModel.kirpContent = text
            }
            return cell
        default:
            return UITableViewCell.init()
        }
    }
}

extension HFInteractReportViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 265
        case 1:
            return UITableView.automaticDimension
        case 2:
            if viewModel.interactiveReportDetailModel == nil || viewModel.interactiveReportDetailModel!.kirpContent.isEmptyStr() || (viewModel.type == .edit && viewModel.interactiveReportDetailModel?.kirtPublishStatus == 0) {
                return 248.5
            }else{
                var height: CGFloat = 0
                height += 141
                let text = viewModel.interactiveReportDetailModel!.kirpContent
                height += text.get_heightForComment(string: NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font: UIFont.init(name: "ARYuanGB-MD", size: 14)!]), width: ScreenWidth - (42 * 2))
                height += 48
                if height < 248.5 {
                    height = 248.5
                }
                return height
            }
        default:
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 15))
        view.backgroundColor = .colorBg()
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
