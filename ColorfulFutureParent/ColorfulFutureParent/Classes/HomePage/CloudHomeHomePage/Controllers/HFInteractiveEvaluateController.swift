//
//  HFInteractiveEvaluateController.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/2/28.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFInteractiveEvaluateController: HFNewBaseViewController {
    
    var viewModel = HFCloudHomeActivityViewModel()
    
    var editComplete: OptionClosure?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        if viewModel.interactiveDetailModel == nil {
            requestInteractiveDetail()
        }
        if viewModel.interactiveEvaluateOperationType == .read {
            requestEvaluateDetail()
        }
    }
    
    func requestInteractiveDetail() -> Void {
//        ShowHUD.showHUDLoading()
        viewModel.loadInteractiveDetail { [weak self] in
            ShowHUD.hiddenHUDLoading()
            self?.tableView.reloadData()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    func requestEvaluateDetail() -> Void {
        viewModel.getInteractiveReportDetail { [weak self] in
            self?.tableView.reloadData()
        } _: {
        }
    }
    
    func config() -> Void {
        self.title = "评价"
        self.view.backgroundColor = .colorBg()
        self.tableView.backgroundColor = .colorBg()
        self.tableView.register(byIdentifiers: ["HFInteractiveEvaluateInteractiveInfoCell","HFInteractiveEvaluateCell","HFInteractiveEvaluateItemCell","HFInputTextViewCell"])
        self.tableView.estimatedRowHeight = 34
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 0.001))
        
        submitBtn.jk_setBackgroundColor(.colorMain(), for: .normal)
        submitBtn.jk_setBackgroundColor(.colorMainDisable(), for: .disabled)
        submitBtn.isEnabled = false
    }
    
    func updateStatus() -> Void {
        if viewModel.interactiveEvaluateOperationType == .edit {
            bottomConstraint.constant = submitBtn.height
            submitBtn.isHidden = false
            var enabled = true
            for evaluate in viewModel.evaluateList {
                if evaluate.starNum == 0 {
                    enabled = false
                    break
                }
            }
            submitBtn.isEnabled = enabled
        }else{
            bottomConstraint.constant = 0
            submitBtn.isHidden =  true
        }
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        ShowHUD.showHUDLoading()
        viewModel.commitInteractionReport { [weak self] in
            ShowHUD.hiddenHUDLoading()
            let hud = ShowHUD.showHUD(withInfo: "评价成功")
            hud?.completionBlock = {
                if self?.editComplete != nil {
                    self?.editComplete!()
                }
            }
            self?.navigationController?.popViewController(animated: true)
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
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


extension HFInteractiveEvaluateController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return viewModel.evaluateList.count + 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveEvaluateInteractiveInfoCell") as! HFInteractiveEvaluateInteractiveInfoCell
            cell.model = viewModel.interactiveDetailModel
            return cell
        } else if (indexPath.section == 1) {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveEvaluateCell") as! HFInteractiveEvaluateCell
                cell.canRes = false
                cell.starNum = viewModel.kirpScoreAverage
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInteractiveEvaluateItemCell") as! HFInteractiveEvaluateItemCell
            let evaluateItemModel = viewModel.evaluateList[indexPath.row - 1]
            cell.model = evaluateItemModel
            cell.canRes = viewModel.interactiveEvaluateOperationType == .edit
            cell.bottomConstraint.constant = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 ? 25 : 10
            cell.starChangeBlock = { [weak self] (star) in
                let evaluateItemModel = self?.viewModel.evaluateList[indexPath.row - 1]
                evaluateItemModel?.starNum = star
                self?.updateStatus()
                self?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: indexPath.section)], with: .none)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFInputTextViewCell") as! HFInputTextViewCell
            cell.textView.isUserInteractionEnabled = viewModel.interactiveEvaluateOperationType == .edit
            if viewModel.interactiveEvaluateOperationType == .edit {
                cell.textView.text = viewModel.kirpContent
                cell.textView.placeholder = "用一段话来评价老师的互动表现吧！"
            }else{
                cell.textView.text = viewModel.interactiveDetailModel?.kirpContent ?? "这位家长什么也没填写~"
            }
            cell.inputCallBack = { [weak self] (text) in
                self?.viewModel.kirpContent = text
            }
            return cell
        }
    }
}

extension HFInteractiveEvaluateController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 252
        }
        if indexPath.section == 2 {
            if viewModel.interactiveEvaluateOperationType == .edit {
                return 122
            }else{
                
                return 122
            }
        }
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 15))
        headerView.backgroundColor = .colorBg()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 0.001))
        footerView.backgroundColor = .colorBg()
        return footerView
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
}
