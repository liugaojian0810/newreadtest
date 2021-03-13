//
//  HFClassOrderListTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage

class HFClassOrderListTableViewCell: UITableViewCell {
    @IBOutlet weak var classImage: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var classSubTItle: UILabel!
    @IBOutlet weak var className: UILabel!
    public var rowModel:HFOrderList? = nil {
        didSet {
            self.className.text = rowModel?.goodsName
            let timeString: String = "支付时间：" + rowModel!.gmtPay
            self.time.attributedText = timeString.AttributeString(string: timeString, color: UIColor.jk_color(withHexString: "#454545"), font: UIFont.init(name: "ARYuanGB-MD", size: 12)!, range: NSMakeRange(0, 5))
            let classSubTItle = rowModel?.payWay == "umpay" ? "支付方式：快捷支付":"支付方式：分期支付"
            
            self.classSubTItle.attributedText = classSubTItle.AttributeString(string: classSubTItle, color: UIColor.jk_color(withHexString: "#454545"), font: UIFont.init(name: "ARYuanGB-MD", size: 12)!, range: NSMakeRange(0, 5))
            self.classImage.kf.setImage(with: ImageResource(downloadURL: NSURL.init(string: rowModel!.goodsThumbnailUrl)! as URL))
            let string: String = String(format: "¥%.2f", (rowModel!.totalAmount.float() ?? 0) * 0.01)
            let price = string //"¥" + "\((rowModel!.totalAmount.float() ?? 0) * 0.01)"
            self.price.attributedText = price.AttributeString(string: price, color: UIColor.jk_color(withHexString: "#FF3123"), font: UIFont.init(name: "ARYuanGB-BD", size: 12)!, range: NSMakeRange(0, 1))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
