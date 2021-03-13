//
//  HFClassSelectItemCell.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFClassSelectItemCell: UICollectionViewCell {
    
    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var leadingConstrint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstrint: NSLayoutConstraint!
    
    var cornerRadiusnew: CGFloat = 16 {
        didSet{
            self.textLab.layer.cornerRadius = cornerRadius
            self.textLab.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLab.layer.cornerRadius = 16
        self.textLab.layer.masksToBounds = true
        
        // Initialization code
    }
    
    override var isSelected: Bool {

        didSet{
            if isSelected {
                self.textLab.backgroundColor = .colorWithHexString("FF844B")
                self.textLab.textColor = .colorWithHexString("FFFFFF")
            }else{
                self.textLab.backgroundColor = .colorWithHexString("F6F6F6")
                self.textLab.textColor = .colorWithHexString("666666")
            }
        }
        willSet{
            
        }
    }
    
    

}
