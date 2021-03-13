//
//  HFFiveGemsListTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFFiveGemsListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var time: UILabel!
    public var rowModel: HFRecordList? = nil {
        didSet {
            self.time.text = rowModel?.createDate.subString(rang: NSMakeRange(0, 10))
            if rowModel?.updateType == "1" {
                self.number.text = "+" + String(rowModel!.updateNum)
            } else {
                self.number.text = "-" + String(rowModel!.updateNum)
            }
            switch rowModel?.source {
            case "1":
                self.name.text = "登录奖励"
            case "2":
                self.name.text = "预约奖励"
            case "3":
                self.name.text = "不迟到奖励"
            case "4":
                self.name.text = "语音互动奖励"
            case "5":
                self.name.text = "触屏互动奖励"
            case "6":
                self.name.text = "每节课全勤奖励"
            case "7":
                 self.name.text = "直播奖励"
            default:
                 self.name.text = "回放奖励"
            }
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
