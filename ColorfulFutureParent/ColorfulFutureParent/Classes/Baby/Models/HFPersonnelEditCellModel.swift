//
//  HFPersonnelEditCellModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/3.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

enum HFPersonnelEditCellType {
    case input // 输入
    case gotoInput // 跳转输入
    case multInput // 多行输入（多行文本）
    case select //选择
    case onlySelect // 单选（是/否）
    case onlyShow // 仅显示
    case header // 头像
    case dateInterval // 选择时间间隔
}

class HFPersonnelEditCellModel: NSObject {
    var type: HFPersonnelEditCellType = .input
    var title = ""
    var value = "" {
        didSet {
            if valueChangeBlock != nil {
                self.valueChangeBlock!(value)
            }
        }
    }
    var value1 = "" {
        didSet {
            if valueChangeBlock != nil {
                self.valueChangeBlock!(value)
            }
        }
    }
    var placeholder = ""
    var placeholder1 = ""
    var keyboardType: UIKeyboardType?
    var serverKey = ""
    var valueChangeBlock: OptionClosureString?
    var maxLength = 0
    
    init(type: HFPersonnelEditCellType, title: String, value: String, placeholder: String,serverKey: String) {
        super.init()
        
        self.type = type
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.serverKey = serverKey
    }
    
    init(type: HFPersonnelEditCellType, title: String, value: String, placeholder: String,valueChangeBlock: @escaping OptionClosureString) {
        super.init()
        
        self.type = type
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.valueChangeBlock = valueChangeBlock
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
