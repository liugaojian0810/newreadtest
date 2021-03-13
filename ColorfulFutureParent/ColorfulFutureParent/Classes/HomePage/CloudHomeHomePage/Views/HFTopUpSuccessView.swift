//
//  HFTopUpSuccessView.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//
// 充值成功弹窗

import UIKit

class HFTopUpSuccessView: UITableViewCell {

    @IBOutlet weak var textLab: UILabel! // 描述文案
    
    var topupNumber = NSDecimalNumber(string: "0.00") {
        didSet {
            let mAtb = NSMutableAttributedString.init(string: "恭喜你，成功充值 ", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
            let a1tb = NSAttributedString.init(string: "\(topupNumber)枚", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xFF973F),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
            mAtb.append(a1tb)
            let a2tb = NSAttributedString.init(string: " 五彩宝石！", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
            mAtb.append(a2tb)
            
            textLab.attributedText = mAtb
            textLab.sizeToFit()
        }
    }
    
    var clickSure: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .init(white: 0, alpha: 0.5)
        self.backgroundColor = UIColor.clear
    }

    @IBAction func sureAction(_ sender: UIButton) {
        self.removeFromSuperview()
        if clickSure != nil {
            clickSure!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
