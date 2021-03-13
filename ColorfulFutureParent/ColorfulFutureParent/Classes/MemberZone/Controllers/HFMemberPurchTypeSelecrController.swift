//
//  HFMemberPurchTypeSelecrController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit


class HFMemberPurchTypeSelecrController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var bottomView: HFImmediatePaymentView = {
     let bottom = HFImmediatePaymentView.create(CGRect(x: 0, y: S_SCREEN_HEIGHT - 61, width: S_SCREEN_WIDTH, height: 61))
return bottom
    }()
    
    lazy var moreBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 70)
        button.setTitle("更多支付方式", for: .normal)
        button.setTitleColor(.colorWithHexString("00A4FF"), for: .normal)
        button.backgroundColor = .colorWithHexString("FFFFFF")
        button.addTarget(self, action: #selector(moreBtnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    
    lazy var tips = ["苹果应用内付费", "苹果应用内付费", "苹果应用内付费"]
    var showAll: Bool = false
    var selIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        config()
    }
    
    
    func config() -> Void {
        
        self.title = "购买会员"
        self.view.addSubview(bottomView)
        self.bottomView.orderClosure = {
            
            let vc = HFPurcheSuccessController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.tableView.register(byIdentifiers: ["HFComEditCell", "HFHomePageSectionHeaderCell", "HFPurchaseModeSelectCell"])
    }
    
    ///更多按钮
    @objc func moreBtnClick(_ sender: UIButton) -> Void {
        
        self.showAll = true
        self.tableView.reloadData()
    }
    
    ///
    
}


extension HFMemberPurchTypeSelecrController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            
            return tips.count
            
        case 1:
            
            return 1
            
        default:
            
            if showAll == false {
                
                return 2
            }else {
                
                return 3
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
            cell.tipLabel.text = tips[indexPath.row]
            cell.arrowIntoImg.isHidden = true
            cell.textField.isEnabled = false
            switch indexPath.row {
            case 0:
                cell.textField.text = "开通金卡会员"
            case 1:
                cell.textField.text = "¥0.00"
            default:
                cell.textField.text = "¥0.00"
            }
            cell.arrowRightConstrint.constant = 0
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
            cell.tipLabel.text = "选择支付方式"
            cell.arrowIntoImg.isHidden = true
            cell.textField.isHidden = true
            cell.arrowRightConstrint.constant = 0
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFPurchaseModeSelectCell") as! HFPurchaseModeSelectCell
            switch indexPath.row {
            case 0:
                cell.tipLabel.text = "微信支付"
            case 1:
                cell.tipLabel.text = "支付宝支付"
            default:
                cell.tipLabel.text = "银行卡支付"
            }
            return cell
        }
    }
}


extension HFMemberPurchTypeSelecrController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            
            return 44
        case 1:
            
            return 44
        default:
            
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            
            return 12
        case 1:
            
            return 0
        default:
            if self.showAll == true {
                return 0
            }else{
                return 70
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let head = UIView(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 12))
            head.backgroundColor = .colorWithHexString("F6F6F6")
            return head
        case 1:
            return nil
        default:
            if self.showAll == true {
                return nil
            }else{
                return self.moreBtn
            }
        }
    }
}



