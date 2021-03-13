//
//  HFExactlyView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/12.
//  Copyright © 2020 huifan. All rights reserved.
//  到底啦

import UIKit

class HFExactlyView: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func create() -> HFExactlyView {
        
        let exactlyView = Bundle.main.loadNibNamed("HFExactlyView", owner: nil, options: nil)?.last as! HFExactlyView
        exactlyView.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 78)
        return exactlyView
        
    }
    
    
}
