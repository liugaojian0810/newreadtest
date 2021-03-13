//
//  HFInteractiveCampsCell.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractiveCampsCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomBgVIew: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var item1Btn: UIButton!
    private var clickItem1Block: OptionClosure?
    
    @IBOutlet weak var item2Btn: UIButton!
    
    var clickBabyCountBlock: OptionClosure? // 点击宝宝数
    var evaluateClosure: OptionClosure? // 查看评价、写评价
    var makeAppointClosure: OptionClosure? // 预约、取消预约
    var readReportClosure: OptionClosure? // 查看报告
    
    var cellInteractiveType: CloudHomeInteractiveType = .being
    
    var model: HFInteractiveModel? {
        didSet{
            nameLabel.text = "1对\(model!.ciStudentNum) \(model!.gradeName)直播互动"
            courseNameLabel.text = "\(model!.csName)-\(model!.csstName)"
            timeLabel.text = "\(model!.kiiPlayStartDate.substring(from: 5)) \(model!.kiiPlayStartTime.subString(rang: NSRange.init(location: 11, length: 5)))-\(model!.kiiPlayEndTime.subString(rang: NSRange.init(location: 11, length: 5)))"
            headImg.kf.setImage(with: URL.init(string: model!.ktAvatarUrl), placeholder: UIImage.teacherWomen(), options: nil, progressBlock: nil, completionHandler: nil)
            userNameLabel.text = model!.ktName
            let alreadyJoinStudentNum = "\(model!.alreadyJoinStudentNum)"
            let att = NSMutableAttributedString.init(string: "预约宝宝：\(alreadyJoinStudentNum)/\(model!.ciStudentNum)")
            att.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexColor(0x00B8FF)], range: NSRange.init(location: 5, length: alreadyJoinStudentNum.length()))
            countLabel.attributedText = att
            updateStatus()
            if model!.interactiveType == .noBegin {
                NotificationCenter.default.addObserver(self, selector: #selector(updateStatus), name: NSNotification.Name.init("UpdateInteractiveStatus"), object: nil)
            }
        }
    }
    
    @objc func updateStatus() -> Void {
        
        countLabel.isHidden = cellInteractiveType != .interactiveCamps
        
        if cellInteractiveType == .interactiveCamps && !model!.isSubscribe {
            item2Btn.isHidden = true
            item1Btn.isUserInteractionEnabled = true
            item1Btn.setTitle("我要预约", for: .normal)
            item1Btn.jk_setBackgroundColor(.hexColor(0x04BFF7), for: .normal)
            self.clickItem1Block = makeAppointClosure
        }else{
            if model!.isCancel {
                item2Btn.isHidden = true
                item1Btn.isUserInteractionEnabled = false
                item1Btn.setTitle("取消成功", for: .normal)
                item1Btn.jk_setBackgroundColor(.hexColor(0x82DFFB), for: .normal)
            }else{
                item2Btn.isHidden = true
                switch model!.interactiveType {
                case .noBegin:
                    if model!.isToday {
                        // 今天
                        item1Btn.isUserInteractionEnabled = false
                        item1Btn.setTitle(model!.timeIntervalString, for: .normal)
                        item1Btn.jk_setBackgroundColor(model!.isAboutToStart ? .hexColor(0x0DCCA0) : .hexColor(0xFF844B), for: .normal)
                    }else{
                        item1Btn.isUserInteractionEnabled = true
                        item1Btn.setTitle("取消预约", for: .normal)
                        item1Btn.jk_setBackgroundColor(.hexColor(0xFF911F), for: .normal)
                        self.clickItem1Block = makeAppointClosure
                    }
                case .being:
                    item1Btn.isUserInteractionEnabled = false
                    item1Btn.setTitle("互动中", for: .normal)
                    item1Btn.jk_setBackgroundColor(.hexColor(0x04BFF7), for: .normal)
                case .end:
                    item2Btn.isHidden = true
                    item1Btn.isUserInteractionEnabled = true
                    item1Btn.setTitle(model!.isParentsSendReport == 1 ? "查看评价" : "去评价", for: .normal)
                    item1Btn.jk_setBackgroundColor(.hexColor(0xFF911F), for: .normal)
                    self.clickItem1Block = evaluateClosure
                default:
                    break
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        backgroundColor = .colorBg()
        contentView.backgroundColor = .colorBg()
        
        countLabel.isUserInteractionEnabled = true
        countLabel.setTapActionWithBlockWith {
            if self.clickBabyCountBlock != nil {
                self.clickBabyCountBlock!()
            }
        }
        
        item2Btn.isHidden = true
    }
    
    // 目前左边按钮只有查看报告功能
    @IBAction func clickItem2Action(_ sender: UIButton) {
        if readReportClosure != nil {
            readReportClosure!()
        }
    }
    
    // 多功能按钮
    @IBAction func clickItem1Action(_ sender: UIButton) {
        if clickItem1Block != nil {
            clickItem1Block!()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func draw(_ rect: CGRect) {
        headImg.setCornerRadius(14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
