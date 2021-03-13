//
//  HFInviteResultPopView.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/6.
//  Copyright © 2021 huifan. All rights reserved.
//
// 教师邀请结果

import UIKit

enum HFTeacherInviteStatus {
    case agreeJoin // 园长同意加入
    case inviteJoin1 // 该宝宝为新入园宝宝
    case inviteJoin2 // 该宝宝为已入园宝宝
}

class HFInviteResultPopView: UITableViewCell {

    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var entryTableBtn: UIButton!
    
    var closeClosure: OptionClosure? // 点击关闭
    var rejectClosure: OptionClosure? // 点击拒绝
    var agreeClosure: OptionClosure? // 点击同意
    var entryTableClosure: OptionClosure? // 点击进入入园申请表
    
    var status: HFTeacherInviteStatus = .agreeJoin {
        
        didSet{
            switch status {
            case .agreeJoin:
                self.cancelBtn.isHidden = false
                self.agreeBtn.isHidden = false
                self.entryTableBtn.isHidden = true
            case .inviteJoin1:
                self.cancelBtn.isHidden = true
                self.agreeBtn.isHidden = true
                self.entryTableBtn.isHidden = false
                self.entryTableBtn.setTitle("请填写入园申请表", for: .normal)
            case .inviteJoin2:
                self.cancelBtn.isHidden = true
                self.agreeBtn.isHidden = true
                self.entryTableBtn.isHidden = false
                self.entryTableBtn.setTitle("请您完善档案信息", for: .normal)
            }
        }
    }
    
    var joinResultModel: HFJoinResultModel? {
        didSet {
            
            let psty = NSMutableParagraphStyle.init()
            psty.maximumLineHeight = 24
            psty.minimumLineHeight = 24
            psty.alignment = .center
            
            let m0Atb = NSMutableAttributedString.init(string: "欢迎", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-MD", size: 15), NSAttributedString.Key.paragraphStyle:psty])

            let m1Atb = NSMutableAttributedString.init(string: " \(joinResultModel!.ciName) ", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-BD", size: 15), NSAttributedString.Key.paragraphStyle:psty])
            
            let m2Atb = NSMutableAttributedString.init(string: "小朋友加入", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-MD", size: 15), NSAttributedString.Key.paragraphStyle:psty])
            
            let atb = NSAttributedString.init(string: "\n\(joinResultModel!.kiName)", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x666666),NSAttributedString.Key.font:UIFont.init(name: "ARYuanGB-BD", size: 15), NSAttributedString.Key.paragraphStyle:psty])
            
            m0Atb.append(m1Atb)
            m0Atb.append(m2Atb)
            m0Atb.append(atb)
            
            contentLabel.attributedText = m0Atb
            
            contentLabel.sizeToFit()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .init(white: 0, alpha: 0.5)
        self.backgroundColor = UIColor.clear
        
        contentBgView.layer.masksToBounds = true
        contentBgView.layer.cornerRadius = 8
        cancelBtn.jk_cornerRadius(20, strokeSize: 0.5, color: .hexColor(0x04BFF7))
        agreeBtn.jk_setRoundedCorners(.allCorners, radius: 20)
        entryTableBtn.jk_setRoundedCorners(.allCorners, radius: 20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cancel(_ sender: Any) {
        if rejectClosure != nil {
            rejectClosure!()
        }
    }
    
    @IBAction func agree(_ sender: Any) {
        if agreeClosure != nil {
            agreeClosure!()
        }
    }
    
    @IBAction func entryTeacherTable(_ sender: UIButton) {
        if entryTableClosure != nil {
            entryTableClosure!()
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        if closeClosure != nil {
            closeClosure!()
        }
    }
}
