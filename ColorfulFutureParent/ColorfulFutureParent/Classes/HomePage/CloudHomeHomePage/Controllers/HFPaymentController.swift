//
//  HFPaymentController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/26.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

enum PaymentGoodType {
    case goldCard //金卡
    case cloudHome //云家园
}

class HFPaymentController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //    lazy var footer: HFReadAgreementFooterView = {
    //
    //        let footer = Bundle.main.loadNibNamed("HFReadAgreementFooterView", owner: nil, options: nil)?.last as! HFReadAgreementFooterView
    //        footer.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 40)
    //        return footer
    //    }()
    
    lazy var tips = [["商品名称", "商品金额", "待支付金额"], [""]]
    
    lazy var contents = [["金卡会员", "2020-09-22 至 2020-12-22", "￥899.00"], [""]]
    
    var goodType: PaymentGoodType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    func config() -> Void {
        self.title = "支付"
        //        self.sizeStr = self.myViewModel.calcuSpace()
        //        self.letoutBtn.layer.borderColor = UIColor.colorWithHexString("DBDBDB").cgColor
        //        self.letoutBtn.layer.borderWidth = 1.0
        //        self.letoutBtn.layer.cornerRadius = 20
        //        self.letoutBtn.layer.masksToBounds = true
        //        self.tableView.tableFooterView = self.footer
        self.tableView.register(byIdentifiers: ["HFSemesterEditCell", "HFValidityPeriodCell"])
        self.tableView.reloadData()
        
    }
    
    @IBAction func purchase(_ sender: UIButton) {
        
        let vc = HFPurcheSuccessController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        HFAlert.show(withMsg: "支付成功", in: self, alertStatus: AlertStatusSuccfess)
        //        HFAlert.show(withMsg: "支付失败", in: self, alertStatus: AlertStatusSuccfess)
    }
}

extension HFPaymentController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.goodType == PaymentGoodType.goldCard) ? self.tips[0].count : self.tips[1].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFSemesterEditCell") as! HFSemesterEditCell
            let arr = (self.goodType == PaymentGoodType.goldCard) ? self.tips[0] : self.tips[1]
            cell.tipLabel.text = arr[indexPath.row]
            let contentArr = (self.goodType == PaymentGoodType.goldCard) ? self.contents[0] : self.contents[1]
            cell.textField.text = contentArr[indexPath.row]
            cell.switchBgView.isHidden = true
            cell.textField.isEnabled = false
            cell.arrowImgView.isHidden = true
            cell.arrowRightConstrint.constant = 0
            return cell

        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFValidityPeriodCell") as! HFValidityPeriodCell
            return cell
        }
    }
}


extension HFPaymentController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 40
        default:
            return 127
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.getSectionHead(with: 12, .colorWithHexString("F6F6F6"))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}



