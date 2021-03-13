//
//  HFInputTextViewCell.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/2/28.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFInputTextViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inputStatistLabel: UILabel!
    @IBOutlet weak var topConstriant: NSLayoutConstraint!
    @IBOutlet weak var leftConstriant: NSLayoutConstraint!
    @IBOutlet weak var bottomConstriant: NSLayoutConstraint!
    @IBOutlet weak var rightConstriant: NSLayoutConstraint!
    
    var inputCallBack: OptionClosureString?
    
    var padding: UIEdgeInsets = UIEdgeInsets.init(top: 18, left: 35, bottom: 18, right: 35) {
        didSet {
            topConstriant.constant = padding.top
            leftConstriant.constant = padding.left
            bottomConstriant.constant = padding.bottom
            rightConstriant.constant = padding.right
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if inputCallBack != nil {
            inputCallBack!(textView.text ?? "")
        }
        inputStatistLabel.text = "\(textView.text.length())/\(textView.jk_maxLength)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.placeholder = "用一段话来评价老师的互动表现吧！"
        textView.jk_maxLength = 200
        textView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
