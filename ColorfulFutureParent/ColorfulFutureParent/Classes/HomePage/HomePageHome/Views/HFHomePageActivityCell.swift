//
//  HFHomePageActivityCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/13.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

enum HomePageActivityType {
    case today, recommend
}

class HFHomePageActivityCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var leftNum: NSLayoutConstraint!
    var type: HomePageActivityType = .today {
        didSet {
            switch type {
            case .today:
                time.isHidden = true
                leftImage.isHidden = true
                leftNum.constant = 20
            default:
                time.isHidden = false
                leftImage.isHidden = false
                leftNum.constant = 56
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.setCorner([.allCorners], withRadius: 4)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
