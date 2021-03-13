//
//  HFBabyEditSelectCell.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/24.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFBabyEditOnlySelectCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var noBtn: UIButton! // 否
    @IBOutlet weak var yesBtn: UIButton! // 是
    
    var clickCallBack: OptionClosureInt? // 回调
    
    // 0否，1是，2未选择
    var seletcStatus: Int = 2 {
        didSet {
            if seletcStatus == 0 {
                setStatus(btn: noBtn, select: true)
                setStatus(btn: yesBtn, select: false)
            }else if seletcStatus == 1 {
                setStatus(btn: yesBtn, select: true)
                setStatus(btn: noBtn, select: false)
            }else{
                setStatus(btn: yesBtn, select: false)
                setStatus(btn: noBtn, select: false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.seletcStatus = 2
        noBtn.adjustsImageWhenHighlighted = false
        yesBtn.adjustsImageWhenHighlighted = false
    }
    
    // 点击否
    @IBAction func clickNo(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        self.seletcStatus = 0
        if clickCallBack != nil {
            clickCallBack!(0)
        }
    }
    
    // 点击是
    @IBAction func clickYes(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        self.seletcStatus = 1
        if clickCallBack != nil {
            clickCallBack!(1)
        }
    }
    
    // 设置状态
    func setStatus(btn: UIButton, select: Bool) -> Void {
        btn.isSelected = select
        if select {
            btn.jk_cornerRadius(14, strokeSize: 0.5, color: .hexColor(0xFF844B))
            btn.jk_setBackgroundColor(.hexColor(0xFF844B, alpha: 0.1), for: .normal)
            btn.setTitleColor(.hexColor(0xFF844B), for: .normal)
        }else{
            btn.jk_cornerRadius(14, strokeSize: 0.5, color: .hexColor(0xEDEDED))
            btn.jk_setBackgroundColor(.white, for: .normal)
            btn.setTitleColor(.hexColor(0x666666), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
