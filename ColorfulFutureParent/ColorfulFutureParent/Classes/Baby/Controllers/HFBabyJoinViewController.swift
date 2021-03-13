//
//  HFBabyJoinViewController.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFBabyJoinViewController: HFNewBaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HFBabyJoinViewModel()
    
    //添加，编辑宝宝成功回调
    var successClosure: OptionClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "填写入园基本信息"
        self.sureBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        self.sureBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        self.sureBtn.isEnabled = false
        
        if viewModel.waitBabyModel != nil {
            self.handelData()
        }else{
            viewModel.addBabyDataModel = HFAddBabyDataModel.init()
        }
    }
    
    func handelData() -> Void {
        Asyncs.async {
            // 将待入园宝宝转换为添加宝宝数据模型
            let babyDic = self.viewModel.waitBabyModel?.toJSON()
            self.viewModel.addBabyDataModel = HFAddBabyDataModel.init(JSON: babyDic ?? [:])
            self.updateSureStatus()
        } _: {
            self.tableView.reloadData()
        }
    }
    
    override func addSubViews() {
        
        view.backgroundColor = .white
        tableView.register(byIdentifiers: ["HFBabySectionHeaderView","HFFormOneLineInputCell","HFFormSelectCell","HFFormRadioBoxCell","HFFormImageCell"])
        tableView.backgroundColor = .white
        let tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 12))
        tableHeaderView.backgroundColor = .colorBg()
        tableView.tableHeaderView = tableHeaderView
        tableView.separatorColor = .hexColor(0xEDEDED)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = self.viewModel.dataArr[section]
        return arr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.viewModel.dataArr[indexPath.section][indexPath.row]
        
        if let imageModel = model as? HFFormImageCellModel {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "HFFormImageCell", for: indexPath) as! HFFormImageCell
            imageModel.leftMargin = 16
            imageModel.onlyShow = true
            cell1.model = imageModel
            return cell1
        }
        if let radioBoxModel = model as? HFFormRadioBoxCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFormRadioBoxCell", for: indexPath) as! HFFormRadioBoxCell
            cell.model = radioBoxModel
            cell.selectComplete = {[weak self] selectIndex in
                radioBoxModel.selectedIndex = selectIndex
                if selectIndex == 0 {
                    if indexPath.row == 1 || indexPath.row == 2 {
                        self!.viewModel.addBabyDataModel?.ciSex = 2
                    }else{
                        self!.viewModel.addBabyDataModel?.ciComeStatus = 0
                    }
                }else if selectIndex == 1{
                    if indexPath.row == 1 {
                        self!.viewModel.addBabyDataModel?.ciSex = 1
                    }else{
                        self!.viewModel.addBabyDataModel?.ciComeStatus = 1
                    }
                }
                self?.updateSureStatus()
            }
            return cell
        }
        if let inputModel = model as? HFFormTextInputCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFormOneLineInputCell", for: indexPath) as! HFFormOneLineInputCell
            cell.model = inputModel
            cell.inputComplete = {[weak self] text in
                inputModel.contentText = text
                if indexPath.section == 0 {
                    switch indexPath.row {
                    case 0:
                        self?.viewModel.addBabyDataModel?.usrFullName = text
                    case 2:
                        self?.viewModel.addBabyDataModel?.usrPhone = text
                    default:
                        break
                    }
                }
                if indexPath.section == 1 {
                    if indexPath.row == 0 {
                        self?.viewModel.addBabyDataModel?.ciName = text
                    }
                }
                self?.updateSureStatus()
            }
            return cell
        }
        if let selectModel = model as? HFFormSelectCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFormSelectCell", for: indexPath) as! HFFormSelectCell
            cell.model = selectModel
            return cell
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if indexPath.section == 0 {
            switch indexPath.row {
            case 1:
                if viewModel.waitBabyModel != nil {
                    return
                }
                HFSelectorTools.selectorPubDict(type: .Childrels, refresh: false) { (model) in
                    self.viewModel.relationModel = model
                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row] as? HFFormSelectCellModel {
                        selectModel.contentText = model.dicFieldName
                    }
                    self.viewModel.addBabyDataModel?.cprRelp = model.dicFieldCode
                    self.viewModel.addBabyDataModel?.dicFieldName = model.dicFieldName
                    self.tableView.reloadData()
                    self.updateSureStatus()
                }
            default:
                break
            }
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 1:
                if viewModel.waitBabyModel != nil {
                    return
                }
                HFSelectorTools.selectorYMD(minDateIsToDay: false) { (selectDate, selectValue) in
                    self.viewModel.addBabyDataModel?.ciBirth = selectValue
                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row] as? HFFormSelectCellModel {
                        selectModel.contentText = selectValue
                    }
                    self.tableView.reloadData()
                    self.updateSureStatus()
                }
            case 2:
                if viewModel.waitBabyModel != nil {
                    return
                }
                let dataSource = ["男","女"]
                HFSelectorTools.selectorItem(dataSource) { (index) in
                    self.viewModel.addBabyDataModel?.ciSex = index + 1
                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row] as? HFFormSelectCellModel {
                        selectModel.contentText = dataSource[index]
                    }
                    self.tableView.reloadData()
                    self.updateSureStatus()
                }
            case 3:
                let dataSource = ["已在园宝宝","新入园宝宝"]
                HFSelectorTools.selectorItem(dataSource) { (index) in
                    self.viewModel.addBabyDataModel?.ciComeStatus = index
                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row] as? HFFormSelectCellModel {
                        selectModel.contentText = dataSource[index]
                    }
                    self.tableView.reloadData()
                    self.updateSureStatus()
                }
            default:
                break
            }
        }
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                self.view.endEditing(true)
                // 选择宝宝年级
