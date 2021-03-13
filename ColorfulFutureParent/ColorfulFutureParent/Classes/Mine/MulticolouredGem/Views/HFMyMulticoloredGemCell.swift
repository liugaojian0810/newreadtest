//
//  HFMyMulticoloredGemCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/27.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import StoreKit

class HFMyMulticoloredGemCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.borderWidth = 0.5
        self.bgView.layer.borderColor = UIColor.colorWithHexString("F5A623").cgColor
    }

    func setContent() {
        
        nameLabel.text = "_ 五色宝石"
        priceLabel.text = "¥ _"
        
        let str = self.nameLabel.text ?? ""
        let att = NSMutableAttributedString(string: str)
        att.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: str.length() - 4, length: 4))
        att.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("666666"), range: NSRange(location: str.length() - 4, length: 4))
        nameLabel.attributedText = att
        
        let priceStr = self.priceLabel.text ?? ""
        let priceAtt = NSMutableAttributedString(string: priceStr)
        priceAtt.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location:0, length: 1))
        priceLabel.attributedText = priceAtt
    }
    
    var product: SKProduct? = nil {
        didSet {
            if product != nil {
//                nameLabel.text = product?.localizedTitle
                let attbStr = String(format: "%d", Int(truncating: product?.price ?? 0)) + " 五色宝石"
                let att = NSMutableAttributedString(string: attbStr)
                att.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("666666"), range: NSRange(location: attbStr.length()-4, length: 4))
                att.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: attbStr.length()-4, length: 4))
                nameLabel.attributedText = att
                priceLabel.text = String(format: "¥%@", product!.price)
            }
        }
    }
    
}
