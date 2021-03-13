//
//  HFGrowUpImageTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/10/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFGrowUpImageTableViewCell: UITableViewCell {
    ///图片
    @IBOutlet weak var headImg: UIImageView!
    ///教育活动名称
    @IBOutlet weak var goalLabel: UILabel!
    ///活动阶段
    @IBOutlet weak var phaseLabel: UILabel!
    ///活动目标
    @IBOutlet weak var activityGoalLabel: UILabel!
    ///重点
    @IBOutlet weak var focusOnLabel: UILabel!
    ///难点
    @IBOutlet weak var difficultiesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    
    var activity: HFGrowthCampEduActivity? = nil {
        didSet {
            if activity != nil {
                headImg.sd_setImage(with: URL(string: activity?.gaImgCoverUrl ?? ""), completed: nil)
                goalLabel.text =  activity?.csName ?? ""
                phaseLabel.text =  activity?.csstName ?? ""
                activityGoalLabel.text =  activity?.gaTeachTarget ?? ""
                focusOnLabel.text =  activity?.gaTeachFocus ?? ""
                difficultiesLabel.text = activity?.gaTeachDifficult ?? ""
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
