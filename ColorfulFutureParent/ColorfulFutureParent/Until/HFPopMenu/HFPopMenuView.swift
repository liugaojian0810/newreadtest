//
//  HFPopMenuView.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/11/12.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

/// 屏幕frame相关便捷方法
struct ScreenInfo {
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    static private func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64
    }
}
/// 默认的cell高度宽度,可修改
let itemHeight: CGFloat = 44.0
let itemWidth: CGFloat = 113.0

class HFPopMenuView: UIView,UITableViewDelegate, UITableViewDataSource {
    public var touchBlock: ( () -> Void )?
    /// 点击cell回调
    public var indexBlock: ( (Int) -> Void )?
    /// 起始点,tableView上三角形的顶部
    private var point:CGPoint?
    /// tableView.height
    private var layerHeight: CGFloat?
    /// tableView.width
    private var layerWidth: CGFloat?
    private var dataArr = [HFPopViewModel]()

    private var tableView: UITableView = UITableView()
    /// init
    ///
    /// - Parameters:
    ///   - width: tableView.width
    ///   - height: tableView最大height,如果cell数量大于4,则是tableView.frame.size.height
    ///   - point: 初始点,tableView上的三角形的顶点
    ///   - items: 每个cell的title数组
    ///   - imgSource: 每个cell的icon数组,可为空
    ///   - action: 回调方法
    init(width: CGFloat, height: CGFloat, point: CGPoint, dataArr: [HFPopViewModel],  action: ((Int) -> Void)?) {
        super.init(frame:CGRect(x: 0, y: 0, width: ScreenInfo.Width, height: ScreenInfo.Height))
        drawMyTableView()
        /// view全屏展示
        self.frame = CGRect(x: 0, y: 0, width: ScreenInfo.Width, height: ScreenInfo.Height)
        /// 获取起始点
        self.point = CGPoint(x: point.x, y: point.y)
        /// tableView高度由init方法传入
        self.layerWidth = width
        self.dataArr.removeAll()
        self.dataArr += dataArr
        
        /// 弱引用防止闭包循环引用
        weak var weakSelf = self
        if action != nil {
            weakSelf?.indexBlock = { row in
                /// 点击cell回调,将点击cell.indexpath.row返回
                action!(row)
            }
        }
        /// tableView高度,如果大于4个则为4个itemHeight,使tableView可滑动,如果小于4个则动态显示
        self.layerHeight = dataArr.count > 4 ? height : CGFloat(CGFloat(dataArr.count) * itemHeight)
        self.addSubview(self.tableView)
        /// 将tableView.frame更新,使其在展示正确效果
        let y1 = (self.point?.y)! + 10
        let x2 = (self.point?.x)! - self.layerWidth! + 20
        tableView.frame = CGRect(x: x2, y: y1, width: self.layerWidth!, height: self.layerHeight!)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawMyTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.showsHorizontalScrollIndicator = true
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = true
        tableView.isScrollEnabled = false
        tableView.register(byIdentifiers: ["HFPopViewCell"])
    }
    /// drawRect方法,画tableView上的小三角形
    override func draw(_ rect: CGRect) {
        let y1 = (self.point?.y)! + 10
        let x1 = (self.point?.x)! - 10
        let x2 = (self.point?.x)! + 10
        
        UIColor.hexColor(0x333333).set()

        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.move(to: CGPoint(x: (self.point?.x)!, y: (self.point?.y)!))
        context?.addLine(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y1))
        context?.closePath()
        context?.fillPath()
        context?.drawPath(using: .stroke)
    }
    /// 点击屏幕任意位置menu消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.touchBlock != nil {
            touchBlock!()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFPopViewCell") as! HFPopViewCell
        cell.contentView.backgroundColor = UIColor.hexColor(0x333333)
        let model = dataArr[indexPath.row]
        cell.model = model
        cell.lineView.isHidden = dataArr.count-1 == indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexBlock!(indexPath.row)
    }
}

