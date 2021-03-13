//
//  HFSelectTaskSectionFooterView.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/2/22.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFSelectTaskSectionFooterView: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var arrowBtn: UIButton!
    
    var selectOpen: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
    }
    
    @IBAction func clickArrow(_ sender: UIButton) {
        if selectOpen != nil {
            selectOpen!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
