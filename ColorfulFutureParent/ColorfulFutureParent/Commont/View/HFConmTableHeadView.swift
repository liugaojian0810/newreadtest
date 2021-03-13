//
//  HFConmTableHeadView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/12.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFConmTableHeadView: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func create() -> HFConmTableHeadView {
        
        let head = Bundle.main.loadNibNamed("HFConmTableHeadView", owner: nil, options: nil)?.last as! HFConmTableHeadView
        head.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 73)
        return head
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
