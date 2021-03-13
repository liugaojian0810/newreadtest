//
//  HFVideoPlayEnumView.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import SnapKit


/// 菜单类型
enum PlayEnumList: Int {
    case playback;          // 回放
    case classCard;         // 课程表
    case share              // 分享
}

/// 视频播放菜单列表单个视图
class HFVideoPlayEnumItemView: UIView {
    
    /// 菜单图标数组
    let enumDicIcon = ["icon_huifang", "icon_cangbaotu", "icon_fenxiang"]
    
    /// 菜单标题数组
    let enumDicTitle = ["冲关回放", "寻宝图", "分享"]
    
    /// 设置菜单按钮的标题和图标
    var playType: PlayEnumList {
        willSet{
            let rawValue = newValue.rawValue
            iconIMG.image = UIImage.init(named: enumDicIcon[rawValue])
            titleLab.text = enumDicTitle[rawValue]
        }
    };
    
    /// 初始化菜单按钮图标View
    lazy var iconIMG: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    /// 初始化菜单标题View
    lazy var titleLab: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12)
        title.textColor = .white
        return title
    }()
    
    /// 菜单View创建构造函数
    /// - Parameter frame: 菜单View的坐标和大小
    override init(frame: CGRect) {
        self.playType = .playback
        super.init(frame:frame)
        self.addMySubViews()
        self.setSnak()
    }
    
    /// 添加子View
    /// - Returns: NULL
    func addMySubViews() -> Void {
        addSubview(iconIMG)
        addSubview(titleLab)
    }
    
    /// 设置子View的位置与大小
    /// - Returns: NULL
    func setSnak() -> Void {
        iconIMG.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconIMG.snp_bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
