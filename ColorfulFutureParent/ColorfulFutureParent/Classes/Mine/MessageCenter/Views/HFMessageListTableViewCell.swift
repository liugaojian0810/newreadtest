//
//  HFMessageListTableViewCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMessageListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! // 消息标题
    @IBOutlet weak var statusLabel: UILabel! // 状态
    @IBOutlet weak var timeLabel: UILabel! // 发送消息时间
    @IBOutlet weak var contentLabel: UILabel! // 消息内容
    @IBOutlet weak var headImg: UIImageView! // 已关闭交互
    
    @IBOutlet weak var statusWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusHeightConstraint: NSLayoutConstraint!
    
//    var type: MsgListType? {
//
//        didSet {
//            if type == .submitRecord {
//                // 发布状态显示
//                statusLabel.text = "待发送"
//                statusLabel.backgroundColor = .hexColor(0xF5A623)
//                statusLabel.layer.cornerRadius = 8
//                statusWidthConstraint.constant = 48
//                statusHeightConstraint.constant = 16
//            }else{
//                // 标记是否已读
//                statusLabel.text = ""
//                statusLabel.backgroundColor = .hexColor(0xFC5655)
//                statusLabel.layer.cornerRadius = 4
////                statusWidthConstraint.constant = 8
////                statusHeightConstraint.constant = 8
//                statusWidthConstraint.constant = 48
//                statusHeightConstraint.constant = 16
//            }
//        }
//    }
    
//    var model: HFMessageModel? {
//        didSet {
//            // TODO: 接口暂未建模
//        }
//    }
    
    
    var msg: HFMessageListModel? = nil {
        didSet {
            if msg != nil {
                titleLabel.text = msg?.msgTitle
                timeLabel.text = msg?.pushTime
                contentLabel.text = msg?.msgContent
                statusLabel.isHidden = false
                headImg.kf.setImage(with: URL(string: msg?.msgImg ?? ""))
                if msg?.msgReadState == 1 {
                    statusLabel.text = "已读"
                    statusLabel.backgroundColor = UIColor.colorWithHexString("8CD869")
                }else{
                    statusLabel.text = "未读"
                    statusLabel.backgroundColor = UIColor.colorWithHexString("FF7B38")
                    statusLabel.isHidden = false
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
