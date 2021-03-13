//
//  HFPersonalDataController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPersonalDataController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var myViewModel = HFMineViewModel()
    var headImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    private func config() {
        self.title = "个人资料"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "宝宝档案", style: .done, target: self, action: #selector(babyArchivers(_:)))
        self.tableView.register(byIdentifiers: ["HFComEditCell", "HFMembersFamilyListCell"])
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPersonCenterInfo()
    }
    
    
    /// 获取个人中心信息
    /// - Returns: 无
    func getPersonCenterInfo() -> Void {
        
        myViewModel.getPersonCenterInfo {
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        } _: {
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        }
    }
    
    
    /// 宝宝档案
    /// - Parameter sender: 按钮
    /// - Returns: 无
    @objc func babyArchivers(_ sender: UIBarButtonItem) -> Void {
        if HFBabyViewModel.shared.currentBaby == nil {
            AlertTool.showCenter(withText: "暂无宝宝信息")
        }else{
            let baby = HFBabyArchivesController()
            self.navigationController?.pushViewController(baby, animated: true)
        }
    }
}

extension HFPersonalDataController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myViewModel.tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
        cell.tipLabel.text = myViewModel.tips[indexPath.row]
        cell.lineView.isHidden = false
        cell.textField.isHidden = false
        cell.contentView.isHidden = false
        switch indexPath.row {
        case 0:
            cell.textField.isHidden = true
            cell.headImg.isHidden = false
            cell.headImg.kf.setImage(with: URL(string: myViewModel.contents[indexPath.row]))
        case 3:
            cell.contentView.isHidden = (HFBabyViewModel.shared.currentBaby == nil) ? true : false
            cell.textField.text = (HFBabyViewModel.shared.currentBaby == nil) ? "" : HFBabyViewModel.shared.currentBaby?.dicFieldName
        default:
            cell.textField.text = myViewModel.contents[indexPath.row]
            cell.headImg.isHidden = true
        }
        return cell
    }
}


extension HFPersonalDataController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            if HFBabyViewModel.shared.currentBaby == nil {
                return 0
            }else{
                return 60
            }
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 13
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 10))
        headView.backgroundColor = .colorWithHexString("f7f7f7")
        return headView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.updateMsgWithIndexPath(indexPath)
        
    }
    
    
    /// 更新个人信息
    /// - Parameter indexPath: 下标
    /// - Returns: 无
    func updateMsgWithIndexPath(_ indexPath: IndexPath) -> Void {
        switch indexPath.row {
        case 0:
            print("")
            /// 设置头像
            self.selelctHeader()
        case 1:
            print("姓名")
            /// 设置姓名
            let vc = HFOneLineInputViewController()
            vc.navTitle = "设置姓名";
            vc.placeholder = "请输入姓名";
            vc.inputText = self.myViewModel.contents[1]
            vc.inputComplete = { conStr in
                Asyncs.async({
                    self.myViewModel.setInfo(at: indexPath, with: conStr)
                }) {self.tableView.reloadData()}
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("性别")
            /// 设置性别
            CGXPickerView.showStringPicker(withTitle: "性别", dataSource: ["男", "女"], defaultSelValue: nil, isAutoSelect: false, manager: nil) { (value, index) in
                self.myViewModel.sex = value as! String
                if value as! String == "男" {
                    self.updateSexWithIndexPath(indexPath, 1)
                }else{
                    self.updateSexWithIndexPath(indexPath, 2)
                }
            }
        case 3:
            /// 与宝宝的关系 如果新用户没有宝宝 则不可点击
            if self.myViewModel.personCenterInfo?.cprRelp.length() ?? 0 > 0 {
                /// 与宝宝的关系
                HFSelectorTools.selectorPubDict(type: .Childrels, refresh: true) { (infoModel) in
                    self.myViewModel.cprRelp = infoModel.dicFieldCode
                    self.myViewModel.updatePersonalInfo(.cprRelp) {
                        Asyncs.async({
                        }) {
                            HFBabyViewModel.shared.currentBaby?.dicFieldName = infoModel.dicFieldName
                            self.myViewModel.contents[3] = infoModel.dicFieldName
                            self.tableView.reloadData()
                        }
                    } _: {
                        self.myViewModel.cprRelp = ""
                    }
                }
            }
        default:
            /// 设置备注名
            let vc = HFOneLineInputViewController()
            vc.navTitle = "设置备注名";
            vc.placeholder = "请输入备注名";
            vc.inputText = self.myViewModel.contents[4]
            vc.inputComplete = { conStr in
                Asyncs.async({
                    self.myViewModel.setInfo(at: indexPath, with: conStr)
                }) {
                    self.tableView.reloadData()
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /// 修改性别
    /// - Parameters:
    ///   - indexPath: 下标
    ///   - value: 值
    /// - Returns: 无
    func updateSexWithIndexPath(_ indexPath: IndexPath, _ value: Int) -> Void {
        if (value == 2) {
            // 女
            self.myViewModel.sex = "2";
        }
        if (value == 1) {
            // 男
            self.myViewModel.sex = "1";
        }
        self.myViewModel.updatePersonalInfo(.sex) {
            AlertTool.showBottom(withText: "修改成功", duration: 2)
            print("选择性别 ： %@",(value)); //2是女 1是男 0是未知
            if (value == 1) {
                self.myViewModel.setInfo(at: indexPath, with: "1")
            }else{
                self.myViewModel.setInfo(at: indexPath, with: "2")
            }
            Asyncs.async({
                
            }) {
                self.tableView.reloadData()
            }
        } _: {
            
        }
    }
    
    /// 选择照片
    func selelctHeader() {
        let selectImg = HFSelectHeaderImageViewController()
        selectImg.selectClosure = { img in
            self.headImg = img
            self.uploadHeader()
        }
        selectImg.modalPresentationStyle = .overFullScreen
        self.present(selectImg, animated: true, completion: {})
    }
    
    /// 上传照片
    func uploadHeader() {
        
        HFPubRequest.uploadImage(images: [self.headImg!]) { (progress) in
            print(progress)
        } successed: { (modelArr) in
            let model = modelArr.first
            self.updateHeader(model?.fiAccessPath ?? "")
        } failured: { (error) in
        }
    }
    
    /// 更新头像显示与本地路径更新
    func updateHeader(_ str: String) -> Void {
        self.myViewModel.headImg = str
        self.myViewModel.updatePersonalInfo(.headImg) {
            AlertTool.showBottom(withText: "更新成功", duration: 2)
            Asyncs.async({
//                self.myViewModel.setInfo(at: IndexPath(row: 0, section: 0), with: str)
            }) {
                self.tableView.reloadData()
            }
        } _: {
            
        }
    }
}

