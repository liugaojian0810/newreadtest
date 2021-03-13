//
//  HFPlayBackVideoCollectionViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import Kingfisher

class HFPlayBackVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classImageView: UIImageView!
    public var rowModel: HUIList? = nil {
        didSet {
            self.className.text = rowModel?.courseName
            let timestring = "时间:" + rowModel!.startTime + "-" + rowModel!.endTime
            self.time.attributedText = timestring.AttributeString(string: timestring, color: UIColor.jk_color(withHexString: "#666666"), font: UIFont.init(name: "ARyuanGB-MD", size: 12)!, range: NSMakeRange(0, 3))
            self.classImageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: rowModel!.coursePhoto)!))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
