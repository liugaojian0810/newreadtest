//
//  HFBuyTypeSelectCell.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/26.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBuyTypeSelectCell: UICollectionViewCell {

    ///套餐类型
    @IBOutlet weak var nameLabel: UILabel!
    ///价格
    @IBOutlet weak var priceLabel: UILabel!
    ///背景
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 16
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.borderColor = UIColor.colorWithHexString("F5A623").cgColor
        self.bgView.layer.borderWidth = 0.5
        
    }
    
    ///选中状态
    var sel: Bool = false {
        didSet{
            if sel {
                self.bgView.layer.borderWidth = 1
                self.bgView.layer.borderColor = UIColor.colorWithHexString("FF844B").cgColor
                self.bgView.backgroundColor = .colorWithRGB(253, g: 242, b: 238)
            }else{
                self.bgView.layer.borderWidth = 1
                self.bgView.layer.borderColor = UIColor.clear.cgColor
                self.bgView.backgroundColor = .colorWithHexString("F6F6F6")
            }
        }
    }
    
    
    func setContent(_ name: String, _ price: String) -> Void {
    
        let nameAtt = NSMutableAttributedString(string: name + "五彩宝石")
        let priceAtt = NSMutableAttributedString(string:"¥" + price)
        nameAtt.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.colorWithHexString("333333")], range: NSRange(location: 0, length: (name + "五彩宝石").count))
       nameAtt.setAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor : UIColor.colorWithHexString("333333")], range: NSRange(location: (name + "五彩宝石").count - 4, length: 4))
        priceAtt.setAttributes([:], range: NSRange(location: 0, length: ("¥" + price).count))
        priceAtt.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)], range: NSRange(location: 0, length: 1))
        priceAtt.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)], range: NSRange(location: 1, length: ("¥" + price).count - 1))
        self.nameLabel.attributedText = nameAtt
        self.priceLabel.attributedText = priceAtt
        
    }
    
    
    
    
    
    
}
