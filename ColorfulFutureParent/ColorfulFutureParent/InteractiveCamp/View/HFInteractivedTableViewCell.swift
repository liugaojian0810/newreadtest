//
//  HFInteractivedTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import Kingfisher

typealias interactivedBlock = (NSInteger) ->()

class HFInteractivedTableViewCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var lineViewbottom: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var lineViewTop: NSLayoutConstraint!
    @IBOutlet weak var timeBackIamge: UIImageView!
    @IBOutlet weak var teacherTableView: UIView!
    var  interactivedBlock: interactivedBlock?
    
    @IBOutlet weak var timeImage: UIImageView!
    public var interactivedRowModel: HUFList? = nil {
        didSet {
            self.classImageView.kf.setImage(with:ImageResource.init(downloadURL: URL.init(string: interactivedRowModel!.coursePhoto)!))

            
            let timestring: NSString = interactivedRowModel!.appointmentDate as NSString
            
            self.time.text = timestring.substring(with: NSMakeRange(0, 4)) as String + "\n" + timestring.substring(with: NSMakeRange(5, 2)) + "." + timestring.substring(with: NSMakeRange(8, 2)) as String
            self.time.attributedText = self.time.text?.AttributeString(string: self.time.text!, color: UIColor.white, font: UIFont.init(name: "ARYuanGB-MD", size: 12)!, range: NSMakeRange(5, 5))
            self.className.text = interactivedRowModel?.courseName

        }
    }
    
    open func reloadLineView(width:CGFloat) {
        UIView.drawLineOfDash(byCAShapeLayer: self.lineView, lineLength: 3, lineSpacing: 2, lineColor: UIColor.jk_color(withHexString: "#E3D5FF"))
    for view in self.teacherTableView.subviews {
        if view.tag == 444444444 {
            view .removeFromSuperview()
        }
    }
    var num = 0
    while num < (interactivedRowModel?.teachers.count)! {
        let tmodel: HUFTeacher = (interactivedRowModel?.teachers[num])!
        let view: UIView = UIView.init(frame: CGRect(x: 0, y: num * 70, width: Int(width), height: 70))
        let lab: UILabel = UILabel.init()
        view.tag = 444444444
        let str: String = tmodel.teacherName + ":" + tmodel.startTime + "~" + tmodel.endTime
        lab.textColor = UIColor.jk_color(withHexString: "#D4A171")
        lab.font = UIFont.init(name: "ARYuanGB-BD", size: 14)
        view.addSubview(lab)
        lab.attributedText = str.AttributeString(string: str, color: UIColor.jk_color(withHexString: "#666666"), font: UIFont.init(name: "ARyuanGB-MD", size: 15)!, range: NSMakeRange(0, tmodel.teacherName.count + 1))
        lab.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view.snp_centerY)
            make.left.equalTo(view.snp_left).offset(15)
        }
        let btn: UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        btn.titleLabel?.font = UIFont.init(name: "ARYuanGB-BD", size: 14)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.setTitle("预约", for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "button-yuyue"), for: .normal)
        btn.addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
        view.addSubview(btn)
        btn.tag = tmodel.appointmentIntervaID
        btn.snp_makeConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY)
            make.right.equalTo(view.snp_right).offset(-30)
        }
        let lineview: UIView = UIView.init()
        lineview.backgroundColor = UIColor.jk_color(withHexString: "#F6F6F6")
        view.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 69.5, left: 0, bottom: 0, right: 0))
        }
        self.teacherTableView.addSubview(view)
        num = num + 1
    }

    }
    @objc func tapped(button:UIButton){
        if self.interactivedBlock != nil {
            self.interactivedBlock!(button.tag)
        }
    }
    
    
}
