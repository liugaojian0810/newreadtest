//
//  HFBabyEntryTableViewController.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/11.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFBabyEntryTableViewController: HFNewBaseViewController {
    
    var viewModel = HFEditBabyInfoViewModel()
    
    var editComplete: OptionClosure? // 编辑完成回调
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var currentEditType: HFEditBabyInfoType?
    
    lazy var rightBarBtn: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setTitle("保存", for: .normal)
        btn.setTitleColor(.hexColor(0x333333), for: .normal)
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(rightBarBtnClick(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.title
        
        currentEditType = viewModel.editType
        if currentEditType == .healthInfo {
            nextBtn.setTitle("提交", for: .normal)
        }
        if currentEditType == .parentInfo {
            let addParentBtn = UIButton.init(type: .custom)
            addParentBtn.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 60)
            addParentBtn.setTitle("添加其他亲属", for: .normal)
            addParentBtn.setTitleColor(.colorMain(), for: .normal)
            addParentBtn.setImage(UIImage.init(named: "icon-tianjia-parent"), for: .normal)
            addParentBtn.titleLabel?.font = UIFont.init(name: "ARYuanGB-BD", size: 14)
            addParentBtn.jk_setImagePosition(.LXMImagePositionLeft, spacing: 6)
            addParentBtn.addTarget(self, action: #selector(addParent), for: .touchUpInside)
            tableView.tableFooterView = addParentBtn
        }else{
            tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 0.001))
        }
        
        self.nextBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        self.nextBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        self.nextBtn.isEnabled = true
        
        tableView.backgroundColor = .colorBg()
        self.tableView.register(byIdentifiers: ["HFBabyParentSectionHeaderView","HFBabyEditInputCell","HFBabyEditMultipleInputCell","HFBabyEditOnlySelectCell","HFFormImageCell"])
        self.tableView.separatorStyle = .none
        
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        if viewModel.editType == .baseInfo {
            ShowHUD.showHUDLoading()
            viewModel.getBabyDetail {
                ShowHUD.hiddenHUDLoading()
                self.tableView.reloadData()
            } _: {
                ShowHUD.hiddenHUDLoading()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.editType = currentEditType!
    }
    
    @objc override func backBtnClieck(send: UIButton) -> Void {
        self.showNormalAlert("提示", "确定要退出吗？请保存", "取消", "保存") {
            self.navigationController?.popToRootViewController(animated: true)
        } _: {
            ShowHUD.showHUDLoading()
            self.viewModel.sumbitType = 0
            self.save()
        }
    }
    
    // 添加亲属
    @objc func addParent() -> Void {
        viewModel.addParent()
        tableView.reloadData()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if currentEditType == .healthInfo {
            // 提交
            viewModel.sumbitType = 1
            save()
        }else{
            // 下一步
            let vc = HFBabyEntryTableViewController()
            viewModel.editType = currentEditType!.next()
            vc.viewModel = viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
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

extension HFBabyEntryTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = self.viewModel.dataArr![section]
        var number = arr.count
        if viewModel.editType == .intoKindergarten && !viewModel.ciOnlyChild {
            number -= 3
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr = self.viewModel.dataArr![indexPath.section]
        let model = arr[indexPath.row]
        switch model.type {
        case .header:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "HFFormImageCell", for: indexPath) as! HFFormImageCell
            let cellModel = HFFormImageCellModel(cellType: .image, onlyShow: false, imageUrl: "", image: nil, placeholder: nil)
            if let babyModel = self.viewModel.babyModel, !babyModel.headImg.isEmpty {
                cellModel.imageUrl = self.viewModel.babyModel?.headImg
            }
            if !model.value.isEmptyStr() {
                cellModel.imageUrl = model.value
            }
            cellModel.title = model.title
            cellModel.leftMargin = 24
            cell1.model = cellModel
            return cell1
        case .input,.select,.onlyShow:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFBabyEditInputCell", for: indexPath) as! HFBabyEditInputCell
            cell.cellType = model.type
            cell.titleLab.text = model.title
            cell.inputCallBack = { input in
                model.value = "\(input)"
            }
            cell.inputTF.placeholder = model.placeholder.isEmpty ? "请输入" : model.placeholder
            cell.inputTF.text = model.value
            cell.inputTF.jk_maxLength = model.maxLength
            cell.selectionStyle = .none
            return cell
        case .multInput:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFBabyEditMultipleInputCell", for: indexPath) as! HFBabyEditMultipleInputCell
            cell.inputCallBack = { input in
                model.value = "\(input)"
            }
            cell.inputTextView.placeholder = model.placeholder.isEmpty ? "请输入" : model.placeholder
            cell.selectionStyle = .none
            cell.inputTextView.text = model.value
            return cell
        case .onlySelect:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFBabyEditOnlySelectCell", for: indexPath) as! HFBabyEditOnlySelectCell
            cell.titleLab.text = model.title
            if viewModel.editType == .baseInfo {
                cell.noBtn.setTitle("女", for: .normal)
                cell.yesBtn.setTitle("男", for: .normal)
                let usrSex = Int(model.value) ?? 0
                if usrSex == 1 {
                    cell.seletcStatus = 1
                }else if usrSex == 2 {
                    cell.seletcStatus = 0
                }else{
                    cell.seletcStatus = 2
                }
                cell.clickCallBack = { value in
                    if value == 1 {
                        model.value = "1"
                    }
                    if value == 0 {
                        model.value = "2"
                    }
                }
            }else{
                cell.seletcStatus = Int(model.value) ?? 2
                cell.clickCallBack = { value in
                    model.value = "\(value)"
                    if model.title == "是否有兄弟姐妹" {
                        var indexs: [IndexPath] = []
                        for i in 1...3 {
                            indexs.append(IndexPath.init(row: indexPath.row + i, section: 0))
                        }
                        if self.viewModel.ciOnlyChild {
                            tableView.insertRows(at:indexs, with: .top)
                        }else{
                            if tableView.numberOfRows(inSection: indexPath.section) == arr.count {
                                // 防止数组越界
                                tableView.deleteRows(at: indexs, with: .bottom)
                            }
                        }
                    }
                }
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFBabyEditInputCell", for: indexPath) as! HFBabyEditInputCell
            return cell
        }
    }
}

extension HFBabyEntryTableViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataArr?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let arr = self.viewModel.dataArr![indexPath.section]
        let model = arr[indexPath.row]
        switch model.type {
        case .input,.select,.onlyShow:
            return 83
        case .multInput:
            return 77
        case .onlySelect:
            return 64
        default:
            return 64
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if currentEditType == .parentInfo {
            return 57
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if currentEditType == .parentInfo {
            let sectionHead = tableView.dequeueReusableCell(withIdentifier: "HFBabyParentSectionHeaderView") as! HFBabyParentSectionHeaderView
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
        self.showSelect(indexPath: indexPath)
    }
    
    @objc func rightBarBtnClick(_ btn: UIButton) -> Void {
        ShowHUD.showHUDLoading()
        viewModel.sumbitType = 0
        save()
    }
    
    func save() -> Void {
        self.viewModel.editChildInfo({
            self.handleComplete()
            print("编辑成功...")
        }) {
            ShowHUD.hiddenHUDLoading()
            print("编辑失败...")
        }
    }
    
    // 编辑成功
    func handleComplete() -> Void {
        if viewModel.responseDic != nil {
            let code = viewModel.responseDic!["code"] as? Int
            var message = viewModel.responseDic!["message"] as? String
            if message == nil || message!.isEmptyStr() {
                message = "宝宝入园申请表已存在，是否同步宝宝数据？"
            }
            if code == 161166 {
                ShowHUD.hiddenHUDLoading()
                self.showNormalAlert("提示", message!, "取消", "确定") {
                } _: {
                    self.sureInfoSynchronization()
                }
                return
            }
        }
        
        ShowHUD.hiddenHUDLoading()
        self.editSuccess()
    }
    
    func sureInfoSynchronization() -> Void {
        viewModel.sureInfoSynchronization {
            self.editSuccess()
            ShowHUD.hiddenHUDLoading()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func editSuccess() -> Void {
        if self.editComplete != nil {
            self.editComplete!()
        }
        HFAlert.show(withMsg: viewModel.sumbitType == 1 ? "保存成功" : "提交成功", in: self, alertStatus: AlertStatusSuccfess) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension HFBabyEntryTableViewController {
    func showSelect(indexPath: IndexPath) {
        self.view.endEditing(true)
        switch viewModel.editType {
        case .baseInfo:
            // 编辑基础信息
            let arr = self.viewModel.dataArr![indexPath.section]
            let model = arr[indexPath.row]
            switch model.title {
            case "出生日期":
                HFSelectorTools.selectorYMD(minDateIsToDay: false) { (selectDate, selectValue) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = selectValue
                    self.tableView.reloadData()
                }
            case "宝宝国籍":
                HFSelectorTools.selectorPubDict(type: .Country, refresh: false) { (model) in
                    self.viewModel.nationalityModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            case "民族":
                HFSelectorTools.selectorPubDict(type: .Nation, refresh: false) { (model) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    self.viewModel.nationModel = model
                    selectModel.value = model.naName
                    self.tableView.reloadData()
                }
            case "宝宝户籍":
                HFSelectorTools.selectorRegion(refresh: false, level: 2) { (res) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    self.viewModel.censusRegisterAddress = res
                    var value = ""
                    for model in res {
                        value += "\(model.diName)"
                    }
                    selectModel.value = value
                    self.tableView.reloadData()
                }
            case "头像":
                let selectImg = HFSelectHeaderImageViewController()
                selectImg.selectClosure = { img in
                    ShowHUD.showHUDLoading()
                    HFPubRequest.uploadImage(image: img) { (progress) in
                        print("\(progress)")
                    } successed: { (res) in
                        ShowHUD.hiddenHUDLoading()
                        let arr = self.viewModel.dataArr![indexPath.section]
                        let headerModel = arr[indexPath.row]
                        let model = res.first
                        headerModel.value = model?.fiAccessPath ?? ""
                        self.tableView.reloadData()
                    } failured: { (error) in
                        ShowHUD.hiddenHUDLoading()
                    }
                }
                selectImg.modalPresentationStyle = .overFullScreen
                self.present(selectImg, animated: true, completion: {})
            default:
                break
            }
        case .parentInfo:
            // 编辑家长信息
            let arr = self.viewModel.dataArr![indexPath.section]
            let model = arr[indexPath.row]
            switch model.title {
            case "与宝宝关系":
                HFSelectorTools.selectorPubDict(type: .Childrels, refresh: false) { (model) in
                    self.viewModel.relationModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            case "国籍":
                HFSelectorTools.selectorPubDict(type: .Country, refresh: false) { (model) in
                    self.viewModel.nationalityModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            case "出生日期":
                HFSelectorTools.selectorYMD(minDateIsToDay: false) { (selectDate, selectValue) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = selectValue
                    let ageModel = arr[indexPath.row + 1]
                    ageModel.value = String.caculateAgeY(birthday: selectValue) + "岁"
                    self.tableView.reloadData()
                }
            case "民族":
                HFSelectorTools.selectorPubDict(type: .Nation, refresh: false) { (model) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    self.viewModel.nationModel = model
                    selectModel.value = model.naName
                    self.tableView.reloadData()
                }
            case "籍贯":
                HFSelectorTools.selectorRegion(refresh: false, level: 1) { (res) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    let model = res.first
                    self.viewModel.nativePlaceModel = model
                    selectModel.value = model?.diName ?? ""
                    self.tableView.reloadData()
                }
            case "学历":
                HFSelectorTools.selectorPubDict(type: .Education, refresh: false) { (model) in
                    self.viewModel.educationModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            case "户籍所在地":
                HFSelectorTools.selectorRegion(refresh: false, level: 3) { (res) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    self.viewModel.censusRegisterAddress = res
                    var value = ""
                    for model in res {
                        value += "\(model.diName)"
                    }
                    selectModel.value = value
                    self.tableView.reloadData()
                }
            default:
                break
            }
        case .kindergarten:
            switch indexPath.row {
            case 1:
                HFSelectorTools.selectorPubDict(type: .Education, refresh: false) { (model) in
                    self.viewModel.educationModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            case 3,4:
                HFSelectorTools.selectorYMD(minDateIsToDay: false) { (selectDate, selectValue) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = selectValue
                    self.tableView.reloadData()
                }
            default:
                break
            }
        case .intoKindergarten:
            // 编辑入园信息
            let arr = self.viewModel.dataArr![indexPath.section]
            let model = arr[indexPath.row]
            switch model.title {
            case "入园日期":
                HFSelectorTools.selectorYMD(minDateIsToDay: false) { (selectDate, selectValue) in
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = selectValue
                    self.tableView.reloadData()
                }
            case "选择兄弟姐妹":
                HFSelectorTools.selectorPubDict(type: .BrotherSister, refresh: false) { (model) in
                    self.viewModel.childBrotherRelationModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            case "入园前由谁照看":
                HFSelectorTools.selectorPubDict(type: .Childrels, refresh: false) { (model) in
                    self.viewModel.ciBeCareByModel = model
                    let arr = self.viewModel.dataArr![indexPath.section]
                    let selectModel = arr[indexPath.row]
                    selectModel.value = model.dicFieldName
                    self.tableView.reloadData()
                }
            default:
                break
            }
        case .healthInfo:
            break
        default:
            break
        }
    }
}
