//
//  HFBabyTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//
// 未入园宝宝视图

import UIKit

class HFBabyTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexImgView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectStatusImgView: UIImageView!
    @IBOutlet weak var joinBtn: UIButton!
    
    var joinClosure: OptionClosure?
    
    var babyModel: HFBabyModel? {
        didSet{
            headerImgView.kf.setImage(with: URL.init(string: babyModel!.headImg), placeholder: UIImage.getBabyHead(with: babyModel?.ciSex ?? 2), options: nil, progressBlock: nil, completionHandler: nil)
            nameLabel.text = babyModel!.ciName
            if babyModel!.ciSex == 0 {
                sexImgView.isHidden = true
            }else{
                sexImgView.isHidden = false
                sexImgView.image = babyModel!.ciSex == 1 ? UIImage.init(named: "编组 15") : UIImage.init(named: "fenzu")
            }
            ageLeftConstraint.constant = (babyModel!.ciSex != 1 && babyModel!.ciSex != 2) ? 11 : 27
            ageLabel.text = String.caculateAgeYMD(birthday: babyModel!.ciBirth)
            self.rx.observeWeakly(HFBabyModel.self, "isEntranceKg").subscribe(onNext: { (change) in
                print("observeWeakly订阅到了KVO:\(String(describing: change))")
            })
            if babyModel!.isEntranceKg == 2 {
                // 审核中
                joinBtn.isEnabled = false
                joinBtn.alpha = 0.35
            }else{
                joinBtn.isEnabled = true
                joinBtn.alpha = 1.0
            }
            
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
        
        joinBtn.layer.masksToBounds = true
        joinBtn.layer.cornerRadius = 12
        joinBtn.layer.borderWidth = 1
        joinBtn.layer.borderColor = UIColor.colorMain().cgColor
        
        headerImgView.jk_setRoundedCorners(.allCorners, radius: 20)
    }
    
    /// 加入学校
    @IBAction func joinKiAction(_ sender: Any) {
        if joinClosure != nil {
            joinClosure!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
