//
//  HFApplyDestroy.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFApplyDestroy: UITableViewCell {
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    typealias HFApplyDestroySlosure = ()->Void
    public var nextClosure :HFApplyDestroySlosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nextButton.alpha = 0.39
        nextButton.isUserInteractionEnabled = false
        // Initialization code
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        self.frame = CGRect(x: 15, y: 0, width: 352 - 30, height: 200)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func nextClick(_ sender: UIButton) {
        if (nextClosure != nil) {
            nextClosure!()
        }
    }
    
}
