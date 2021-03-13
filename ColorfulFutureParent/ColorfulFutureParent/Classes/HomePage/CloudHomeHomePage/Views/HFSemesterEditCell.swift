//
//  HFSemesterEditCell.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSemesterEditCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    var editChangeBlock: OptionClosureString?
    @IBOutlet weak var switchBgView: UIView!
    @IBOutlet weak var switchBtn: UISwitch!
    var switchClosure: OptionClosureInt?
    @IBOutlet weak var arrowRightConstrint: NSLayoutConstraint!
    @IBOutlet weak var topVewMsgTipView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        textField.addTarget(self, action: #selector(textFieldChnage(uitext:)), for: .editingChanged)
    }
    
    
    @objc func textFieldChnage(uitext: UITextField) {
        if editChangeBlock != nil {
            var text = uitext.text ?? ""
            if uitext.jk_maxLength != 0 && text != "" {
                text = String(text.prefix(uitext.jk_maxLength))
            }
            editChangeBlock!(text)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    ///switch按钮状态切换
    @IBAction func switchOpera(_ sender: UISwitch) {
        if switchClosure != nil {
            if sender.isOn {
                switchClosure!(1)
            }else{
                switchClosure!(0)
            }
        }
    }

    
}
