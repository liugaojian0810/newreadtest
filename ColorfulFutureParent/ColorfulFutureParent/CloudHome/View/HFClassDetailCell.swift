//
//  HFClassDetailCell.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/23.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFClassDetailCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(contentImg)
        
        contentImg.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    @objc var imgURL: NSString? {
        willSet {
            if newValue != nil {
                contentImg.kf.setImage(with: URL(string: newValue! as String), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL)  in
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    lazy var contentImg: UIImageView = {
        let contentImg = UIImageView()
        return contentImg
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
