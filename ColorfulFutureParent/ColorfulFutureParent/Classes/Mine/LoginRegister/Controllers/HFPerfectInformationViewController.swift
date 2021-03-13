//
//  HFPerfectInformationViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by wzz on 2020/11/3.
//  Copyright © 2020 huifan. All rights reserved.
//  完善信息

import UIKit

class HFPerfectInformationViewController: HFNewBaseViewController {

    @IBOutlet weak var topNum: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    let viewModel: HFPerfectInformationViewModel = HFPerfectInformationViewModel()
    
    @IBOutlet weak var saveBtn: UIButton!
    
    var headImg: UIImage?
    var imageUploadResultModel: HFImageUploadResultModel? // 头像上传结果数据模型
    
    lazy var tableHead: HFMineAccountHeaderView = {
        let tableHead = Bundle.main.loadNibNamed("HFMineAccountHeaderView", owner: self, options: nil)?.last as! HFMineAccountHeaderView
        tableHead.clickChange = {[weak self] in
            self!.selelctHeader()
        }
        return tableHead
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.requestData()
    }
    
    override func addSubViews() {
        title = "完善信息"
        tableView.register(byIdentifiers: ["HFFormOneLineInputCell","HFFormSelectCell","HFFormRadioBoxCell"])
        
        tableHead.frame = CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 148)
        tableView.tableHeaderView = tableHead
        
        self.saveBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        self.saveBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        self.saveBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    override func backBtnClieck(send: UIButton) {
        HFUserInformation.remove {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HFUserLogoutNotification"), object: nil)
        }
    }
    
