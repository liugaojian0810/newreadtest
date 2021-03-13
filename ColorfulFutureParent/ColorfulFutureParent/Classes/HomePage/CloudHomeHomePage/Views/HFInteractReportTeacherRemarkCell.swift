//
//  HFInteractReportTeacherRemarkCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2020/12/10.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractReportTeacherRemarkCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inputStatistLabel: UILabel!
    @IBOutlet weak var inputBgView: UIView!
    
    var placeHolder = ""
    
    var inputCallBack: OptionClosureString?
    
    let triangleLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        triangleLayer.fillColor = UIColor.hexColor(0xDEF4FF).cgColor
        // 画三角
        let point = CGPoint.init(x: 60, y: 112.5)
        let y1 = (point.y) + 10
        let x1 = (point.x) - 10
        let x2 = (point.x) + 10
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: point)
        trianglePath.addLine(to: CGPoint(x: x1, y: y1))
        trianglePath.addLine(to: CGPoint(x: x2, y: y1))
        
        trianglePath.close()
        
        triangleLayer.path = trianglePath.cgPath
        contentView.layer.addSublayer(triangleLayer)
        
        textView.jk_maxLength = 200
        textView.delegate = self
        
        contentView.backgroundColor = .colorBg()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if inputCallBack != nil {
            inputCallBack!(textView.text ?? "")
        }
        if textView.text.isEmptyStr() {
            textView.jk_addPlaceHolder(placeHolder)
        }else{
            textView.jk_addPlaceHolder("")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
