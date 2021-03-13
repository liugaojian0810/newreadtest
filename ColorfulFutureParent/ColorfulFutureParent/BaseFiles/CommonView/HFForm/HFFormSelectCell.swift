//
//  HFFormSelectCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFFormSelectCell: UITableViewCell {

    @IBOutlet weak var formTitleLabel: UILabel!
    @IBOutlet weak var formContentTextField: UITextField!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var model: HFFormSelectCellModel? {
        didSet {
            formTitleLabel.text = model?.title
            formTitleLabel.font = model?.titleFont
            formTitleLabel.textColor = model?.titleColor
            formContentTextField.text = model?.contentText
            formContentTextField.font = model?.contentFont
            formContentTextField.textColor = model?.contentColor
            formContentTextField.placeholder = model?.placeholder
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
