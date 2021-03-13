//
//  HFIdenAuthHeadView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/12/3.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFIdenAuthHeadView: UITableViewCell {

    ///正面
    @IBOutlet weak var positiveView: UIView!
    ///反面
    @IBOutlet weak var reverseView: UIView!
    ///营业执照
    @IBOutlet weak var businessLicenseView: UIView!
    /// 实名认证类型
    var type: IdentityAuthType = .personal {
        didSet {
            if type == .personal {
                self.businessLicenseView.isHidden = true
            }else{
                self.businessLicenseView.isHidden = false
            }
        }
    }
    
    /// 选择照片
    var selectPhotoTool = HFSelectImageTool()
    
    typealias HFIdenAuthHeadViewSlectImg = ((_ img: UIImage,_ index: Int)->())
    var selClosure: HFIdenAuthHeadViewSlectImg?
    var idCardFrontClosure: OptionClosure?
    var idCardBackClosure: OptionClosure?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.positiveView.layer.contents = UIImage(named: "bg_shenfen_zheng")?.cgImage
        self.reverseView.layer.contents = UIImage(named: "bg_shenfenzheng_beimian")?.cgImage
        self.businessLicenseView.layer.contents = UIImage(named: "bg_ident_auth_business_license")?.cgImage
 
    }

    @IBAction func selectClicked(_ sender: UIButton) {
        
        switch sender.tag {
        case 101:
//            self.selectPhotoTool.selectSinglePhoto(from: self.viewController()) { (img) in
//                if self.selClosure != nil {
//                    self.selClosure!(img, 0)
//                }
//            }
            if let block = self.idCardFrontClosure {
                block()
            }
            print("点击第一个按钮")
        case 102:
//            self.selectPhotoTool.selectSinglePhoto(from: self.viewController()) { (img) in
//                if self.selClosure != nil {
//                    self.selClosure!(img, 1)
//                }
//            }
            if let block = self.idCardBackClosure {
                block()
            }
            print("点击第二个按钮")
        default:
            self.selectPhotoTool.selectSinglePhoto(from: self.viewController()) { (img) in
                if self.selClosure != nil {
                    self.selClosure!(img, 2)
                }
            }
            print("点击第三个按钮")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
