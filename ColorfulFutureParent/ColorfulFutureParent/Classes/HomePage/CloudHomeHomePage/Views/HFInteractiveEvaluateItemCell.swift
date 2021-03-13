//
//  HFInteractiveEvaluateItemCell.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/2/28.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFInteractiveEvaluateItemCell: UITableViewCell {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var model: HFInteractiveEvaluateItemModel? {
        didSet {
            itemNameLab.text = model?.ceName ?? "未知"
            starNum = model?.starNum ?? 0
        }
    }
    
    @IBOutlet weak var itemNameLab: UILabel!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    var canRes: Bool = false
    
    var starChangeBlock: OptionClosureInt?
    
    var starNum: Int = 0 {
        
        didSet{
            switch starNum {
            case 0:
                star1.isSelected = false
                star2.isSelected = false
                star3.isSelected = false
                star4.isSelected = false
                star5.isSelected = false
            case 1:
                star1.isSelected = true
                star2.isSelected = false
                star3.isSelected = false
                star4.isSelected = false
                star5.isSelected = false
            case 2:
                star1.isSelected = true
                star2.isSelected = true
                star3.isSelected = false
                star4.isSelected = false
                star5.isSelected = false
            case 3:
                star1.isSelected = true
                star2.isSelected = true
                star3.isSelected = true
                star4.isSelected = false
                star5.isSelected = false
            case 4:
                star1.isSelected = true
                star2.isSelected = true
                star3.isSelected = true
                star4.isSelected = true
                star5.isSelected = false
            default:
                star1.isSelected = true
                star2.isSelected = true
                star3.isSelected = true
                star4.isSelected = true
                star5.isSelected = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func click(_ sender: UIButton) {
        let starNum = sender.tag - 100
        if canRes {
            self.starNum = starNum
        }
        if starChangeBlock != nil {
            starChangeBlock!(starNum)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
