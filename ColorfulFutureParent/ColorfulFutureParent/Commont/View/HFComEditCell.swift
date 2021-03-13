//
//  HFComEditCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFComEditCell: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var arrowIntoImg: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var arrowRightConstrint: NSLayoutConstraint!
    @IBOutlet weak var numLable: UILabel!
    var maxInput: Int = 0
    
    var editChangedClosure: OptionClosureString?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.textField.addTarget(self, action: #selector(textFieldChange(tf:)), for: .editingChanged)
    }

    @objc func textFieldChange(tf: UITextField) {

        if maxInput == 0 {
            
        }else{
            if (tf.text?.length() ?? 0) > maxInput {
                tf.text = tf.text?.substring(to: maxInput)
            }
        }
        if self.editChangedClosure != nil {
            self.editChangedClosure!(tf.text ?? "")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
