//
//  HFCancelAccountResultView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/20.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

/// 注销状态
enum CancelState: Int {
    case cancelTip1  // 注销提示1（不满足注销条件）
    case cancelTip2  // 注销提示1（通过认证后提示）
    case waitReview  // 注销成功
    case reviewIng   // 审核中
    case reject      // 审核拒绝
    case through     // 审核通过（撤销期内）
    case greaterUndo // 超过注销撤销期（撤销期为90天）
    case undefined   // 未定义
}

class HFCancelAccountResultView: UITableViewCell {
    
    @IBOutlet weak var stateImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTipLab: UILabel!
    @IBOutlet weak var contactServerBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var cancelSuccessView: UIView!
    @IBOutlet weak var tiplabel1: UILabel!
    @IBOutlet weak var tiplabel2: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    
    
    
    public var tipMessage: String?
    var cancelInfoModel: HFAuthCancelInfoModel?

    var operaClosure: ((_ index: CancelState) -> ())?
    
    var cancelState: CancelState = .cancelTip1 {
        
        didSet{
            self.cancelSuccessView.isHidden = true
            self.bottomView.isHidden = true
            if cancelState == .cancelTip1 {
                
                self.stateImgView.image = UIImage(named: "mine_warning_tixing")
                self.titleLabel.text = "注销无法完成"
                self.titleLabel.textColor = UIColor.hexColor(0xF5A623)
                self.detailLabel.text = tipMessage ?? "您与柒彩未来平台内的幼儿园关系尚未解除"
                self.detailTipLab.text = "请先解除与幼儿园的关系，再申请注销账号"
                self.detailLabel.isHidden = false
                self.detailTipLab.isHidden = false
                self.middleBtn.isHidden = true;
                self.contactServerBtn.isHidden = true
                
            }else if cancelState == .cancelTip2 {
                
                self.stateImgView.image = UIImage(named: "icon／toast／duihao")
                self.titleLabel.text = "您已经通过身份人认证"
                self.middleBtn.setTitle("确定注销", for: .normal)
                self.detailLabel.isHidden = true
                self.detailTipLab.isHidden = true
                self.middleBtn.isHidden = false;
                self.contactServerBtn.isHidden = true
                
            }else if cancelState == .waitReview {
                
                self.stateImgView.image = UIImage(named: "icon／toast／duihao")
                self.titleLabel.text = "您已成功申请账号注销\n请等待审核"
                self.middleBtn.setTitle("撤销注销申请", for: .normal)
                self.detailLabel.isHidden = true
                self.detailTipLab.isHidden = true
                self.middleBtn.isHidden = false;
                self.contactServerBtn.isHidden = true
                
            }else if cancelState == .reviewIng {
                cancelSuccess()

//                self.stateImgView.image = UIImage(named: "icon／toast／duihao")
//                self.titleLabel.text = "您已申请账号注销，慧凡正在审核中\n您可以撤回注销，之前数据立即恢复"
//                self.middleBtn.setTitle("撤销注销申请", for: .normal)
//                self.detailLabel.isHidden = true
//                self.detailTipLab.isHidden = true
//                self.middleBtn.isHidden = false;
//                self.contactServerBtn.isHidden = true
                
            }else if cancelState == .reject {
                
                cancelSuccess()

                // TODO:暂未规划
//                self.stateImgView.image = UIImage(named: "icon／toast／duihao")
//                self.titleLabel.text = "您已申请账号注销，慧凡正在审核中\n您可以撤回注销，之前数据立即恢复"
//                self.middleBtn.setTitle("撤销注销申请", for: .normal)
//                self.detailLabel.isHidden = true
//                self.detailTipLab.isHidden = true
//                self.middleBtn.isHidden = false;
//                self.contactServerBtn.isHidden = true
                
            }else if cancelState == .through {
                
                cancelSuccess()

                
//                self.stateImgView.image = UIImage(named: "mine_warning_tixing")
//                self.titleLabel.text = "账号已注销"
//                if let m = cancelInfoModel {
//                    self.detailLabel.text = "您的账号【\(m.usrPhone)】已经注销，不可以登陆使用柒彩未来【\(m.clientType)端】app, \(m.cancelDate)天内您可以操作\"撤回注销账号\""
//                }
//                self.middleBtn.setTitle("撤销注销申请", for: .normal)
//                self.detailLabel.isHidden = false
//                self.detailTipLab.isHidden = true
//                self.middleBtn.isHidden = false;
//                self.contactServerBtn.isHidden = true
                
            }else if cancelState == .greaterUndo {
                
                self.stateImgView.image = UIImage(named: "mine_warning_tixing")
                self.titleLabel.text = "您的账号已经注销\n您可以重新注册使用"
                self.middleBtn.setTitle("立即注册", for: .normal)
                self.detailLabel.isHidden = true
                self.detailTipLab.isHidden = true
                self.middleBtn.isHidden = false;
                self.contactServerBtn.isHidden = true
                
            }
        }
    }
    
