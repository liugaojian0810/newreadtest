//
//  HFInteractReportBabyInfoCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2020/12/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractReportBabyInfoCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    // 宝宝头像
    @IBOutlet weak var headImgView: UIImageView!
    // 宝宝姓名
    @IBOutlet weak var babyNameLab: UILabel!
    // 开始时间
    @IBOutlet weak var startTimeLab: UILabel!
    // 教师姓名
    @IBOutlet weak var teacherNameLab: UILabel!
    // 互动科目
    @IBOutlet weak var interactNameLab: UILabel!
    
    let bezierPath = UIBezierPath.init()
    let shapLayer = CAShapeLayer.init()
    
    var model: HFInteractiveModel?{
        didSet {
            if model != nil {
                headImgView.kf.setImage(with: URL.init(string: model?.kbAvatarUrl ?? ""), placeholder: UIImage.init(named: "babyHeaderImage"), options: nil, progressBlock: nil, completionHandler: nil)
                babyNameLab.text = model?.kbName ?? ""
                let date = Date.string2Date(model?.kiiPlayEndTime ?? "")
                startTimeLab.text = Date.date2String(date, dateFormat: "yyyy年MM月dd日")
                teacherNameLab.text = model?.ktName ?? ""
                interactNameLab.text = "\(model!.csName)-\(model!.csstName)"
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
        
        bgView.layer.mask = shapLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let borderRadius = 15
        let spacing: Int = 15 // 左右间距
        bezierPath.move(to: CGPoint.init(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint.init(x: 0, y: Int(bgView.height) - spacing))
        bezierPath.addArc(withCenter: CGPoint.init(x: spacing, y: Int(self.bgView.size.height - CGFloat(spacing))), radius: CGFloat(borderRadius), startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi / 2), clockwise: false)
        bezierPath.addLine(to: CGPoint.init(x: self.bgView.width, y: self.bgView.height))
        bezierPath.addArc(withCenter: CGPoint.init(x: Int(self.bgView.size.width - CGFloat(spacing)), y: Int(self.bgView.size.height - CGFloat(spacing))), radius: CGFloat(borderRadius), startAngle: CGFloat(Double.pi / 2), endAngle: 0, clockwise: false)
        bezierPath.addLine(to: CGPoint.init(x: Int(width), y: 0))
        bezierPath.close()
        shapLayer.path = bezierPath.cgPath
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
