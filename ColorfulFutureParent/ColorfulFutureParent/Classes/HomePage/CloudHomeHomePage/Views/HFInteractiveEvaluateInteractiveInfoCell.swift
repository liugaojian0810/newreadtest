//
//  HFInteractiveEvaluateInteractiveInfoCell.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/2/28.
//  Copyright © 2021 huifan. All rights reserved.
//
/// 互动评价互动活动信息

import UIKit

class HFInteractiveEvaluateInteractiveInfoCell: UITableViewCell {

    @IBOutlet weak var teacherImgView: UIImageView!
    @IBOutlet weak var teacherNameLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var csNameLab: UILabel!
    @IBOutlet weak var cstNameLab: UILabel!
    @IBOutlet weak var babyCountLab: UILabel!
    
    var model: HFInteractiveModel? {
        didSet{
            teacherImgView.kf.setImage(with: URL.init(string: model?.ktAvatarUrl ?? ""), placeholder: UIImage.teacherMan(), options: nil, progressBlock: nil, completionHandler: nil)
            teacherNameLab.text = model?.ktName ?? "-"
            timeLab.text = "1对\(model!.ciStudentNum) \(model!.gradeName)直播互动"
            timeLab.text = "\(model!.kiiPlayStartDate.substring(from: 5)) \(model!.kiiPlayStartTime.subString(rang: NSRange.init(location: 11, length: 5)))-\(model!.kiiPlayEndTime.subString(rang: NSRange.init(location: 11, length: 5)))"
            cstNameLab.text = "\(model!.ciTeacherNum)对\(model!.ciStudentNum)"
            let alreadyJoinStudentNum = "\(model!.alreadyJoinStudentNum)"
            let att = NSMutableAttributedString.init(string: "预约宝宝：\(alreadyJoinStudentNum)/\(model!.ciStudentNum)")
            att.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x00B8FF)], range: NSRange.init(location: 5, length: alreadyJoinStudentNum.length()))
            babyCountLab.attributedText = att
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
