//
//  HFHomePageTableHeaderCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/13.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HFHomePageTableHeaderCell: UITableViewCell {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var addTipLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexImgView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var numlabel: UILabel!
    
    typealias HomePageTableHeaderItemClick = (Int) ->()
    
    var moreClosure: OptionClosure?
    var clickBaby: OptionClosure?
    var scanClosure: OptionClosure?
    var msgCenterClosure: OptionClosure?
    var clickItem: HomePageTableHeaderItemClick?
    
    var babyModel: HFBabyModel? {
        didSet {
            if babyModel == nil {
                nameLabel.isHidden = true
                sexImgView.isHidden = true
                ageLabel.isHidden = true
                addTipLabel.isHidden = false
            }else{
                nameLabel.isHidden = false
                sexImgView.isHidden = false
                ageLabel.isHidden = false
                addTipLabel.isHidden = true
                nameLabel.text = babyModel!.ciName
                if babyModel!.ciSex == 0 {
                    sexImgView.isHidden = true
                }else{
                    sexImgView.isHidden = false
                    sexImgView.image = babyModel!.ciSex == 1 ? UIImage.init(named: "编组 15") : UIImage.init(named: "fenzu")
                }
                ageLeftConstraint.constant = (babyModel!.ciSex != 1 && babyModel!.ciSex != 2) ? 7 : 23
                ageLabel.text = String.caculateAgeYMD(birthday: babyModel!.ciBirth)
                headImgView.kf.setImage(with: URL(string: babyModel?.headImg ?? ""), placeholder: UIImage.getBabyHead(with: babyModel?.ciSex ?? 0), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.isHidden = true
        sexImgView.isHidden = true
        ageLabel.isHidden = true
        addTipLabel.isHidden = false
        
//        let disposeBag = DisposeBag()
//        self.rx.observeWeakly(HFBabyModel.self, "currentBaby").subscribe(onNext: { (change) in
//            print("observeWeakly订阅到了KVO:\(String(describing: change))")
//        })
//        .disposed(by: disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 左侧更多按钮
    @IBAction func moreClick(_ sender: UIButton) {
        if moreClosure != nil {
            moreClosure!()
        }
    }
    
    /// 扫码入园
    @IBAction func scanClick(_ sender: Any) {
        if scanClosure != nil {
            scanClosure!()
        }
    }
    
    /// 消息中心
    /// - Parameter sender: 无
    @IBAction func msgCenter(_ sender: UIButton) {
        
        if msgCenterClosure != nil {
            msgCenterClosure!()
        }
    }
    
    /// 点击宝宝/添加宝宝
    @IBAction func clickBaby(_ sender: UIButton) {
        if clickBaby != nil {
            clickBaby!()
        }
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        if clickItem != nil {
            self.clickItem!(sender.tag)
        }
    }
}
