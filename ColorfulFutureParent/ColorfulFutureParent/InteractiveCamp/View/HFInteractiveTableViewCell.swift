//
//  HFInteractiveTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import Kingfisher

typealias interactiveBlock = (NSInteger) ->()

class HFInteractiveTableViewCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var lineViewbottom: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var lineViewTop: NSLayoutConstraint!
    @IBOutlet weak var timeBackIamge: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var timeImage: UIImageView!
    var interactiveBlock:interactiveBlock?
    
    public var rowModel: HFAList? = nil {
        didSet {
            self.className.text = rowModel?.courseName
            let middleLabel = rowModel!.teacherName + ":" + rowModel!.startTime + "~" + rowModel!.endTime
            self.teacherName.attributedText = middleLabel.AttributeString(string: middleLabel, color: UIColor.jk_color(withHexString: "#666666"), font: UIFont.init(name: "ARyuanGB-MD", size: 14)!, range: NSMakeRange(0, rowModel!.teacherName.count + 1))
            let bottomLabel = "预约情况\(String(describing: rowModel!.number))/\(String(describing: rowModel!.numberMax))"
            self.bottomLabel.attributedText = bottomLabel.AttributeString(string: bottomLabel, color: UIColor.jk_color(withHexString: "#FA9030"), font: UIFont.init(name: "ARyuanGB-MD", size: 14)!, range: NSMakeRange(5, 1))
            self.classImageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: rowModel!.coursePhoto)!))
            self.button.tag = rowModel!.hfAppointmentChildenId
            let timestring: NSString = rowModel!.appointmentDate as NSString
            self.time.text = timestring.substring(with: NSMakeRange(0, 4)) as String + "\n" + timestring.substring(with: NSMakeRange(5, 2)) + "." + timestring.substring(with: NSMakeRange(8, 2)) as String
            self.time.attributedText = self.time.text?.AttributeString(string: self.time.text!, color: UIColor.white, font: UIFont.init(name: "ARYuanGB-MD", size: 12)!, range: NSMakeRange(5, 5))

        }
    }
    
    open func reloadLineView() {
        UIView.drawLineOfDash(byCAShapeLayer: self.lineView, lineLength: 3, lineSpacing: 2, lineColor: UIColor.jk_color(withHexString: "#E3D5FF"))

    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        if self.interactiveBlock != nil {
            self.interactiveBlock!(sender.tag)
        }
    }
}


extension String {
    func AttributeString(string: String, color:UIColor, font:UIFont, range:NSRange) -> NSMutableAttributedString {
        let attriutedStr = NSMutableAttributedString.init(string: string)
        var dic = [NSAttributedString.Key: Any]()
        dic[NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)] = color
        dic[NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)] = font
        attriutedStr.addAttributes(dic, range: range)
        return attriutedStr
        
    }
}
