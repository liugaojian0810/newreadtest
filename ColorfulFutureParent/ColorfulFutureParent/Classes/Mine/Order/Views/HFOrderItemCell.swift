//
//  HFOrderItemCell.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/2/1.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFOrderItemCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    @IBOutlet weak var desRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowImgView: UIImageView!
    
    var itemModel: HFOrdereItemModel? {
        didSet {
            titleLab.text = itemModel!.title
            desLab.text = itemModel!.text
            if itemModel!.attributedText != nil {
                desLab.attributedText = itemModel!.attributedText
            }else{
                desLab.textColor = .hexColor(0x666666)
            }
            arrowImgView.isHidden = !itemModel!.showArrow
            desRightConstraint.constant = itemModel!.showArrow ? 50 : 31
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        arrowImgView.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
