//
//  HFInteractiveCampsEmptyCell.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/3/8.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFInteractiveCampsEmptyCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
