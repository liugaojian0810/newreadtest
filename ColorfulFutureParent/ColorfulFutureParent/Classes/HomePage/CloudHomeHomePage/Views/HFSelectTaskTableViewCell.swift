//
//  HFSelectTaskTableViewCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by wzz on 2020/10/29.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSelectTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLab: UILabel!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    
    // 点选按钮回调
    var selectBlock: OptionClosure?
    
    var index: Int = 0 {
        didSet {
//            numberLab.text = String.numberString(index: index)
        }
    }
    
    var content: String = "" {
        didSet {
//            contentLab.text = content
            let paraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paraph.alignment = .left;
            paraph.firstLineHeadIndent = 0
            paraph.headIndent = 14 * 1.25
            paraph.lineSpacing = 8
            let attb = NSAttributedString.init(string: content, attributes: [NSAttributedString.Key.paragraphStyle: paraph,NSAttributedString.Key.foregroundColor: UIColor.hexColor(0x666666)])
            contentLab.attributedText = attb
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
        selectionStyle = .none
    }
    
    @IBAction func clickSelect(_ sender: UIButton) {
        if selectBlock != nil {
            selectBlock!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
