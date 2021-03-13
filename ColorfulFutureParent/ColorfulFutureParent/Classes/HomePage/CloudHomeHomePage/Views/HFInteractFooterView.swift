//
//  HFInteractFooterView.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/2/27.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFInteractFooterView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
