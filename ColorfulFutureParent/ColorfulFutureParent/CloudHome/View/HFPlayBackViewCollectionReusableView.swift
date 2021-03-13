//
//  HFPlayBackViewCollectionReusableView.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPlayBackViewCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var time: UILabel!
    public var sectionModel: HUIModel? = nil {
        didSet {
            self.time.text = sectionModel?.appointmentDate.subString(rang: NSMakeRange(5, 5))
            //计算时间
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date: NSDate = dateFormatter.date(from: sectionModel!.appointmentDate)! as NSDate
            let nowDate:NSDate = NSDate()
            let calendar: NSCalendar = NSCalendar.current as NSCalendar
            let dateComponents = calendar.components([ NSCalendar.Unit.weekday], from: date as Date)
            let nowDateComponents = calendar.components([ NSCalendar.Unit.weekday], from: nowDate as Date)

            let weekArr: Array = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
            self.week.text = weekArr[dateComponents.weekday! - 1]
            if dateComponents.weekday == nowDateComponents.weekday {
                self.week.text = "今天"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
