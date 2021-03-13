//
//  HFBabySectionHeaderView.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFBabySectionHeaderView: UITableViewCell {

    @IBOutlet weak var vLineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vLineView.jk_setRoundedCorners(.allCorners, radius: 1.75)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
