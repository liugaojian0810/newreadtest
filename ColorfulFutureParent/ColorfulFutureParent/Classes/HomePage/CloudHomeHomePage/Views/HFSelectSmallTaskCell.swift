//
//  HFSelectSmallTaskCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSelectSmallTaskCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectBtnClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
    }
}
