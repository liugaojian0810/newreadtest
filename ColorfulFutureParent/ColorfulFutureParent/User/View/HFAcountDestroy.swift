//
//  HFAcountDestroy.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/20.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFAcountDestroy: UITableViewCell {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var agreeButton: UIButton!

    typealias HFAcountDestroySlosure = ()->Void
    
   public var nextClosure :HFAcountDestroySlosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nextButton.alpha = 0.39
        nextButton.isUserInteractionEnabled = false
        // Initialization code
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        self.frame = CGRect(x: 15, y: 0, width: 352 - 30, height: 220)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func agree(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            nextButton.alpha = 1
            nextButton.isUserInteractionEnabled = true
        }else{
            nextButton.alpha = 0.39
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func nextClick(_ sender: UIButton) {
        if (nextClosure != nil) {
            nextClosure!()
        }
    }
}
