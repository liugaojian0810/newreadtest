//
//  HFHomePageSectionHead.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFHomePageSectionHead: UITableViewCell {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    var moreClosure: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.moreBtn.jk_setImagePosition(.LXMImagePositionRight, spacing: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func more(_ sender: Any) {
        
        if moreClosure != nil {
            moreClosure!()
        }
    }
    
    
}
