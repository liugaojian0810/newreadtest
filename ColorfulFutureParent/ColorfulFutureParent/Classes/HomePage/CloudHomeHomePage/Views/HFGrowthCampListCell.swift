//
//  HFGrowthCampListCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFGrowthCampListCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var viewReport: UIButton!
    var viewReportClosure: OptionBlock?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bgView.corner_radius(at: .all, radius: 8)
        self.img.corner_radius(at: .all, radius: 8)

    }
    
    
    @IBAction func viewReport(_ sender: UIButton) {
        if viewReportClosure != nil {
            self.viewReportClosure!()
        }
    }
    
    
}
