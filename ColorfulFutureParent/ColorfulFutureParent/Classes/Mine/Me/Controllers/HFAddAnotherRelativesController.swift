//
//  HFAddAnotherRelativesController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/7.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFAddAnotherRelativesController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var myViewModel = HFMineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    func config()  {
        self.title = "添加其他亲属"
        self.tableView.register(byIdentifiers: ["HFComEditCell"])
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(rightBtnClick(_:)))
    }
    
    /// 保存按钮点击
    /// - Parameter btn: 按钮对象
    @objc func rightBtnClick(_ btn: UIBarButtonItem) {
        if self.myViewModel.verifyReslts() == true {
            ShowHUD.showHUDLoading()
            self.myViewModel.addAnotherRelations {
                ShowHUD.hiddenHUDLoading()
                AlertTool.showBottom(withText: "添加完成")
                Asyncs.asyncDelay(2) {
                } _: {
                    self.navigationController?.popViewController()
                }
            } _: { ShowHUD.hiddenHUDLoading() }
        }
    }
}

extension HFAddAnotherRelativesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.myViewModel.addMembersTips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
        cell.tipLabel.text = myViewModel.addMembersTips[indexPath.row]
        cell.textField.placeholder = myViewModel.addMembersPlaceholders[indexPath.row]
        cell.lineView.isHidden = false
        cell.textField.isHidden = false
        cell.contentView.isHidden = false
        switch indexPath.row {
        case 0, 3:
            cell.maxInput =  (indexPath.row == 0) ? 0 : 11
            cell.textField.text = self.myViewModel.results[indexPath.row]
            cell.textField.isEnabled = true
            cell.textField.keyboardType = (indexPath.row == 0) ? .default : .numberPad
            cell.arrowIntoImg.isHidden = true
            cell.editChangedClosure = { str in
                self.myViewModel.results[indexPath.row] = str
            }
        default:
            cell.maxInput = 0
            if indexPath.row == 1 {
                cell.textField.text = self.myViewModel.results[indexPath.row]
            }else{
                let sex = self.myViewModel.results[indexPath.row]
                if sex == "1" {
                    cell.textField.text = "男"
                }else if sex == "2"{
                    cell.textField.text = "女"
                }else{
                    cell.textField.text = ""
                }
            }
            cell.textField.isEnabled = false
            cell.arrowIntoImg.isHidden = false
        }
        return cell
    }
}

extension HFAddAnotherRelativesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            /// 与宝宝的关系
            self.view.endEditing(true)
            HFSelectorTools.selectorPubDict(type: .Childrels, refresh: true) { (infoModel) in
                self.myViewModel.cprRelp = infoModel.dicFieldCode
                self.myViewModel.results[1] = infoModel.dicFieldName
                Asyncs.async({
                }) {
                    self.tableView.reloadData()
                }
            }
        case 2:
            /// 设置性别
            self.view.endEditing(true)
            CGXPickerView.showStringPicker(withTitle: "性别", dataSource: ["男", "女"], defaultSelValue: nil, isAutoSelect: false, manager: nil) { (value, index) in
                self.myViewModel.sex = value as! String
                if value as! String == "男" {
                    self.myViewModel.results[2] = "1"
                }else{
                    self.myViewModel.results[2] = "2"
                }
                Asyncs.async({
                }) { self.tableView.reloadData() }
            }
        default:
            print("default")
        }
    }
}

