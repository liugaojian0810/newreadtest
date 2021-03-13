//
//  HFSubscribeHintView.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//
// 预约提醒弹窗

import UIKit

class HFSubscribeHintView: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var totalNumberLab: UILabel! // 总共需要宝石数
    @IBOutlet weak var needNumberLab: UILabel! // 优惠后所需宝石数
    @IBOutlet weak var balanceLab: UILabel! // 我的宝石余额
    @IBOutlet weak var surplusLab: UILabel! // 结算后剩余宝石
    
    var clickCancel: OptionClosure?
    var clickSure: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .init(white: 0, alpha: 0.5)
        self.backgroundColor = UIColor.clear
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if self.clickCancel != nil {
            self.clickCancel!()
        }
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if self.clickSure != nil {
            self.clickSure!()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
