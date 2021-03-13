//
//  HFManagerClassTableViewCell.swift
//  ColorfulFuturePrincipal
//
//  Created by wzz on 2020/10/6.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

enum ClassCellType {
    case edit, select//编辑与选择
}

class HFManagerClassTableViewCell: UITableViewCell {

    @IBOutlet weak var body: UITextField!
    @IBOutlet weak var bodyRightNum: NSLayoutConstraint!
    @IBOutlet weak var rightIconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var headImgView: UIImageView!
    var editClosure: OptionClosureString?

    
    var classCellType:ClassCellType = .select {
        didSet {
            self.rightIconImage.isHidden = classCellType == .edit
            self.bodyRightNum.constant = classCellType == .edit ? 16 : 31
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.body.addTarget(self, action: #selector(textFieldChange(tf:)), for: .editingChanged)
    }

    @objc func textFieldChange(tf: UITextField) {
        
        if editClosure != nil {
            editClosure!(tf.text ?? "")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
