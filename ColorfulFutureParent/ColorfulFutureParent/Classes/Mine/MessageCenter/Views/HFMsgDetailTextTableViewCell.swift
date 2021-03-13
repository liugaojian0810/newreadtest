//
//  HFMsgDetailTextTableViewCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/7.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMsgDetailTextTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