//                HFSelectorTools.selectorGrade(refresh: false) { (model) in
//                    self.viewModel.selectGradeModel = model
//                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row] as? HFFormSelectCellModel {
//                        selectModel.contentText = model.kgrRemarkName
//                    }
//                    self.viewModel.addBabyDataModel?.kgrId = model.kgrId
//                    self.viewModel.addBabyDataModel?.kgrRemarkName = model.kgrRemarkName
//
//                    // 重置班级
//                    self.viewModel.selectClassModel = nil
//                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row+1] as? HFFormSelectCellModel {
//                        selectModel.contentText = ""
//                    }
//                    self.viewModel.addBabyDataModel!.clId = ""
//
//                    if self.babyModel != nil {
//                        if self.babyModel!.kgrId.isEmptyStr() {
//                            self.viewModel.cgType = 0
//                        }else{
//                            self.viewModel.cgType = 2
//                        }
//                    }
//
//                    self.tableview.reloadData()
//                    self.updateSureStatus()
//                }
            }
            if indexPath.row == 1 {
                self.view.endEditing(true)
                // 选择宝宝班级
                if self.viewModel.selectGradeModel == nil {
                    ShowHUD.showHUD(withInfo: "请先选择年级")
                    return
                }
                
//                HFSelectorTools.selectorClass(grId: self.viewModel.selectGradeModel!.grId, refresh: false) { (model) in
//                    self.viewModel.selectClassModel = model
//                    if let selectModel = self.viewModel.dataArr[indexPath.section][indexPath.row] as? HFFormSelectCellModel {
//                        selectModel.contentText = model.clName
//                    }
//                    self.viewModel.addBabyDataModel!.clId = model.clId
//                    self.viewModel.addBabyDataModel!.clName = model.clName
//
//                    self.viewModel.cgType = 2
//
//                    self.tableview.reloadData()
//                    self.updateSureStatus()
//                }
            }
        }
    }
    
    // 更新确认按钮状态
    func updateSureStatus() -> Void {
        var isEnabled = true
        mainloop : for arr in viewModel.dataArr {
            for model in arr {
                if let inputModel = model as? HFFormTextInputCellModel {
                    isEnabled = !inputModel.isEmpty()
                }
                if let selectModel = model as? HFFormSelectCellModel {
                    isEnabled = !selectModel.isEmpty()
                }
                if !isEnabled {
                    break mainloop
                }
            }
        }
        self.sureBtn.isEnabled = isEnabled
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFBabySectionHeaderView") as! HFBabySectionHeaderView
        sectionHead.titleLabel.text = section == 0 ? "家长信息" : "宝宝信息"
        return sectionHead
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    @IBAction func clickSure(_ sender: UIButton) {
        ShowHUD.showHUDLoading()
        viewModel.parentJoinKg(successClosure: {
            ShowHUD.hiddenHUDLoading()
            print("发送宝宝入园申请成功")
            if self.viewModel.waitBabyModel != nil {
                for babyModel in HFBabyViewModel.shared.babys {
                    if babyModel == self.viewModel.waitBabyModel {
                        // 修改状态为审核中
                        babyModel.isEntranceKg = 2
                        break
                    }
                }
            }
            
            if self.successClosure != nil {
                self.successClosure!()
            }
            
            HFAlert.show(withMsg: "提交成功，请等待园长审核", in: self, alertStatus: AlertStatusSuccfess) {
                self.navigationController?.popViewController(animated: true)
            }
        }) {
            ShowHUD.hiddenHUDLoading()
            print("添加宝宝失败")
        }
    }
}


