//
//  HFOrderListViewController.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/30.
//  Copyright © 2021 huifan. All rights reserved.
//
// 订单列表控制器

import UIKit

class HFOrderListViewController: HFNewBaseViewController {

    let viewModel = HFMyOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
        addRefrashOpera()
    }
    
    // MARK: 数据请求和刷新操作
    func addRefrashOpera() -> Void {
        
        self.tableView.headerRefreshingBlock { (pageNum) in
            self.requestData(pageNum)
        }
        self.tableView.footerRefreshingBlock { (pageNum) in
            self.requestData(pageNum)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    private func requestData(_ pageNum: Int) -> Void {
        
        viewModel.getOrderList(pageNum: pageNum) {
            Asyncs.async({
                print("订单列表请求完成")
            }) {
                self.tableView.showNoDataNotice = true
                self.tableView.endRefresh(byIsDownRefresh: pageNum == 1, isRequestSuccess: true, total: self.viewModel.orderTotal, pageSize: 20)
                self.tableView.reloadData()
            }
        } _: {
            Asyncs.async({
                print("订单列表请求完成")
            }) {
                self.tableView.showNoDataNotice = true
                self.tableView.endRefresh(byIsDownRefresh: pageNum == 1, isRequestSuccess: false, total: self.viewModel.orderTotal, pageSize: 20)
                self.tableView.reloadData()
            }
        }
    }
    
    func config() -> Void {
        self.title = "我的订单"
        
        self.tableView.backgroundColor = .colorBg()
        self.tableView.register(byIdentifiers: ["HFOrderItemCell","HFOrderStatusCell"])
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HFOrderListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = viewModel.dataArr[section]
        return model.itemModels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderModel = viewModel.dataArr[indexPath.section]
        if indexPath.row != orderModel.itemModels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFOrderItemCell") as! HFOrderItemCell
            let item = orderModel.itemModels[indexPath.row]
            cell.itemModel = item
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFOrderStatusCell") as! HFOrderStatusCell
            cell.orderModel = orderModel
            cell.payOption = {
                
            }
            cell.cancelOption = { [weak self] in
                self?.cancelOrder(indexPath: indexPath)
            }
            cell.deleteOption = { [weak self] in
                self?.deleteOrder(indexPath: indexPath)
            }
            return cell
        }
    }
    
    func cancelOrder(indexPath: IndexPath) -> Void {
        let orderModel = viewModel.dataArr[indexPath.section]
        var boiId = ""
        if let model = orderModel as? HFGemOrderModel {
            boiId = model.boiId
        }
        if let model = orderModel as? HFBusOrderModel {
            boiId = model.boiId
        }
        ShowHUD.showHUDLoading()
        viewModel.cancelOrder(boiId: boiId) { [weak self] in
            ShowHUD.hiddenHUDLoading()
            if let model = orderModel as? HFGemOrderModel {
                model.boiStatus = -1
            }
            if let model = orderModel as? HFBusOrderModel {
                model.boiStatus = -1
            }
            self?.tableView.reloadRows(at: [indexPath], with: .none)
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func deleteOrder(indexPath: IndexPath) -> Void {
        let orderModel = viewModel.dataArr[indexPath.section]
        var boiId = ""
        if let model = orderModel as? HFGemOrderModel {
            boiId = model.boiId
        }
        if let model = orderModel as? HFBusOrderModel {
            boiId = model.boiId
        }
        ShowHUD.showHUDLoading()
        viewModel.deleteOrder(boiId: boiId) { [weak self] in
            ShowHUD.hiddenHUDLoading()
            self?.viewModel.dataArr.remove(at: indexPath.section)
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            self?.tableView.deleteSections(indexSet, with: .bottom)
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
}

extension HFOrderListViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = viewModel.dataArr[indexPath.section]
        if indexPath.row != model.itemModels.count {
            if indexPath.row < model.itemModels.count - 1 {
                return 30
            }
            return 45
        }else{
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 12))
        headerView.backgroundColor = .colorBg()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
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
        let bounds = HFcell.bounds.insetBy(dx: 15, dy: 0)
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
        roundView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HFOrderListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
