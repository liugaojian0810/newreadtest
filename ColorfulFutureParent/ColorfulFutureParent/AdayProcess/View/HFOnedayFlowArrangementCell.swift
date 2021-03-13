//
//  HFOnedayFlowArrangementCell.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/22.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import ObjectMapper

class HFOnedayFlowArrangementCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var desBgView: UIView!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    //删除回调
    var deleteClosure: OptionClosure?
    
    var edit: Bool = false {
        
        didSet{
            if edit {
                // 编辑状态
                self.bgView.isHidden = false
                self.timeLabel.backgroundColor = .clear
                self.activityNameLabel.backgroundColor = .clear
                self.timeLabel.textColor = .colorWithHexString("666666")
                self.activityNameLabel?.textColor = .colorWithHexString("666666")
                self.desLabel.textColor = .colorWithHexString("666666")
                
                self.desBgView.backgroundColor = .clear
                self.bgView.drawsDottedBorder(0, borderColor: .colorWithHexString("00A693"), lineWidth: 1)
                
                if let m = dppaf {
                    if m.isChange {
                        self.bgView.backgroundColor = .colorWithHexString("41DDB8")
                    } else {
                        self.bgView.backgroundColor = .colorWithHexString("EDEDED")
                    }
                }
//                self.bgView.backgroundColor = .colorWithRGB(207, g: 243, b: 233)
                self.editBtn.isHidden = false
                self.deleteBtn.isHidden =  false
            }else{
                // 普通没有编辑状态
                self.bgView.isHidden = true
                self.timeLabel.backgroundColor = .colorWithHexString("F6F6F6")
                self.activityNameLabel.backgroundColor = .colorWithHexString("0DCCA0")
                self.activityNameLabel?.textColor = .colorWithHexString("FFFFFF")
                self.desBgView.backgroundColor = .colorWithHexString("F6F6F6")
                self.editBtn.isHidden = true
                self.deleteBtn.isHidden =  true
            }
        }
    }
    
    
    var dppaf: OnedayFlowDppafListModel? = nil {
        didSet {
            if dppaf != nil {
                timeLabel.text = dppaf!.dpkStartTime + "\n" + dppaf!.dpkEndTime
                activityNameLabel.text = dppaf?.dppName
                var dppName = ""
                if let pList = dppaf?.pfList {
                    for (index, seg) in pList.enumerated() {
                        if index == dppaf!.pfList!.count - 1 {
                            dppName.append("\(index+1)." + seg.pfName)
                        }else{
                            dppName.append("\(index+1)." + seg.pfName + "\n")
                        }
                    }
                }

                desLabel.text = dppName
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.deleteBtn.setEnlargeEdgeWithTop(5, right: 5, bottom: 5, left: 5)
        // Initialization code
    }

    
    func drawDottedLine() -> Void {
        
        self.contentView.drawsDotted(0, borderColor: .colorWithHexString("EDEDED"), lineWidth: 2)
    }
    
    
    @IBAction func removeItem(_ sender: UIButton) {
        
        if self.deleteClosure != nil {
            self.deleteClosure!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
