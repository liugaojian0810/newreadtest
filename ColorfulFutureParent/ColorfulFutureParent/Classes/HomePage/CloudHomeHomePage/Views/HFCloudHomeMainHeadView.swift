//
//  HFCloudHomeMainHeadView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFCloudHomeMainHeadView: UITableViewCell {

    @IBOutlet weak var bannerView: UIView!
    
    typealias HFCloudHomeMainHeadViewItemClick = (Int) ->()
    var click: HFCloudHomeMainHeadViewItemClick?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bannerView.layer.contents = UIImage(named: "cloudhome_homepage_banner_icon")?.cgImage
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        if click != nil {
            self.click!(sender.tag)
        }
    }
    
}
