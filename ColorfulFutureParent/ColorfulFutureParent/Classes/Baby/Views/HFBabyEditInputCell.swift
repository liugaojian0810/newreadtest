//
//  HFBabyEditInputCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/24.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBabyEditInputCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var inputRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var arrowImgView: UIImageView! // 选择模式下的箭头
    
    var inputCallBack: OptionClosureString?
    
    // 显示模式
    var cellType: HFPersonnelEditCellType = .input {
        didSet {
            if cellType == .input{
                self.isUserInteractionEnabled = true
                inputTF.isUserInteractionEnabled = true
                inputTF.clearButtonMode = .always
                arrowImgView.isHidden = true
                inputRightConstraint.constant = 20
            }else if cellType == .select {
                self.isUserInteractionEnabled = true
                inputTF.isUserInteractionEnabled = false
                inputTF.clearButtonMode = .never
                arrowImgView.isHidden = false
                inputRightConstraint.constant = 51
            }else if cellType == .gotoInput {
                self.isUserInteractionEnabled = true
                inputTF.isUserInteractionEnabled = false
                inputTF.clearButtonMode = .never
                arrowImgView.isHidden = false
                inputRightConstraint.constant = 51
            }else{
                self.isUserInteractionEnabled = false
                inputTF.isUserInteractionEnabled = false
                inputTF.clearButtonMode = .never
                arrowImgView.isHidden = true
                inputRightConstraint.constant = 24
            }
        }
    }
    
    @objc func textFieldChnage(uitext: UITextField) {
        if inputCallBack != nil {
            var text = uitext.text ?? ""
            if uitext.jk_maxLength != 0 && text != "" {
                text = String(text.prefix(uitext.jk_maxLength))
            }
            inputCallBack!(text)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.inputTF.addTarget(self, action: #selector(textFieldChnage(uitext:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
