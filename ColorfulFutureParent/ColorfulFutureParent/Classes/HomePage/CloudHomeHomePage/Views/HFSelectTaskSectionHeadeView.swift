//
//  HFSelectTaskSectionHeadeView.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/2/22.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFSelectTaskSectionHeadeView: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
        bgView.width = ScreenWidth - 30
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.jk_setRoundedCorners([.topLeft,.topRight], radius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
