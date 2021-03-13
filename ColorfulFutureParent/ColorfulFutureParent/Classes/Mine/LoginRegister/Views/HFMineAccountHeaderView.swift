//
//  HFMineAccountHeaderView.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMineAccountHeaderView: UITableViewCell {

    @IBOutlet public weak var headImgView: UIImageView!
    @objc public var clickChange: OptionClosure?
    
    @IBAction func click(_ sender: UIButton) {
        print("点击修改头像")
        if clickChange != nil {
            clickChange!()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