    func requestData() -> Void {
        ShowHUD.showHUDLoading()
        viewModel.getFullUserInfo ({
            ShowHUD.hiddenHUDLoading()
            self.updateUI()
            self.tableView.reloadData()
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func selelctHeader() -> Void {
        let vc = HFSelectHeaderImageViewController()
        vc.selectClosure = { img in
            self.headImg = img
            self.tableHead.headImgView.image = img
            self.updateUI()
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if self.imageUploadResultModel == nil && (self.viewModel.userInfo != nil && self.viewModel.userInfo!.headImg.isEmpty) {
            ShowHUD.showHUDLoading()
            HFPubRequest.uploadImage(image: self.headImg!) { (progress) in
                print("\(progress)")
            } successed: { (res) in
                self.imageUploadResultModel = res.first
                self.viewModel.parameters["headImg"] = self.imageUploadResultModel?.fiAccessPath as AnyObject?
                self.saveInfo()
            } failured: { (error) in
                ShowHUD.hiddenHUDLoading()
            }
        }else{
            ShowHUD.showHUDLoading()
            saveInfo()
        }
    }
    
    func saveInfo() -> Void {
        viewModel.saveInfo({
            ShowHUD.hiddenHUDLoading()
            
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main_Parent", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            
//            [self.window setRootViewController:[[UIStoryboard  storyboardWithName:@"Main_Parent" bundle:nil]instantiateViewControllerWithIdentifier:@"TabBarController"]];
//            let vc = HFViewController()
//            let window = UIApplication.shared.keyWindow
//            window?.rootViewController = vc;
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func updateUI() -> Void {
        var disable = false
        for item in self.viewModel.perfectInformationArr {
            if let model = item as? HFFormRadioBoxCellModel {
                if model.isEmpty(){
                    disable = true
                    break
                }
            }else if let model = item as? HFFormTextInputCellModel {
                if model.isEmpty() {
                    disable = true
                    break
                }
            }else if let model = item as? HFFormSelectCellModel {
                if model.isEmpty() {
                    disable = true
                    break
                }
            }
        }
        if !disable {
            // 校验头像
            disable = (self.headImg == nil) && (self.viewModel.userInfo != nil && self.viewModel.userInfo!.headImg.isEmpty)
        }
        
//        if self.viewModel.userInfo != nil && !self.viewModel.userInfo!.headImg.isEmpty {
//            self.tableHead.headImgView.kf.setImage(with: URL.init(string: self.viewModel.userInfo!.headImg))
//        }
        if self.viewModel.userInfo != nil && !self.viewModel.userInfo!.headImg.isEmpty {
            if self.viewModel.userInfo?.usrSex == 1 {
                self.tableHead.headImgView.kf.setImage(with: URL.init(string: self.viewModel.userInfo!.headImg),placeholder: UIImage.getParentOfFather())
            }else if self.viewModel.userInfo?.usrSex == 2{
                self.tableHead.headImgView.kf.setImage(with: URL.init(string: self.viewModel.userInfo!.headImg),placeholder: UIImage.getParentOfMother())
            }else{
                self.tableHead.headImgView.image = UIImage.getParentOfMother()
            }
        }else{
//            if (self.headImg != nil) {
//                self.tableHead.headImgView.image = self.headImg
//            }else{
//                self.tableHead.headImgView.image = UIImage.getParentOfMother()
//            }
            
            if (self.headImg != nil) {
                self.tableHead.headImgView.image = self.headImg
            }else{
                let str = String(format: "%@", self.viewModel.parameters["usrSex"] as! CVarArg)
                if str == "1" {
                    self.tableHead.headImgView.image = UIImage.getParentOfFather()
                }else {
                    self.tableHead.headImgView.image = UIImage.getParentOfMother()
                }
            }
        }
        self.saveBtn.isEnabled = !disable
    }
}

extension HFPerfectInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        
        let model = self.viewModel.perfectInformationArr[indexPath.row]
        
        if let selectModel = model as? HFFormSelectCellModel {
            
            switch indexPath.row {
            case 3:
                HFSelectorTools.selectorYMD(maxDateIsToDay: true) { (selectDate, selectValue) in
                    selectModel.contentText = selectValue
                    self.viewModel.parameters["usrBirthday"] = selectModel.contentText as AnyObject?
                    self.updateUI()
                    self.tableView.reloadData()
                }
            default:
                print("")
            }
        }
    }
}

extension HFPerfectInformationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.perfectInformationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.viewModel.perfectInformationArr[indexPath.row]
        
        if let radioBoxModel = model as? HFFormRadioBoxCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFormRadioBoxCell", for: indexPath) as! HFFormRadioBoxCell
            cell.model = radioBoxModel
            cell.selectComplete = {[weak self] selectIndex in
                radioBoxModel.selectedIndex = selectIndex
                if selectIndex == 0 {
                    self!.viewModel.parameters["usrSex"] = "2" as AnyObject
                }else if selectIndex == 1{
                    self!.viewModel.parameters["usrSex"] = "1" as AnyObject
                }
                self!.updateUI()
            }
            return cell;
        }
        if let inputModel = model as? HFFormTextInputCellModel {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFormOneLineInputCell", for: indexPath) as! HFFormOneLineInputCell
//            cell.model = inputModel
//            cell.inputComplete = {[weak self] text in
//                inputModel.contentText = text
//                if let stringCount = inputModel.serverKey?.count, stringCount > 0 {
//                    self!.viewModel.parameters[inputModel.serverKey!] = inputModel.contentText as AnyObject
//                }
//                self!.updateUI()
//            }
//            return cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFormOneLineInputCell", for: indexPath) as! HFFormOneLineInputCell
            cell.model = inputModel
            cell.inputComplete = {[weak self] text in
                if indexPath.row == 0 {
                    inputModel.contentText = text
                    if let stringCount = inputModel.serverKey?.count, stringCount > 0 {
                        self!.viewModel.parameters[inputModel.serverKey!] = inputModel.contentText as AnyObject
                    }
                    self!.updateUI()
                    
                }else if indexPath.row == 1 {
                    
                    let tempModel = self!.viewModel.perfectInformationArr[indexPath.row - 1]
                    if let tempInputModel = tempModel as? HFFormTextInputCellModel  {
                        let tempCell = self?.tableView .cellForRow(at: IndexPath(row: indexPath.row - 1, section: indexPath.section)) as! HFFormOneLineInputCell
                        tempCell.model = tempInputModel
                        if tempInputModel.contentText?.substring(to: 1) == text.substring(to: 1) {
                            
                        }else{
                            var tempStr = ""
                            if text.length() > 0 {
                                tempStr = text.substring(to: 1).appending("家长")
                            }
                            tempInputModel.contentText = tempStr
                            if let stringCount = tempInputModel.serverKey?.count, stringCount > 0 {
                                self!.viewModel.parameters[tempInputModel.serverKey!] = tempInputModel.contentText as AnyObject
                            }
                        }
                    }
                    
                    inputModel.contentText = text
                    if let stringCount = inputModel.serverKey?.count, stringCount > 0 {
                        self!.viewModel.parameters[inputModel.serverKey!] = inputModel.contentText as AnyObject
                    }
                    self!.updateUI()
                }
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 12))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
