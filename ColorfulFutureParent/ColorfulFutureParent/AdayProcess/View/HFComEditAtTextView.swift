//
//  HFComEditAtTextView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/23.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFComEditAtTextView: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bgTopConstriant: NSLayoutConstraint!
    @IBOutlet weak var bgBottomConstriant: NSLayoutConstraint!
    @IBOutlet weak var bgLeftConstriant: NSLayoutConstraint!
    @IBOutlet weak var bgRightConstriant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
