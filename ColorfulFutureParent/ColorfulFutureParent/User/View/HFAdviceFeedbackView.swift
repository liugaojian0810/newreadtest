//
//  HFAdviceFeedbackView.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/22.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFAdviceFeedbackView: UIView, UITextViewDelegate {
    
    @IBOutlet weak var suggestButton: UIButton!
    @IBOutlet weak var feedBackButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    var imgs: Array<UIImage> = []
    var curIndex: Int = 0
    var suggest: Bool = true

    var selectPhotoTool: HFSelectImageTool?
    
    
    /// 反馈
    /// - Parameter sender: <#sender description#>
    @IBAction func feedBack(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.suggestButton.isSelected = !sender.isSelected
        suggest = false
    }
    
    
    /// 建议
    /// - Parameter sender: <#sender description#>
    @IBAction func suggest(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.feedBackButton.isSelected = !sender.isSelected
        suggest = true
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton) {
        switch sender.tag {
        case 101:
            self.curIndex = 0
        case 102:
            self.curIndex = 1
        default:
            self.curIndex = 2
        }
        if self.selectPhotoTool == nil {
            self.selectPhotoTool = HFSelectImageTool.init()
        }
        self.selectPhotoTool?.selectSinglePhoto(from: self.jk_viewController, complete: { (image) in
            
            switch self.imgs.count{
            case 0:
                self.imgs.append(image)
            default:
                if self.imgs.count == self.curIndex + 1 {
                    self.imgs[self.curIndex] = image
                }else{
                    self.imgs.append(image)
                }
            }
            
            let numbers = self.imgs.count
            switch numbers{
            case 0:
                self.leftBtn.isHidden = false
                self.middleBtn.isHidden = true
                self.rightBtn.isHidden = true
            case 1:
                self.leftBtn.isHidden = false
                self.middleBtn.isHidden = false
                self.rightBtn.isHidden = true
            case 2:
                self.leftBtn.isHidden = false
                self.middleBtn.isHidden = false
                self.rightBtn.isHidden = false
            case 3:
                self.leftBtn.isHidden = false
                self.middleBtn.isHidden = false
                self.rightBtn.isHidden = false
            default:
                print("牛逼呀")
            }
            
            switch self.curIndex {
            case 0:
                self.leftBtn .setImage(self.imgs[0], for: .normal)
            case 1:
                self.middleBtn .setImage(self.imgs[1], for: .normal)
            default:
                self.rightBtn .setImage(self.imgs[2], for: .normal)
            }
        })
    }
    
    
    /// 提交反馈结果
    /// - Parameter sender: <#sender description#>
    @IBAction func submitFeedBack(_ sender: UIButton) {
        
        
        
    }
}
