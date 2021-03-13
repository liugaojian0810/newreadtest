//
//  HFFormOneLineInputCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

typealias inBlock = (ParamType, String) -> ()

class HFFormOneLineInputCell: UITableViewCell {
    
    @IBOutlet weak var formTitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var rightLabel: UILabel!
    var model: HFFormTextInputCellModel? {
        didSet {
            formTitleLabel.text = model?.title
            formTitleLabel.font = model?.titleFont
            formTitleLabel.textColor = model?.titleColor
            rightLabel.text = model?.rightTitle
            inputTextField.text = model?.contentText
            inputTextField.font = model?.contentFont
            inputTextField.textColor = model?.contentColor
            inputTextField.placeholder = model?.placeholder
            inputTextField.keyboardType = model?.keyboardType ?? .default
            inputTextField.isUserInteractionEnabled = !(model?.onlyShow ?? false)
            inputTextField.jk_maxLength = model?.maxLength ?? 0
            if let textAligment = model?.textAlignment {
                inputTextField.textAlignment = textAligment
            }
        }
    }
    
    var inputComplete: ((_ text: String) -> ())?
    var inBlock: inBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        inputTextField.addTarget(self, action: #selector(textFieldChnage(uitext:)), for: .editingChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldChnage(uitext: UITextField) {
        var text = uitext.text ?? ""
        if uitext.jk_maxLength != 0 && text != "" {
            text = String(text.prefix(uitext.jk_maxLength))
        }
        if inputComplete != nil {
            inputComplete!(text)
        }
        if let inBlock = self.inBlock {
            inBlock(self.model!.paramType!, text)
        }
    }
}

//extension HFFormOneLineInputCell: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text:String = textField.text else{
//            return true
//        }
//
//        let textLength = text.count + string.count - range.length
//
//        var str = ""
//
//        var maxLength = model?.maxLength ?? 0
//        if maxLength == 0 {
//            maxLength = Int.max
//        }
//
//        if textLength <= maxLength {
//            str = text + string
//        }else{
//            str = (text + string).substring(to: maxLength - 1)
//        }
//
//        if self.inputComplete != nil {
//            self.inputComplete!(str)
//        }
//
//        return textLength <= maxLength
//    }
//}
