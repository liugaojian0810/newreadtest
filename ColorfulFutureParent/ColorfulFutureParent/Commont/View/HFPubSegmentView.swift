//
//  HFPubSegmentView.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/7/27.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPubSegmentView: UIView {
    
    var names: [String]?
    var sliderLine: UIView?
    var seperatorLine: UIView?
    var curBtn: UIButton?
    var firstBtn: UIButton?

    
    typealias SegItemClickClosure = (_ clickIndex: Int) -> ()
    @objc var clickClosure: SegItemClickClosure?
    
    //自定义构造器
    @objc convenience init(frame: CGRect, itemNames:[String]) {
        self.init(frame: frame)
        names = itemNames
        createSubItems()
    }
    
    //初始化方法 纯代码
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    //初始化方法 可视化
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //创建选项卡子项目
    func createSubItems() -> Void {
        
        for index in 0..<self.names!.count {
            
            let btn = UIButton(type: .custom)
            self.addSubview(btn)
            let names = self.names![index]
            let width = Double(self.frame.size.width/CGFloat(self.names!.count))
            let height = Double(self.frame.size.height - 4)
            let orignalX = width * Double(index)
            btn.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(orignalX)
                make.height.equalTo(height)
                make.width.equalTo(width)
            }
            btn.setTitle(names, for: .normal)
            btn.backgroundColor = .red
            btn.setTitleColor(.hexColor(0x303030), for: .normal)
            btn.setTitleColor(.colorMain(), for: .selected)
            btn.backgroundColor = .white
            if index == 0 {
                btn.titleLabel?.font = UIFont.init(name: "PingFangSC-Semibold", size: 15)
                btn.isSelected = true
                self.curBtn = btn
            }else{
                btn.isSelected = false
                btn.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
            }
            btn.tag = index
            btn.addTarget(self, action: Selector.itemClick, for: .touchUpInside)
            
            if index == 0 {
                self.firstBtn = btn
                let sliderLine = UIView()
                sliderLine.backgroundColor = .colorMain()
                sliderLine.layer.cornerRadius = 1.5
                sliderLine.layer.masksToBounds = true
                self.sliderLine = sliderLine
                self.addSubview(sliderLine)
                self.sliderLine!.snp.makeConstraints { (make) in
                    //                    make.bottom.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-1)
                    make.width.equalTo(25)
                    make.height.equalTo(3)
                    make.centerX.equalTo(curBtn!)
                }
            }
        }
        
        //底部线条
        let seperatorLine = UIView()
        seperatorLine.backgroundColor = .colorWithHexString("EAEDF2")
        self.seperatorLine = seperatorLine
        self.addSubview(seperatorLine)
        self.seperatorLine!.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }
    
    @objc func itemClick(sender: UIButton) -> Void {
        self.curBtn?.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
        self.curBtn?.isSelected = false
        self.curBtn = sender
        self.curBtn?.titleLabel?.font = UIFont.init(name: "PingFangSC-Semibold", size: 15)
        self.curBtn?.isSelected = true
        self.sliderLine!.snp.removeConstraints()
        
        UIView.animate(withDuration: 0.25) {
            
            self.sliderLine?.jk_centerX = CGFloat((self.curBtn?.center.x)!)
            
            //            self.sliderLine!.snp.updateConstraints { (make) in
            //                make.centerX.equalTo(self.curBtn!)
            //                make.bottom.equalToSuperview()
            //                make.width.equalTo(25)
            //                make.height.equalTo(3)
            //            }
        }
        
        if clickClosure != nil{
            clickClosure!(sender.tag)
        }
    }
    
    // 选中第一个item
    func selectedFirstItem() -> Void {
        self.itemClick(sender: self.firstBtn!)
    }
    
}


private extension Selector{
    
    static let itemClick = #selector(HFPubSegmentView.itemClick)
    
}
