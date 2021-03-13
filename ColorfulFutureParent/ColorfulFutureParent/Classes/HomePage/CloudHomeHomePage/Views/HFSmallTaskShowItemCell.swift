//
//  HFSmallTaskShowItemCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/2/21.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFSmallTaskShowItemCell: UITableViewCell {

    @IBOutlet weak var numberLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    
    var index: Int = 0 {
        didSet {
            numberLab.text = String.numberString(index: index)
        }
    }
    
    var content: String = "" {
        didSet {
            contentLab.text = content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
