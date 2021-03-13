//
//  HFOrdereItemModel.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/2/1.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation

protocol HFOrdereItemModelProtocol {
    var itemModels: [HFOrdereItemModel] {get}
}

class HFOrdereItemModel {
    var title = ""
    var text = ""
    var attributedText: NSAttributedString?
    var showArrow = false
}
