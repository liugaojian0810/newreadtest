//
//  HFImmediatePaymentView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/15.
//  Copyright © 2020 huifan. All rights reserved.
//。立即支付

import UIKit

class HFImmediatePaymentView: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderBtn: UIButton!
    
    var orderClosure: OptionBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   static func create() -> HFImmediatePaymentView {
        
        let immediatePayment = Bundle.main.loadNibNamed("HFImmediatePaymentView", owner: nil, options: nil)?.last as! HFImmediatePaymentView
        return immediatePayment
    }
    
   static func create(_ frame: CGRect) -> HFImmediatePaymentView {
        
        let immediatePayment = Bundle.main.loadNibNamed("HFImmediatePaymentView", owner: nil, options: nil)?.last as! HFImmediatePaymentView
        immediatePayment.frame = frame
        return immediatePayment
    }
    
    @IBAction func order(_ sender: UIButton) {
        
        if orderClosure != nil {
            orderClosure!()
        }
    }
}
