//
//  HFHomePageSectionHeaderCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/13.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFHomePageSectionHeaderCell: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineViewLeading: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
