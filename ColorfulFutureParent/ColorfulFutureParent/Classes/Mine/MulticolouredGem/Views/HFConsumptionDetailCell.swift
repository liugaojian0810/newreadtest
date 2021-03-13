//
//  HFConsumptionDetailCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFConsumptionDetailCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var consumption: HFConsumptionDetailModel? = nil {
        didSet {
            if consumption != nil {
                nameLabel.text = consumption?.galTitle
                timeLabel.text = consumption?.createTime
                if consumption?.galHandleType == 1 {//操作类型 1=账户额度增加；2=账户额度减少
                    priceLabel.text = "+\(consumption?.galGemNum ?? 0)"
                    priceLabel.textColor = .colorWithHexString("FF844B")
                }else{
                    priceLabel.text = "-\(consumption?.galGemNum ?? 0)"
                    priceLabel.textColor = .colorWithHexString("0DCCA0")
                }

            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
