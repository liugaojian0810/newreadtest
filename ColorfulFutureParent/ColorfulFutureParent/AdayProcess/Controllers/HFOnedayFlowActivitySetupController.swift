//
//  HFOnedayFlowActivitySetupController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/23.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HFOnedayFlowActivitySetupController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myViewModel = HFOnedayFlowViewModel()
    var model: OnedayFlowDppafListModel?
    var activity: OnedayFlowActivityModel?
    var confirmClosure: ((OnedayFlowActivityModel?)->())?
    
    @IBOutlet weak var saveBtn: UIButton!
    lazy var head: HFHomePageSectionHead  = {
        let head = Bundle.main.loadNibNamed("HFHomePageSectionHead", owner: nil, options: nil)?.last as! HFHomePageSectionHead
        head.tipLabel.text = model?.grName
        head.tipLabel?.textColor = .colorWithHexString("333333")
        head.tipLabel.font = UIFont.semiboldFont(ofSize: 18)
        head.moreBtn.isHidden = true
        return head
    }()
    
    lazy var footer: HFPubEmptyPageView = {
        let footer = HFPubEmptyPageView.initEmptyViewType(.isNoClass)
        footer.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 300)
        footer.btn.isHidden = true
        footer.tip.text = "还什么都没有哦～"
        return footer
    }()
    
    
    var tips = [["开始时间", "结束时间"], ["活动安排", "Other"]]
    var placehoudles = [["请选择", "请选择"], ["请选择", "erhtO"]]
    var beginTime: String = ""
    var endTime: String = ""
    var activityName: String = ""
    var grName: String = ""
    var grId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginTime = model?.dpkStartTime ?? ""
        endTime   = model?.dpkEndTime   ?? ""
        activityName = model?.dppName   ?? ""
        config()
        activitysList()
    }
    
    func config() -> Void {
        
        self.title = "活动设置"
        self.tableView.register(byIdentifiers: ["HFComEditAtTextView", "HFAuthEditCell"])
        self.tableView.registerUnXib(byIdentifiers: ["UITableViewCell"])
        self.tableView.tableFooterView = self.footer
        self.tableView.reloadData()
    }
    
    func activitysList() -> Void {
        myViewModel.getOnedayFlowActivitys({
            Asyncs.async({
                
            }) {
                if let m = self.model, let plist = m.pfList {
                    if plist.count != 0 {
                        self.tableView.tableFooterView = nil
                    } else {
                        self.tableView.tableFooterView = self.footer
                    }
                }
            }
        }) {
            
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if let m = self.model {
            if m.pfList == nil {
                ShowHUD.showHUD(withInfo: "请选择活动安排")
                return
            }
            if m.dpkStartTime.isEmptyStr(){
                ShowHUD.showHUD(withInfo: "请选择开始时间")
                return
            }
            if m.dpkEndTime.isEmptyStr() {
                ShowHUD.showHUD(withInfo: "请选择结束时间")
                return
            }
            if self.confirmClosure != nil, let m = model {
                // 判断当前值是否有改变
                if self.beginTime != m.dpkStartTime ||
                    self.endTime  != m.dpkEndTime ||
                    self.activityName != m.dppName {
                    m.isChange = true
                } else {
                    m.isChange = false
                }
                
                self.confirmClosure!(self.activity ?? nil)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension HFOnedayFlowActivitySetupController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tips[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFAuthEditCell") as! HFAuthEditCell
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HFAuthEditCell") as! HFAuthEditCell
                return cell
            }else{
                if self.model?.pfList != nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditAtTextView") as! HFComEditAtTextView
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
                    return cell!
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let disCell = cell as! HFAuthEditCell
            disCell.tipLabel?.text = tips[indexPath.section][indexPath.row]
            disCell.textField?.placeholder = placehoudles[indexPath.section][indexPath.row]
            if indexPath.row == 0{
                disCell.textField?.text = model?.dpkStartTime
            }else{
                disCell.textField?.text = model?.dpkEndTime
            }
            disCell.arrIntoImg?.isHidden = false
            disCell.textField?.isEnabled = false
        default:
            if indexPath.row == 0 {
                let disCell = cell as! HFAuthEditCell
                disCell.tipLabel?.text = tips[indexPath.section][indexPath.row]
                disCell.textField?.placeholder = placehoudles[indexPath.section][indexPath.row]
                disCell.textField?.text = self.activity?.dppName ?? self.activityName
                disCell.textField?.isEnabled = false
                disCell.arrIntoImg?.isHidden = false
            }else{
                if self.model?.pfList != nil {
                    let disCell = cell as! HFComEditAtTextView
                    disCell.textView.text = getActivityStepsDes()
                    disCell.textView.isEditable = false
                }
            }
        }
    }
    
    func getActivityStepsDes() -> String {
        var des = ""
        if let pList = self.model?.pfList {
            for (index, seg) in pList.enumerated() {
                if index == pList.count - 1 {
                    des.append(seg.pfInfo)
                    des.append("\n")
                } else {
                    des.append(seg.pfInfo)
                }
            }
        }
        return des
    }
}

extension HFOnedayFlowActivitySetupController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        tips.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 && indexPath.row == 1 {
            if self.model?.pfList == nil {
                return 0.0
            }else{
                return 273
            }
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 57
        default:
            return 12
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            
            return head
        default:
            
            return self.getSectionHead(with: 12, .colorWithHexString("F6F6F6"))
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                CGXPickerView.showDatePicker(withTitle: "开始时间", dateType: .time, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: false, manager: nil) { (value ) in
                    print("开始时间-----------\(value ?? "")")
                    self.model?.dpkStartTime = value ?? ""
                    self.tableView.reloadData()
                }
            }else{
                CGXPickerView.showDatePicker(withTitle: "结束时间", dateType: .time, defaultSelValue: nil, minDateStr: nil, maxDateStr: nil, isAutoSelect: false, manager: nil) { (value ) in
                    print("结束时间-----------\(value ?? "")")
                    self.model?.dpkEndTime = value ?? ""
                    self.tableView.reloadData()
                }
            }
        default:
            if indexPath.row == 0 {
                let vc = HFClassSelectController()
                vc.activitys = self.myViewModel.activitys
                vc.showType = .acticity
                vc.selClosure = { index in
                    if index == -1 {
                        self.activity = nil
                        self.model?.pfList = nil
                    }else{
                        self.activity = self.myViewModel.activitys[index]
                        self.model?.pfList = self.activity?.projectFlowGetResultList
                        self.model?.dppId = self.activity?.dppId ?? ""
                        self.model?.dppName = self.activity?.dppName ?? ""
                    }
                    if self.activity == nil {
                        self.tableView.tableFooterView = self.footer
                    }else{
                        self.tableView.tableFooterView = nil
                    }
                    self.tableView.reloadData()
                }
                self.present(vc, animated: true, completion: {})
            }
        }
    }
}

