//
//  HFCommButton.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFCommButton: UITableViewCell {

    var clickClosure: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func click(_ sender: UIButton) {
        if self.clickClosure != nil {
            self.clickClosure!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
