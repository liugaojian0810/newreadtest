//
//  HFBabyComeTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//
// 已入园宝宝视图

import UIKit
import Kingfisher

class HFBabyComeTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexImgView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectStatusImgView: UIImageView!
    @IBOutlet weak var kiNameLabel: UILabel!
    @IBOutlet weak var kiDesLabel: UILabel!
    
    var babyModel: HFBabyModel? {
        didSet{
            headerImgView.kf.setImage(with: URL.init(string: babyModel!.headImg), placeholder: UIImage.getBabyHead(with: babyModel!.ciSex), options: nil, progressBlock: nil, completionHandler: nil)
            nameLabel.text = babyModel!.ciName
            if babyModel!.ciSex == 0 {
                sexImgView.isHidden = true
            }else{
                sexImgView.isHidden = false
                sexImgView.image = babyModel!.ciSex == 1 ? UIImage.init(named: "编组 15") : UIImage.init(named: "fenzu")
            }
            ageLeftConstraint.constant = (babyModel!.ciSex != 1 && babyModel!.ciSex != 2) ? 11 : 27
            ageLabel.text = String.caculateAgeYMD(birthday: babyModel!.ciBirth)
            kiNameLabel.text = babyModel!.kiName
            var desc = ""
            if !babyModel!.clName.isEmptyStr() {
                desc += babyModel!.clName
            }
            if !babyModel!.seName.isEmptyStr() {
                if !desc.isEmptyStr() {
                    desc += "-"
                }
                desc += "\(babyModel!.seName)"
            }
            if babyModel!.isEntranceKg == 1 {
                if !desc.isEmptyStr() {
                    desc += "  "
                }
                desc += "已入学"
            }
            kiDesLabel.text = desc
            if babyModel == HFBabyViewModel.shared.currentBaby {
                contentView.backgroundColor = .hexColor(0xF2FAFF)
                selectStatusImgView.isHidden = false
            }else{
                contentView.backgroundColor = .white
                selectStatusImgView.isHidden = true
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImgView.jk_setRoundedCorners(.allCorners, radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
