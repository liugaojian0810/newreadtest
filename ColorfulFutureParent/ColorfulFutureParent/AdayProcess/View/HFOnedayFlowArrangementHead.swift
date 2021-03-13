//
//  HFOnedayFlowArrangementHead.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/22.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFOnedayFlowArrangementHead: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func drawDottedLine() -> Void {

        self.drawsDotted(0, borderColor: .colorWithHexString("EDEDED"), lineWidth: 2)
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
