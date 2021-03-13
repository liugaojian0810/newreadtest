//
//  HFPersonInfoHeaderView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/12.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPersonInfoHeaderView: UITableViewCell {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImg.setBorder(3, .white)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
