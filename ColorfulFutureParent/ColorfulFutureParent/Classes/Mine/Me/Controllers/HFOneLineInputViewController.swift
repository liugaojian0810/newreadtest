//
//  HFOneLineInputViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/10.
//  Copyright © 2020 huifan. All rights reserved.
//  

import UIKit

class HFOneLineInputViewController: HFNewBaseViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    var rightBar: UIBarButtonItem?
    var leftBar: UIBarButtonItem?
    
    @objc var maxLength: Int = 0 //最长字符限制，默认不限制
    @objc var navTitle: String?
    @objc var placeholder: String?
    @objc var inputText: String?
    
    @objc var inputComplete: OptionClosureString?
    
    var myViewModel = HFMineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navTitle
        self.inputTextField.text = inputText ?? ""
        self.inputTextField.placeholder = placeholder ?? "请输入"
        leftBar = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(leftBarButtonItemClick(_:)))
        self.navigationItem.leftBarButtonItem = leftBar
        rightBar = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(rightBarButtonItemClick(_:)))
        self.navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc func leftBarButtonItemClick(_ sender: UIBarButtonItem ) {
        self.navigationController?.popViewController(animated: true)
        //        dismiss(animated: true, completion: nil)
    }
    
    @objc func rightBarButtonItemClick(_ sender: UIBarButtonItem ) {
        self.view.endEditing(true)
        if self.navTitle == "设置头像" {
            myViewModel.headImg = self.inputText ?? ""
            self.updateUserMsg(at:IndexPath(row: 0, section: 0))
        }else if self.navTitle == "设置备注名"{
            myViewModel.piRmkName = self.inputText ?? ""
            self.updateUserMsg(at:IndexPath(row: 1, section: 0))

        }else if self.navTitle == "设置姓名"{
            myViewModel.usrFullName = self.inputText ?? ""
            self.updateUserMsg(at:IndexPath(row: 2, section: 0))
            
        }else if self.navTitle == "设置性别"{
            myViewModel.sex = self.inputText ?? ""
            self.updateUserMsg(at:IndexPath(row: 3, section: 0))
        }
    }
    
    func updateUserMsg(at indexPath: IndexPath) -> Void {
        ShowHUD.showHUDLoading()
        var fieldType: FieldType = .cprRelp
        if indexPath.row == 0 {
            fieldType = .headImg
        }else if indexPath.row == 1{
            fieldType = .piRmkName
        }else if indexPath.row == 2{
            fieldType = .usrFullName
        }else {
            fieldType = .sex
        }
        myViewModel.updatePersonalInfo(fieldType) {
            ShowHUD.hiddenHUDLoading()
            if self.inputComplete != nil {
                self.inputComplete!(self.inputText ?? "")
            }
            self.navigationController?.popViewController(animated: true)
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    } 
}

extension HFOneLineInputViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text:String = textField.text else{
            return true
        }
        let textLength = text.count + string.count - range.length
        if self.maxLength == 0 {
            return true
        }else{
            return textLength <= self.maxLength
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.inputText = textField.text
    }
}
