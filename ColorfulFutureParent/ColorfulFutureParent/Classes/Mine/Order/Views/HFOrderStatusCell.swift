//
//  HFOrderStatusCell.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/28.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFOrderStatusCell: UITableViewCell {
    
    @IBOutlet weak var orderStatusLab: UILabel! // 订单状态
    @IBOutlet weak var option1Btn: UIButton! // 操作按钮1，最右边的按钮
    @IBOutlet weak var option2Btn: UIButton! // 操作按钮2
    
    // 继续支付
    var payOption: OptionClosure?
    // 取消订单
    var cancelOption: OptionClosure?
    // 删除订单
    var deleteOption: OptionClosure?
    
    var orderModel: Any? {
        didSet {
            if let model = orderModel as? HFGemOrderModel {
                updateUI(status: model.boiStatus)
            }
            if let model = orderModel as? HFBusOrderModel {
                updateUI(status: model.boiStatus)
            }
        }
    }
    
    // 0待支付，1支付中，9完成订单，-1取消
    func updateUI(status: Int) -> Void {
        switch status {
        case 0:
            orderStatusLab.text = "待支付"
            option2Btn.isHidden = false
            option2Btn.jk_cornerRadius(8, strokeSize: 1, color: .colorMain())
            option2Btn.jk_setBackgroundColor(.white, for: .normal)
            option2Btn.setTitleColor(.colorMain(), for: .normal)
            option2Btn.setTitle("取消订单", for: .normal)
            option1Btn.jk_cornerRadius(8, strokeSize: 1, color: .hexColor(0xFF911F))
            option1Btn.jk_setBackgroundColor(.hexColor(0xFF911F), for: .normal)
            option1Btn.setTitleColor(.white, for: .normal)
            option1Btn.setTitle("继续支付", for: .normal)
        case 1:
            orderStatusLab.text = "待支付"
            option2Btn.isHidden = false
            option2Btn.jk_cornerRadius(8, strokeSize: 1, color: .colorMain())
            option2Btn.jk_setBackgroundColor(.white, for: .normal)
            option2Btn.setTitleColor(.colorMain(), for: .normal)
            option2Btn.setTitle("取消订单", for: .normal)
            option1Btn.jk_cornerRadius(8, strokeSize: 1, color: .hexColor(0xFF911F))
            option1Btn.jk_setBackgroundColor(.hexColor(0xFF911F), for: .normal)
            option1Btn.setTitleColor(.white, for: .normal)
            option1Btn.setTitle("继续支付", for: .normal)
        case 9:
            orderStatusLab.text = "已完成"
            option2Btn.isHidden = true
            option1Btn.jk_cornerRadius(8, strokeSize: 1, color: .hexColor(0x666666))
            option1Btn.jk_setBackgroundColor(.white, for: .normal)
            option1Btn.setTitleColor(.hexColor(0x666666), for: .normal)
            option1Btn.setTitle("删除订单", for: .normal)
        case -1:
            orderStatusLab.text = "已取消"
            option2Btn.isHidden = true
            option1Btn.jk_cornerRadius(8, strokeSize: 1, color: .hexColor(0x666666))
            option1Btn.jk_setBackgroundColor(.white, for: .normal)
            option1Btn.setTitleColor(.hexColor(0x666666), for: .normal)
            option1Btn.setTitle("删除订单", for: .normal)
        default:
            break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        option1Btn.jk_setRoundedCorners(.allCorners, radius: 8)
        option2Btn.jk_setRoundedCorners(.allCorners, radius: 8)
    }
    
    // 点击操作按钮1
    @IBAction func clickOption1Action(_ sender: UIButton) {
        if let model = orderModel as? HFGemOrderModel {
            handleClick(status: model.boiStatus)
        }
        if let model = orderModel as? HFBusOrderModel {
            handleClick(status: model.boiStatus)
        }
    }
    
    func handleClick(status: Int) -> Void {
        switch status {
        case 0,1:
            if payOption != nil {
                payOption!()
            }
        case 9,-1:
            if deleteOption != nil {
                deleteOption!()
            }
        default:
            break
        }
    }
    
    // 点击操作按钮2
    @IBAction func clickOption2Action(_ sender: UIButton) {
        if cancelOption != nil {
            cancelOption!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
