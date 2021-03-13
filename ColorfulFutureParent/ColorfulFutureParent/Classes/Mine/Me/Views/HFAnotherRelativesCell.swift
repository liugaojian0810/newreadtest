//
//  HFAnotherRelativesCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/7.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFAnotherRelativesCell: UITableViewCell {

    
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var relDes: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var parent: HFBabyParentModel? = nil {
        
        didSet {
            if parent != nil {
                self.headImgView.kf.setImage(with: URL(string: parent?.headImg ?? ""), placeholder: self.getRelDes(parent?.cprRelp ?? "", parent?.usrSex ?? 2), options: .none, progressBlock: {_,_ in }, completionHandler: {_,_,_,_ in })
                relDes.text = parent?.dicFieldName
                phoneLabel.text = parent?.usrPhone
                nameLabel.text = parent?.usrFullName
            }
        }
    }
    
    /// 获取不同家长关系默认的占位头像
    func getRelDes(_ cprRelp: String, _ sex: Int) -> UIImage {
        
        if cprRelp == "child_rel_laolao" || cprRelp == "child_rel_nainai" {
            return UIImage.gradeMa()
        }else if cprRelp == "child_rel_laoye" || cprRelp == "child_rel_yeye" {
            return UIImage.gradePa()
        }else if cprRelp == "child_rel_father" {
            return UIImage.getParentOfFather()
        }else if cprRelp == "child_rel_mother"{
            return UIImage.getParentOfMother()
        }else{
            return UIImage.getParentOfMother()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
