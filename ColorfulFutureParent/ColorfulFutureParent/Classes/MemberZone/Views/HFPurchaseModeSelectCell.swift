//
//  HFPurchaseModeSelectCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPurchaseModeSelectCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var selBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
                    selBtn.isSelected = true

//            selBtn.setImage(UIImage(named: "member_noSelected"), for: .normal)
        }else{
            selBtn.isSelected = false

//            selBtn.setImage(UIImage(named: "member_selected"), for: .normal)
        }
        // Configure the view for the selected state
    }
    
    @IBAction func selectBtn(_ sender: UIButton) {
        
//        sender.isSelected = !sender.isSelected
    }
    
}
