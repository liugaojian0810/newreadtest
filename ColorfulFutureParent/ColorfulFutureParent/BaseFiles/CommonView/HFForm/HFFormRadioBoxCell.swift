//
//  HFFormRadioBoxCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFFormRadioBoxCell: UITableViewCell {

    @IBOutlet weak var formTitleLabel: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    var model: HFFormRadioBoxCellModel? {
        didSet {
            formTitleLabel.text = model?.title
            formTitleLabel.font = model?.titleFont
            formTitleLabel.textColor = model?.titleColor
            if model?.selectedIndex != selectedIndex {
                self.selectedIndex = model?.selectedIndex ?? -1
            }
            leftBtn.setTitle(model?.leftRadioName, for: .normal)
            rightBtn.setTitle(model?.rightRadioName, for: .normal)
        }
    }
    
    var selectedIndex: Int = -1 {
        didSet {
            self.leftBtn.isSelected = selectedIndex == 0
            self.rightBtn.isSelected = selectedIndex == 1
            self.model?.selectedIndex = selectedIndex
            if self.selectComplete != nil {
                self.selectComplete!(selectedIndex)
            }
        }
    }
    
    var selectComplete:((_ selectIndex: Int) -> ())?
    
    @IBAction func clickLeft(_ sender: UIButton) {
        self.selectedIndex = 0
    }
    
    @IBAction func clickRight(_ sender: UIButton) {
        self.selectedIndex = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        leftBtn.jk_setImagePosition(.LXMImagePositionLeft, spacing: 8)
        rightBtn.jk_setImagePosition(.LXMImagePositionLeft, spacing: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
