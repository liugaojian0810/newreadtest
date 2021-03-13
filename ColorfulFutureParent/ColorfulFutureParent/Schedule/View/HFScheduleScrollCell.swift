//
//  HFScheduleScrollCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFScheduleScrollCell: UICollectionViewCell {

    
    @IBOutlet weak var topBgView: UIView!
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var topImg: UIImageView!
    @IBOutlet weak var bottomImg: UIImageView!
    @IBOutlet weak var topNameLabel: UILabel!
    @IBOutlet weak var bottomNameLabel: UILabel!
    @IBOutlet weak var topWeekLabel: UILabel!
    @IBOutlet weak var topTimeLabel: UILabel!
    @IBOutlet weak var bottomTimeLabel: UILabel!
    @IBOutlet weak var topDateLable: UILabel!
    @IBOutlet weak var bottomDateLable: UILabel!
    @IBOutlet weak var bottomWeeklabel: UILabel!
    @IBOutlet weak var bottomSuo: UIImageView!
    @IBOutlet weak var topSuo: UIImageView!
    @IBOutlet weak var topAlertLabel: UILabel!
    @IBOutlet weak var topAlertBgView: UIView!
    @IBOutlet weak var bottomAlertLabel: UILabel!
    @IBOutlet weak var bottomAlertBgView: UIView!
    @IBOutlet weak var topPointImg: UIImageView!
    @IBOutlet weak var bottomPointImg: UIImageView!
    @IBOutlet weak var courseImg: UIImageView!
    @IBOutlet weak var courseBottomImg: UIImageView!
    @IBOutlet weak var topCorverView: UIView!
    @IBOutlet weak var bottomCorverView: UIView!
    
    
    var isTop: Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.topCorverView.backgroundColor = .init(white: 0, alpha: 0.64)
        self.bottomCorverView.backgroundColor = .init(white: 0, alpha: 0.64)
        
        self.courseImg.layer.cornerRadius = 12.5
        self.courseImg.layer.masksToBounds = true
        
        self.courseBottomImg.layer.cornerRadius = 12.5
        self.courseBottomImg.layer.masksToBounds = true
        
    }
    
    func updateMsg (indexPath: NSIndexPath, data: SchduleItem) {
        
        if indexPath.row%2==0 {
            self.isTop = true
            self.topBgView.isHidden = false
            self.bottomBgView.isHidden = true
            self.topImg.isHidden = true
            self.bottomImg.isHidden = false
            self.bottomNameLabel.isHidden = true
            self.topNameLabel.isHidden = false
//            self.topSuo.isHidden = false
            self.bottomSuo.isHidden = true
            if data.courseStudy == 1 {
                self.topSuo.isHidden = true
            }else{
                self.topSuo.isHidden = false
            }
            
            self.topPointImg.isHidden = false
            self.topAlertLabel.isHidden = false
            self.topAlertBgView.isHidden = false

            self.bottomPointImg.isHidden = true
            self.bottomAlertLabel.isHidden = true
            self.bottomAlertBgView.isHidden = true
            
        }else{
            self.isTop = false
            self.topBgView.isHidden = true
            self.bottomBgView.isHidden = false
            self.topImg.isHidden = false
            self.bottomImg.isHidden = true
            self.bottomNameLabel.isHidden = false
            self.topNameLabel.isHidden = true
//            self.bottomSuo.isHidden = true
            self.topSuo.isHidden = true
            if data.courseStudy == 1 {
                self.bottomSuo.isHidden = true
            }else{
                self.bottomSuo.isHidden = false
            }
            self.topPointImg.isHidden = true
            self.topAlertLabel.isHidden = true
            self.topAlertBgView.isHidden = true

            self.bottomPointImg.isHidden = false
            self.bottomAlertLabel.isHidden = false
            self.bottomAlertBgView.isHidden = false
            
        }
        
        self.topNameLabel.text = data.courseName;
        self.bottomNameLabel.text = data.courseName;
        
        self.topAlertLabel.text = data.courseIntroduction;
        self.bottomAlertLabel.text = data.courseIntroduction;
        
        self.topWeekLabel.text = data.week
        self.bottomWeeklabel.text = data.week
        
        self.topDateLable.text = data.studyDate
        self.bottomDateLable.text = data.studyDate;
        
        self.topTimeLabel.text = data.studyTime! + "-" + data.studyEndTime!
        self.bottomTimeLabel.text = data.studyTime! + "-" + data.studyEndTime!
        
        if data.backgColor!.isEmpty {
            self.topBgView.backgroundColor = .colorWithHexString("FFCC00")
            self.bottomBgView.backgroundColor = .colorWithHexString("FFCC00")
        }else{
            self.topBgView.backgroundColor = .colorWithHexString(data.backgColor!)
            self.bottomBgView.backgroundColor = .colorWithHexString(data.backgColor!)
        }
        
        self.courseImg.sd_setImage(with: URL(string: data.backgImage!), completed: nil)
        self.courseBottomImg.sd_setImage(with: URL(string: data.backgImage!), completed: nil)
        
        if indexPath.row == 0 {
            self.bottomImg.isHidden = true
        }
    }
    
    func showTip(show: Bool)  {
        if show == true{
            if self.isTop {
                self.topAlertBgView.isHidden = false
                self.topAlertLabel.isHidden = false
                self.bottomAlertLabel.isHidden = true
                self.bottomAlertBgView.isHidden = true
                self.topPointImg.isHidden = false
                self.bottomPointImg.isHidden = true
            }else{
                self.topAlertBgView.isHidden = true
                self.topAlertLabel.isHidden = true
                self.bottomAlertBgView.isHidden = false
                self.bottomAlertLabel.isHidden = false
                self.topPointImg.isHidden = true
                self.bottomPointImg.isHidden = false
            }
        }else{
            self.topAlertBgView.isHidden = true
            self.topAlertLabel.isHidden = true
            self.bottomAlertBgView.isHidden = true
            self.bottomAlertLabel.isHidden = true
            self.topPointImg.isHidden = true
            self.bottomPointImg.isHidden = true
        }
    }
}
