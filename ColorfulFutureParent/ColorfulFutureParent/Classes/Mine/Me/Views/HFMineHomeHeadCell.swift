//
//  HFMineHomeHeadCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFMineHomeHeadCell: UITableViewCell {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var memImg: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var babyHeadImage: UIImageView!
    ///设置
    @IBOutlet weak var setupBtn: UIButton!
    //编辑
    @IBOutlet weak var editBtn: UIButton!
    //查看权益
    @IBOutlet weak var lookInterestsBtn: UIButton!

    var setupClosure: OptionClosure?
    var editClosure: OptionClosure?
    var lookInterestsClosure: OptionClosure?

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        bgView.setCorner([.topLeft,.topRight], withRadius: 10)
    }
    
    /// 操作按钮点击
    /// - Parameter sender: 点击按钮
    @IBAction func operaResp(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            if self.setupClosure != nil {
                self.setupClosure!()
            }
        case 102:
            if self.editClosure != nil {
                self.editClosure!()
            }
        default:
            if self.lookInterestsClosure != nil {
                self.lookInterestsClosure!()
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
