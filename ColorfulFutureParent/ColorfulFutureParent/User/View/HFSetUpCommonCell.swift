//
//  HFSetUpCommonCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSetUpCommonCell: UITableViewCell {

    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var infoImgTrailing: NSLayoutConstraint!
    @IBOutlet weak var intoImg: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var corverView: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.corverView.isHidden = true
        self.textField.isEnabled = false
        
        self.leftBtn.layer.cornerRadius = 14;
        self.leftBtn.layer.masksToBounds = true;
        self.leftBtn.layer.borderWidth = 0.5;
        self.leftBtn.layer.borderColor = UIColor.colorWithHexString("ABABAB").cgColor;

        self.rightBtn.layer.cornerRadius = 14;
        self.rightBtn.layer.masksToBounds = true;
        self.rightBtn.layer.borderWidth = 0.5;
        self.rightBtn.layer.borderColor = UIColor.colorWithHexString("ABABAB").cgColor;

    }

    
    func sex(sex: Int) {
        if sex == 0{ //女
            self.leftBtn.backgroundColor = .colorWithHexString("22BDF3")
            self.rightBtn.backgroundColor = .colorWithHexString("FFFFFF")
            self.leftBtn.setTitleColor(.colorWithHexString("FFFFFF"), for: .normal)
            self.rightBtn.setTitleColor(.colorWithHexString("ABABAB"), for: .normal)
            self.leftBtn.alpha = 0.56
            self.rightBtn.alpha = 1
        }else{//男
            self.rightBtn.backgroundColor = .colorWithHexString("FF549B")
            self.leftBtn.backgroundColor = .colorWithHexString("FFFFFF")
            self.leftBtn.setTitleColor(.colorWithHexString("ABABAB"), for: .normal)
            self.rightBtn.setTitleColor(.colorWithHexString("FFFFFF"), for: .normal)
            self.leftBtn.alpha = 1
            self.rightBtn.alpha = 0.56
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
