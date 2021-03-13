//
//  HFFamilyMembersInfoCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFFamilyMembersInfoCell: UITableViewCell {

    /// 与宝宝的关系
    @IBOutlet weak var relationLabel: UILabel!
    /// 第一联系人
    @IBOutlet weak var firstRelationLabel: UILabel!
    /// 用户名
    @IBOutlet weak var usrNameLabel: UILabel!
    /// 手机号
    @IBOutlet weak var phoneLabel: UILabel!
    /// 工作地址
    @IBOutlet weak var workUnitslabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
