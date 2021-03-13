//
//  HFSchduleWeekSelectView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSchduleWeekSelectView: UITableViewCell {

    @IBOutlet weak var enterImg: UIImageView!
   @objc @IBOutlet weak var nameLabel: UILabel!

    typealias HFSchduleWeekSelectClosure = ()->Void

   @objc var selectClosure: HFSchduleWeekSelectClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
        if selectClosure != nil {
            selectClosure?()
        }
    }
}
