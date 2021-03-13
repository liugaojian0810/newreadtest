//
//  HFSelectTaskViewController.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by wzz on 2020/10/29.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSelectTaskViewController: HFNewBaseViewController {
    
    var viewModel: HFInteractTaskViewModel?
    
    @IBOutlet weak var sureBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if viewModel == nil {
            viewModel = HFInteractTaskViewModel()
        }
        if viewModel!.eduActivitys.count == 0 {
            tableView.showNoDataNotice = false
            loadInteractTask()
        }
        config()
    }

    func config() {
        title = "选择小任务"
        tableView.register(byIdentifiers: ["HFSelectTaskTableViewCell","HFSelectTaskSectionHeadeView","HFSelectTaskSectionFooterView"])
        tableView.estimatedRowHeight = 21
        tableView.estimatedSectionHeaderHeight = 59
        tableView.separatorColor = .colorSeperLine()
        sureBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
//        sureBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
//        sureBtn.isEnabled = viewModel!.selectedInteractTasks.count != 0
    }
    
    func loadInteractTask() -> Void {
        ShowHUD.showHUDLoading()
        viewModel!.getInteractTask { [weak self] in
            ShowHUD.hiddenHUDLoading()
            self!.tableView.showNoDataNotice = true
            self!.tableView.reloadData()
        } _: { [weak self] in
            ShowHUD.hiddenHUDLoading()
            self!.tableView.showNoDataNotice = false
        }
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        if viewModel!.selectComplete != nil {
            viewModel!.selectComplete!(viewModel!.selectedInteractTasks)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension HFSelectTaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = viewModel!.eduActivitys[section]
        if !model.isOpen && 3 < model.grownActionTaskList.count {
            return 3
        }
        return model.grownActionTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSelectTaskTableViewCell", for: indexPath) as! HFSelectTaskTableViewCell
        let model = viewModel!.eduActivitys[indexPath.section]
        let taskModel = model.grownActionTaskList[indexPath.row]
        cell.selectBtn.isSelected = taskModel.isSelected
        cell.index = indexPath.row
        cell.content = String.numberString(index: indexPath.row) + " " + taskModel.gatIntro
        if viewModel!.disableInteractTasks.contains(where: { (model) -> Bool in
            return model.gatId == taskModel.gatId
        }) {
            cell.isUserInteractionEnabled = false
            cell.selectBtn.isEnabled = false
        }else{
            cell.isUserInteractionEnabled = true
            cell.selectBtn.isSelected = taskModel.isSelected
        }
        cell.selectBlock = { [weak self] in
            self?.selectItem(indexPath: indexPath)
        }
        return cell
    }
    
    func selectItem(indexPath: IndexPath) -> Void {
        let model = viewModel!.eduActivitys[indexPath.section]
        let taskModel = model.grownActionTaskList[indexPath.row]
        if taskModel.isSelected {
            taskModel.isSelected = false
            self.viewModel!.selectedInteractTasks.removeAll(where: { $0 == taskModel })
            tableView.reloadData()
        }else{
            if self.viewModel!.selectedInteractTasks.count < 1 {
                taskModel.isSelected = true
                self.viewModel!.selectedInteractTasks.append(taskModel)
                tableView.reloadData()
            }else{
                ShowHUD.showHUD(withInfo: "小任务最多选择1个")
            }
        }
//        sureBtn.isEnabled = viewModel!.selectedInteractTasks.count != 0
    }
}

extension HFSelectTaskViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel!.eduActivitys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = viewModel!.eduActivitys[indexPath.section]
        let taskModel = model.grownActionTaskList[indexPath.row]
        let text = String.numberString(index: indexPath.row) + " " + taskModel.gatIntro
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left;
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 14 * 1.25
        paragraphStyle.lineSpacing = 8
        let attb = NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.font:  UIFont.init(name: "ARYuanGB-MD", size: 14)!])
        var height = text.get_heightForComment(string: attb, width: ScreenWidth - 30 - 67)
        if height < 21 {
            height = 21
        }
        if 3 < model.grownActionTaskList.count && indexPath.row == model.grownActionTaskList.count - 1 {
            return height
        }else{
            return height + 8
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = tableView.dequeueReusableCell(withIdentifier: "HFSelectTaskSectionHeadeView") as! HFSelectTaskSectionHeadeView
        let model = viewModel!.eduActivitys[section]
        sectionView.titleLabel.text = model.gaName
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let model = viewModel!.eduActivitys[section]
        if model.grownActionTaskList.count <= 3 {
            return 10
        }
        return 27
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableCell(withIdentifier: "HFSelectTaskSectionFooterView") as! HFSelectTaskSectionFooterView
        let model = viewModel!.eduActivitys[section]
        if model.grownActionTaskList.count <= 3 {
            footerView.arrowBtn.isHidden = true
        }else{
            footerView.arrowBtn.isHidden = false
            footerView.arrowBtn.isSelected = model.isOpen
        }
        footerView.selectOpen = { [weak self] in
            let model = self!.viewModel!.eduActivitys[section]
            model.isOpen = !model.isOpen
            self!.tableView.reloadData()
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footerView = view as! HFSelectTaskSectionFooterView
        var height: CGFloat = 27.0
        let model = viewModel!.eduActivitys[section]
        if model.grownActionTaskList.count <= 3 {
            height = 10
        }
        footerView.bgView.height = height
        footerView.bgView.width = ScreenWidth - 30
        footerView.bgView.jk_setRoundedCorners([.bottomLeft,.bottomRight], radius: 8)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectItem(indexPath: indexPath)
    }
}
