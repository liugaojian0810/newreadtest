//
//  HFInteractReportTaskInfoCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2020/12/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractReportTaskInfoCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    
    var tasks: [HFInteractTaskModel]?{
        didSet {
            if tasks != nil && tasks!.count != 0 {
                var text = ""
                for (index,task) in tasks!.enumerated() {
                    if text.isEmptyStr() {
                        text = "\(index+1)." + task.gatIntro
                    }else{
                        text += "\n\(index+1)." + task.gatIntro
                    }
                }
                content = text
            }
        }
    }
    
    var content = "" {
        didSet {
            if !content.isEmptyStr() {
                let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left;
                paragraphStyle.firstLineHeadIndent = 0
                paragraphStyle.headIndent = 14 * 0.75
                paragraphStyle.lineSpacing = 8
                let attb = NSAttributedString.init(string: content, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.font:  UIFont.init(name: "ARYuanGB-MD", size: 14)!])
                contentLab.attributedText = attb
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
