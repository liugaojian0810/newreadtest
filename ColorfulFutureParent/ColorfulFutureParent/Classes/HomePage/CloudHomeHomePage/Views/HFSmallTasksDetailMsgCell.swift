//
//  HFSmallTasksDetailMsgCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSmallTasksDetailMsgCell: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var topupBtn: UIButton! // 充值按钮，默认隐藏
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
