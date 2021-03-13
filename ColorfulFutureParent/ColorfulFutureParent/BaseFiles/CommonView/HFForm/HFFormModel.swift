//
//  HFFormModel.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

enum CellType {
    case left_right_Input // 左右结构输入框
    case top_bottom_Input // 上下结构输入框
    case left_right_Select // 左右结构选择
    case image
    case other // 其它
}
enum ParamType {
    case kiName  // 幼儿园名称
    case kiAds // 幼儿园详细地址
    case usrFullName // 总园长-姓名
    case usrPhone // 总园长-手机号
    case kiQuotaTotal  // 幼儿园总容纳量
    case kiQuotaMini
    case kiQuotaMin
    case kiQuotaMid
    case kiQuotaBig
    case kiQuotaMax
    case kieLegalPerson
    case kieIndoorArea
    case kieOutdoorArea
    case kieWebsite
    case kieEmail
    case kiePcd //
    case kieQq // qq
    case kieTiktok // 抖音号
    case kiTeamsNum // 班级数量
}

class HFFormBaseModel: NSObject {
    var title: String? // 左边的标题
    var titleFont: UIFont = UIFont.init(name: "ARYuanGB-MD", size: 15)!
    var titleColor: UIColor = .hexColor(0x333333)
    var contentText: String? // 内容文本
    var contentFont: UIFont = UIFont.init(name: "ARYuanGB-BD", size: 15)!
    var contentColor: UIColor = .hexColor(0x333333)
    var rightTitle: String? // 右边的文案
    var leftMargin: CGFloat = 16 // 左边距
    var rightMargin: CGFloat = 16 // 右边距
    var serverKey: String? // 服务端对应的key
    var cellType: CellType = .left_right_Input
    var textAlignment: NSTextAlignment? // 设置输入框对齐方式
    
    var remarkKey = "" // 冗余字段
}

/// 图片
class HFFormImageCellModel: HFFormBaseModel {
    var onlyShow: Bool = false // 是否仅显示
    var imageUrl: String? // 图片链接
    var image: UIImage? // 图片
    var placeholder: UIImage? // 占位图
    
    init(cellType: CellType, onlyShow: Bool, imageUrl: String?, image: UIImage?, placeholder: UIImage?) {
        super.init()
        self.cellType = cellType
        self.onlyShow = onlyShow
        self.imageUrl = imageUrl
        self.image = image
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 文本
class HFFormTextInputCellModel: HFFormBaseModel {
    var onlyShow: Bool = false // 是否仅显示
    var maxLength: Int = 0 // 输入最大长度限制，默认为0，不限制
    var placeholder: String? // 占位内容
    var keyboardType: UIKeyboardType = .default
    var paramType: ParamType?
    
    init(title: String? = nil, placeholder: String? = nil, contentText: String? = nil, maxLength: Int = 0, onlyShow: Bool = false, cellType: CellType = .left_right_Input, rightTitle: String? = nil, keyboardType: UIKeyboardType = .default, textAlignment: NSTextAlignment = .right, paramTyp: ParamType? = nil) {
        super.init()
        self.title = title
        self.cellType = cellType
        self.onlyShow = onlyShow
        self.maxLength = maxLength
        self.placeholder = placeholder
        self.contentText = contentText
        self.rightTitle = rightTitle
        self.keyboardType = keyboardType
        self.textAlignment = textAlignment
        self.paramType = paramTyp
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEmpty() -> Bool {
        return contentText == "" || contentText == nil
    }
}

/// 选择
class HFFormSelectCellModel: HFFormBaseModel {
    var placeholder: String? // 占位内容
    var subType: HFSelectorPubType? // 子类型
    func isEmpty() -> Bool {
        return contentText == "" || contentText == nil
    }
    init(title: String? = nil, placeholder: String? = nil, cellType: CellType = .left_right_Input, subType: HFSelectorPubType? = nil) {
        super.init()
        self.title = title
        self.placeholder = placeholder
        self.cellType = cellType
        self.subType = subType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 单选框
class HFFormRadioBoxCellModel: HFFormBaseModel {
    var leftRadioName = "否" // 左边选项标题
    var rightRadioName = "是" // 右边选项标题
    var selectedIndex: Int = -1 // 默认未选择，0否，1是
    
    func isEmpty() -> Bool {
        return selectedIndex == -1
    }
}
