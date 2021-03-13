//
//  HFCardPackageSubItem.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/3/2.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFCardPackageSubItem: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    /// 卡号
    @IBOutlet weak var cardNoLabel: UILabel!
    /// 使用期限
    @IBOutlet weak var usePeriodLabel: UILabel!
    /// 过期时间
    @IBOutlet weak var dueTimeLabel: UILabel!
    /// 使用状态
    @IBOutlet weak var stateLabel: UILabel!
    /// 点击回调
    var clickClosure: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cardPackage: HFMemCardPackageItem? = nil {
        didSet {
            if cardPackage != nil {
                bgImageView.kf.setImage(with: URL(string: cardPackage?.mcImg ?? ""))
                cardNoLabel.text = cardPackage?.mcId
                if cardPackage?.mcpdUseStatus == 0 {
                    stateLabel.text = "未使用"
                }else if cardPackage?.mcpdUseStatus == 1 {
                    stateLabel.text = "已使用"
                }else{
                    stateLabel.text = "已作废"
                }
                let str = "使用期限\(cardPackage?.mcTermValidity ?? 0)天"
                usePeriodLabel.text = str
                dueTimeLabel.text = (cardPackage?.mcpdActivationTermTime ?? "") + "到期"
            }
        }
    }
    
    
    /// 使用按钮点击
    @IBAction func useBtn(_ sender: UIButton) {
        if clickClosure != nil {
            self.clickClosure!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
