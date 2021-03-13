//
//  HFBadgeMallBalanceViewCell.swift
//  ColorfulFutureParent
//
//  Created by 慧凡 on 2020/11/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBadgeMallBalanceViewCell: UITableViewCell {

    @IBOutlet weak var detailBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.detailBtn.jk_setImagePosition(.LXMImagePositionRight, spacing: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
