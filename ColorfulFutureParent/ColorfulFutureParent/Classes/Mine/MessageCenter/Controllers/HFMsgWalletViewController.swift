//
//  HFMsgWalletViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by 范斗鸿 on 2020/12/4.
//  Copyright © 2020 huifan. All rights reserved.
//
// 钱包消息详情

import UIKit

class HFMsgWalletViewController: HFNewBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myViewModel = HFMessageCenterViewModel() // 消息事务处理

    var messageModel: HFMessageListModel? // 钱包消息数据模型
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        getMsgDetail()
    }
    
    private func config() -> Void {
        
        self.title = "明细详情"
        
        view.backgroundColor = .colorBg()
        
        tableView.backgroundColor = .colorBg()
        tableView.register(byIdentifiers: ["HFMsgWalletTableViewCell","HFMsgWalletEntryTableViewCell"])
    }
    
    
    func getMsgDetail() -> Void {
        ShowHUD.showHUDLoading()
        myViewModel.getMsgDetail(self.messageModel!.plId) {
            Asyncs.async({
            }) {
                self.tableView.reloadData()
            }
        } _: {  }
    }
    
}

extension HFMsgWalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFMsgWalletTableViewCell") as! HFMsgWalletTableViewCell
            cell.titleLabel.text = "代理云家园返利"
            cell.contentLabel.text = "+990.00"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFMsgWalletEntryTableViewCell") as! HFMsgWalletEntryTableViewCell
            cell.titleLabel.text = "收入金额"
            cell.contentLabel.text = "+100.00"
            return cell
        }
    }
}

extension HFMsgWalletViewController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 130
        default:
            let height = "+100.00".get_heightForComment(fontSize: 13, width: S_SCREEN_WIDTH - (28 * 2) - 80)
            if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1 {
                return height + 12
            }
            return height + 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let HFcell = cell
        // 圆角弧度半径
        let cornerRadius:CGFloat = 8
        // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
        HFcell.backgroundColor = .clear
        // 创建一个shapeLayer
        let layer = CAShapeLayer()
        //显示选中
        let backgroundLayer = CAShapeLayer()
        // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
        let pathRef = CGMutablePath()
        // 获取cell的size
        // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
        let bounds = HFcell.bounds.insetBy(dx: 12, dy: 0)
        if tableView.numberOfRows(inSection: indexPath.section) == 1 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: CGPoint(x:bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.minX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        } else if indexPath.row == 0 {
            //               // 初始起点为cell的左下角坐标
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            //  起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // 初始起点为cell的左上角坐标
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        } else {
            // 添加cell的rectangle信息到path中（不包括圆角）
            pathRef.addRect(bounds)
        }
        // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
        layer.path = pathRef
        backgroundLayer.path = pathRef
        // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
        // 按照shape layer的path填充颜色，类似于渲染render
        layer.fillColor = UIColor.white.cgColor
        // view大小与cell一致
        let roundView = UIView(frame: bounds)
        // 添加自定义圆角后的图层到roundView中
        roundView.layer.insertSublayer(layer, at: 0)
        roundView.backgroundColor = UIColor.jk_color(withHexString: "#F6F6F6")
        // cell的背景view
        HFcell.backgroundView = roundView
        // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
        // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
        let selectedBackgroundView = UIView(frame: bounds)
        backgroundLayer.fillColor = UIColor.white.cgColor
        selectedBackgroundView.layer .insertSublayer(backgroundLayer, at: 0)
        selectedBackgroundView.backgroundColor = .white
        HFcell.selectedBackgroundView = selectedBackgroundView
    }
}
