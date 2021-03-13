//
//  HFgropUpTaskTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/10/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFgropUpTaskTableViewCell: UITableViewCell {

    /// 活动时间
    @IBOutlet weak var activityTimeLabel: UILabel!
    @IBOutlet weak var deslabel: UILabel!
    @IBOutlet weak var headImg: UIImageView!
    var clickClosure: OptionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    /// 请求老师帮忙
    @IBAction func requestHelp(_ sender: UIButton) {
        if self.clickClosure != nil {
            self.clickClosure!()
        }
    }
    
    var task: HFGrownActionTaskList? = nil {
        didSet {
            if task != nil {
                deslabel.text = task?.gatIntro
                headImg.sd_setImage(with: URL(string: task?.gatIntro ?? ""), completed: nil)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
