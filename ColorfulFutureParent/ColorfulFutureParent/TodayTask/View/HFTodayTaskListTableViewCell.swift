//
//  HFTodayTaskListTableViewCell.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/18.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import Kingfisher
typealias todayTaskBlock = (NSInteger) ->()


class HFTodayTaskListTableViewCell: UITableViewCell {
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var todayTaskButton: UIButton!
    var block: todayTaskBlock?
    public var rowModel: HFTodayTaskListModelElement? = nil {
        didSet {
            self.time.text = rowModel!.startDate + "-" + rowModel!.endDate
            self.name.text = rowModel?.courceName
            self.subtitle.text = rowModel?.courceSystem
            self.todayTaskButton.tag = rowModel!.teacherID
            self.classImageView?.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: rowModel!.courseImg)!))
            self.type.text = rowModel?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        if self.block != nil  {
            self.block!(sender.tag)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
