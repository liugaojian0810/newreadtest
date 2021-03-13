//
//  HFEntryResultPopView.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/1/6.
//  Copyright © 2021 huifan. All rights reserved.
//
// 教师入职结果
import UIKit

enum HFTeacherEntryStatus {
    case pass // 通过
    case reject // 拒绝
}

class HFEntryResultPopView: UITableViewCell {
    
    var lineShapeLayers: [CAShapeLayer] = []
    
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var btnBgView: UIView!
    
    var exitClosure: OptionClosure?
    var closeClosure: OptionClosure?
    var updateClosure: OptionClosure?
    
    var joinResultModel: HFJoinResultModel? {
        didSet {
            let psty0 = NSMutableParagraphStyle.init()
            psty0.maximumLineHeight = 30
            psty0.minimumLineHeight = 30
            psty0.alignment = .left
            
            let mBaseLineOffset = (30 - UIFont.systemFont(ofSize: 15, weight: .semibold).lineHeight) / 2
            let mAtb = NSMutableAttributedString.init(string: "教师，您好：", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .semibold),NSAttributedString.Key.baselineOffset:mBaseLineOffset, NSAttributedString.Key.paragraphStyle:psty0])
            
            let psty = NSMutableParagraphStyle.init()
            psty.maximumLineHeight = 30
            psty.minimumLineHeight = 30
            psty.alignment = .center
            
            let m1baseLineOffset = (30 - UIFont.systemFont(ofSize: 11).lineHeight) / 2
            let a1tb = NSAttributedString.init(string: "\n因以下原因，您的提交未通过！", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x333333),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11),NSAttributedString.Key.baselineOffset:m1baseLineOffset, NSAttributedString.Key.paragraphStyle:psty])
            
            mAtb.append(a1tb)
            
            let baseLineOffset = (30 - UIFont.systemFont(ofSize: 11).lineHeight) / 2
            let atb = NSAttributedString.init(string: "\n\(joinResultModel!.ilAuditMark)\n\n\n\n\n", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x666666),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11),NSAttributedString.Key.baselineOffset:baseLineOffset, NSAttributedString.Key.paragraphStyle:psty])
            
            mAtb.append(atb)
            
            contentLabel.attributedText = mAtb
            
            contentLabel.sizeToFit()
        }
    }
    
    var status: HFTeacherEntryStatus = .pass {
        
        didSet{
            switch status {
            case .pass:
                self.cancelBtn.isHidden = true
                self.updateBtn.isHidden = true
            case .reject:
                self.cancelBtn.isHidden = false
                self.updateBtn.isHidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .init(white: 0, alpha: 0.5)
        self.backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func cancel(_ sender: Any) {
        if exitClosure != nil {
            exitClosure!()
        }
    }
    
    @IBAction func update(_ sender: Any) {
        if updateClosure != nil {
            updateClosure!()
        }
    }
}
