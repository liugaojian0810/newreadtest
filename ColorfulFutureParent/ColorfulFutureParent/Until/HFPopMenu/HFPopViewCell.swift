//
//  HFPopViewCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/11.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPopViewCell: UITableViewCell {
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    var model: HFPopViewModel? {
        didSet{
            if model?.imageName != nil {
                self.imageView?.image = UIImage.init(named: model?.imageName ?? "")
                self.leftConstraint.constant = 44
            }else{
                self.leftConstraint.constant = 16
            }
            self.titleLab.text = model?.title
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
