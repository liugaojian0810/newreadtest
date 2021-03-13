//
//  HFMessageCenterTableViewCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMessageCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailDesLabel: UILabel!
    @IBOutlet weak var badgeLabel: HFLabel!
    
    var model: HFMessageCenterModel? {
        didSet {
            iconImageView.kf.setImage(with: URL(string: model!.msgTypeImg))
            titleLabel.text = model?.msgTypeName
            detailDesLabel.text = model?.lateMsg
            if model?.noReadCnt != 0 {
                badgeLabel.isHidden = false
                var badgeStr = "\(model!.noReadCnt)"
                if model!.noReadCnt > 99 {
                    badgeStr = "99+"
                }
                badgeLabel.text = badgeStr
            }else{
                badgeLabel.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = 7
        badgeLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}
