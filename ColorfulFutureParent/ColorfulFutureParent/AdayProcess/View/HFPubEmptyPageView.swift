//
//  HFPubEmptyPageView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/7/28.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

enum EmptyType {
    
    case isDefault //默认样式
    case isNoOrder //无订单
    case isNoNetwork //无网络
    case isNoData //无数据
    case isNoMessage //无消息
    case isNoComeIn //无收入
    case isNoCourseDefault //无课程默认
    case isNoCourseAddShopCar //无课程添加购物车
    case isNoKindergarten //无课程添加购物车
    case isNoClass //无班级
}

class HFPubEmptyPageView: UIView {
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .clear
        return img
    }()
    
    lazy var tip: UILabel = {
        let tip = UILabel()
        tip.textAlignment = .center
        tip.textColor = .colorWithHexString("ACB1BC")
        tip.font = .systemFont(ofSize: 13)
        tip.backgroundColor = .clear
        return tip
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .colorWithHexString("FF844B")
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.isHidden = false
        btn.layer.cornerRadius = 18
        btn.layer.masksToBounds = true
        return btn
    }()
    
    var type: EmptyType = .isDefault
    var clickedClosure: OptionClosure?
    
    public static func initEmptyViewType(_ type: EmptyType) -> HFPubEmptyPageView {
        let emptyView = HFPubEmptyPageView(frame: CGRect(x: 0, y: 0, width: 212, height: 210 + 36), emptytype: type)
        return emptyView;
    }
    
    convenience init(frame: CGRect, emptytype: EmptyType) {
        self.init(frame: frame)
        self.type = emptytype
        setTipMsg()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }
    
    func createSubViews() -> Void {
        addSubview(self.img)
        addSubview(self.tip)
        addSubview(self.btn)
        setSnaps()
    }
    
    func setSnaps() -> Void {
        
        self.img.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        self.tip.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(img.snp.bottom).offset(24)
        }
        self.btn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tip.snp.bottom).offset(24)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }
    
    @objc func btnClicked(_ sender: UIButton) {
        
        if clickedClosure != nil {
            clickedClosure!()
        }
    }
    
    func setTipMsg() -> Void {
        switch type {
        case .isDefault:
            print("")
            self.tip.text = "暂无数据"
            self.img.image = UIImage(named: "empty_img_shuju")
        case .isNoOrder:
            self.tip.text = "还没有订单哦~"
            self.img.image = UIImage(named: "empty_img_dingdan")
        case .isNoNetwork:
            self.tip.text = "当前没有网络哦~"
            self.img.image = UIImage(named: "empty_img_wangluo")
        case .isNoData:
            self.tip.text = "暂无数据"
            self.img.image = UIImage(named: "empty_img_shuju")
        case .isNoMessage:
            self.tip.text = "还没有消息哦~"
            self.img.image = UIImage(named: "empty_img_xiaoxi")
        case .isNoComeIn:
            self.tip.text = "还没有收入哦~"
            self.img.image = UIImage(named: "empty_img_shouru")
        case .isNoCourseDefault:
            self.tip.text = "还没有课程哦~"
            self.img.image = UIImage(named: "empty_img_kecheng")
        case .isNoCourseAddShopCar:
            self.tip.text = "快来添加购物车吧"
            self.img.image = UIImage(named: "empty_img_gouwu")
        case .isNoKindergarten:
            self.tip.text = "暂无搜索结果哦~"
            self.img.image = UIImage(named: "empty_img_shuju")
        case .isNoClass:
            self.tip.text = "当前还未创建班级"
            self.img.image = UIImage(named: "empty_img_shouru")
        default:
            self.tip.text = "暂无数据"
            self.img.image = UIImage(named: "empty_img_shuju")
        }
    }
    
    
}
