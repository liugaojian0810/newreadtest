//
//  HFBabyEditMultipleInputCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/24.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBabyEditMultipleInputCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var inputTextView: UITextView!
    
    var inputCallBack: OptionClosureString?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if inputCallBack != nil {
            inputCallBack!(textView.text ?? "")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