    /// 申请注销成功
    func cancelSuccess() {
        self.stateImgView.image = UIImage(named: "mine_warning_tixing")
        self.titleLabel.text = "账号已注销"
        self.middleBtn.setTitle("撤销注销申请", for: .normal)
        self.detailLabel.isHidden = false
        self.detailTipLab.isHidden = true
        self.middleBtn.isHidden = false;
        self.contactServerBtn.isHidden = true
        
        if let m = cancelInfoModel {
            //            self.detailLabel.text = "您的账号【\(m.usrPhone)】已经注销，不可以登陆使用柒彩未来【\(m.clientType)端】app, \(m.cancelDate)天内您可以操作\"撤回注销账号\""
            let des = "您的账号\(m.usrPhone)已经注销，不可以登陆使用柒彩未来【\(m.clientType)端】app,\(m.cancelDate)天内您可以操作\"撤回注销账号\""
            let att = NSMutableAttributedString(string: des)
            att.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("F5A623"), range: NSRange(location: 4, length: 11))
            att.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("F5A623"), range: NSRange(location: 40, length: 3))
            self.tiplabel1.attributedText = att
            self.detailLabel.isHidden = true
            self.bottomView.isHidden = false
            self.middleBtn.isHidden = true
            self.cancelSuccessView.isHidden = false
//            self.tiplabel1.text = self.detailLabel.text
            let des1 = "温馨提示：\(m.restCancelDate)天后，将不可以撤回注销账号，账号信息将永久删除不可找回。"
            let att1 = NSMutableAttributedString(string: des1)
            att1.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("F5A623"), range: NSRange(location: 0, length: 5))
            self.tiplabel2.attributedText = att1
//            self.tiplabel2.text = "温馨提示：\(m.restCancelDate)天后，将不可以撤回注销账号，账号信息将永久删除不可找回。"
        }else{
            let des = "您的账号" + (HFUserInformation.userInfo()?.usrPhone ?? "")+"已经注销，不可以登陆使用柒彩未来【家长】app,90天内您可以操作\"撤回注销账号\""
            let att = NSMutableAttributedString(string: des)
            att.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("F5A623"), range: NSRange(location: 4, length: 11))
            att.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("F5A623"), range: NSRange(location: 39, length: 3))
            self.tiplabel1.attributedText = att
            
            self.detailLabel.isHidden = true
            self.bottomView.isHidden = false
            self.middleBtn.isHidden = true
            self.cancelSuccessView.isHidden = false
//            self.tiplabel1.text = self.detailLabel.text
            let des1 = "温馨提示：90天后，将不可以撤回注销账号，账号信息将永久删除不可找回。"
            let att1 = NSMutableAttributedString(string: des1)
            att1.addAttribute(.foregroundColor, value: UIColor.colorWithHexString("F5A623"), range: NSRange(location: 0, length: 5))
            self.tiplabel2.attributedText = att1
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func contactServerClick(_ sender: UIButton) {
        
        if operaClosure != nil {
            operaClosure!(self.cancelState)
        }
    }
    
    /// 中间按钮点击事件
    @IBAction func midBtnClick(_ sender: UIButton) {
        
        if operaClosure != nil {
            operaClosure!(self.cancelState)
        }
    }

}
