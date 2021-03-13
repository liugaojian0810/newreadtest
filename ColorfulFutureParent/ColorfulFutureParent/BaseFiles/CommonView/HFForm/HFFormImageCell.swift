//
//  HFFormImageCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2020/11/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFFormImageCell: UITableViewCell {

    @IBOutlet weak var leftConstraint: NSLayoutConstraint! // 标题左边间距
    @IBOutlet weak var formTitleLabel: UILabel!
    @IBOutlet weak var formImageView: UIImageView!
    @IBOutlet weak var arrowImageVIew: UIImageView!
    
    @IBOutlet weak var imageRightConstraint: NSLayoutConstraint!
    
    var model: HFFormImageCellModel? {
        didSet {
            formTitleLabel.text = model?.title
            formTitleLabel.font = model?.titleFont
            formTitleLabel.textColor = model?.titleColor
            arrowImageVIew.isHidden = model?.onlyShow == true
            isUserInteractionEnabled = model?.onlyShow == false
            leftConstraint.constant = model?.leftMargin ?? 0
            imageRightConstraint.constant = model?.onlyShow == true ? (16) : (40)
            if model?.image != nil {
                formImageView.image = model?.image
            }else{
                formImageView.image = model?.placeholder
                if model?.imageUrl != "" {
                    formImageView.kf.setImage(with: URL.init(string: model?.imageUrl ?? ""))
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
