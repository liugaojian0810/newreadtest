//
//  HFBabyArchivesController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/12.
//  Copyright © 2020 huifan. All rights reserved.
//  

import UIKit

class HFBabyArchivesController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var personInfo: HFPersonInfoHeaderView = {
        let personInfo = Bundle.main.loadNibNamed("HFPersonInfoHeaderView", owner: nil, options: nil)?.last as! HFPersonInfoHeaderView
        personInfo.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 176)
        return personInfo
    }()
    
    var myViewModel = HFMineViewModel()
    
//    lazy var footerView = HFExactlyView.create()
    
//    lazy var edit: Bool = false
    
//    lazy var rightBarBtn: UIBarButtonItem = {
//
//        let rightBarBtn = UIBarButtonItem(title: "编辑信息", style: .done, target: self, action: #selector(rightBarBtnClick(_:)))
//        return rightBarBtn
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        getBabyArchivers()
    }
    
    private func config() {
        
        self.title = "宝宝档案"
        self.tableView.tableHeaderView = personInfo
//        self.tableView.tableFooterView = footerView
        self.tableView.register(byIdentifiers: ["HFComEditCell", "HFFamilyMembersInfoCell"])
        self.tableView.reloadData()
    }
    
    func getBabyArchivers() -> Void {
        myViewModel.getBabyDetail(ciId: HFBabyViewModel.shared.currentBaby?.ciId ?? "") {
            Asyncs.async({
                
            }) {
                self.updateUserInfo()
                self.tableView.reloadData()
            }
        } _: {}
    }
    
    func updateUserInfo() -> Void {
        
        self.personInfo.nameLabel.text = self.myViewModel.babyModel?.baseChildInfo?.ciName ?? ""
        var des = ""
        if self.myViewModel.babyModel?.baseChildInfo?.ciSex == 1 { //男
            self.personInfo.headImg.kf.setImage(with: URL(string: self.myViewModel.babyModel?.baseChildInfo?.headImg ?? ""), placeholder: UIImage(named: "default_icon_baby_man"))
            des = "男 ｜ " + String.caculateAgeY(birthday: self.myViewModel.babyModel?.baseChildInfo?.ciBirth ?? "") + "岁"
        }else if self.myViewModel.babyModel?.baseChildInfo?.ciSex == 2{ //女
            self.personInfo.headImg.kf.setImage(with: URL(string: self.myViewModel.babyModel?.baseChildInfo?.headImg ?? ""), placeholder: UIImage(named: "default_icon_baby_women"))
            des = "女 ｜ " + String.caculateAgeY(birthday: self.myViewModel.babyModel?.baseChildInfo?.ciBirth ?? "") + "岁"
        }else{ //未知
            self.personInfo.headImg.kf.setImage(with: URL(string: self.myViewModel.babyModel?.baseChildInfo?.headImg ?? ""), placeholder: UIImage(named: "default_icon_baby_man"))
            des = "性别-- ｜ " + String.caculateAgeY(birthday: self.myViewModel.babyModel?.baseChildInfo?.ciBirth ?? "")  + "岁"
        }
        self.personInfo.desLabel.text = des
    }
}

extension HFBabyArchivesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            if self.myViewModel.babyModel == nil {
                return 0
            }
            return self.myViewModel.babyModel?.baseParentInfoList.count ?? 0
        default:
            if self.myViewModel.babyModel == nil {
                return 0
            }
            return self.myViewModel.babyArchiverTips[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFFamilyMembersInfoCell") as! HFFamilyMembersInfoCell
           let parent = self.myViewModel.babyModel?.baseParentInfoList[indexPath.row]
            cell.usrNameLabel.text = parent?.baseParentUserResult?.usrFullName
            cell.phoneLabel.text = parent?.baseParentUserResult?.usrPhone
            cell.workUnitslabel.text = parent?.baseParentInfoResult?.piWorkPlace
            cell.relationLabel.text = parent?.cprRelpName
            if parent?.cprDef == 1 {
                cell.firstRelationLabel.isHidden = false
            }else{
                cell.firstRelationLabel.isHidden = true
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
            cell.lineView.isHidden = false
            cell.contentView.backgroundColor = .white
            let tips = self.myViewModel.babyArchiverTips[indexPath.section]
            cell.tipLabel.text = tips[indexPath.row]
            cell.textField.text = self.myViewModel.getStr(at: indexPath)
            cell.textField.isEnabled = false
            cell.arrowIntoImg.isHidden = true
            cell.arrowRightConstrint.constant = 0
            return cell
        }

    }
}


extension HFBabyArchivesController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.myViewModel.sectionTips.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 1:
            return 143
        default:
            if indexPath.section == 3 {
                
                if indexPath.row == 3 {
                    let str = self.myViewModel.getStr(at: indexPath)
                    if str.length() > 0 {
                        return 30
                    }else{
                        return 0
                    }
                }else if indexPath.row == 5 {
                    let str = self.myViewModel.getStr(at: indexPath)
                    if str.length() > 0 {
                        return 30
                    }else{
                        return 0
                    }
                }else if indexPath.row == 7 {
                    let str = self.myViewModel.getStr(at: indexPath)
                    if str.length() > 0 {
                        return 30
                    }else{
                        return 0
                    }
                }
            }
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 73
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let head = HFConmTableHeadView.create()
        head.tipLabel.text = self.myViewModel.sectionTips[section]
        return head
    }
    
}

