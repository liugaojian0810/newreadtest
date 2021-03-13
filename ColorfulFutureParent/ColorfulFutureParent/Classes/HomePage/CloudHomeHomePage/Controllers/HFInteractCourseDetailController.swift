//
//  HFInteractCourseDetailController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/16.
//  Copyright © 2020 huifan. All rights reserved.
//  互动营课程详情

import UIKit


class HFInteractCourseDetailController: HFNewBaseViewController {
    
    let viewModel = HFCloudHomeActivityViewModel()
    
    /// 预约成功回调
    var subscribeSuccessComplete: OptionClosure?
    
    var selectTaskviewModel = HFInteractTaskViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var headerView: HFInteractHeaderView = {
        let headerView = Bundle.main.loadNibNamed("HFInteractHeaderView", owner: self, options: nil)?.last as! HFInteractHeaderView
        return headerView
    }()
    
    lazy var footerView: HFInteractFooterView = {
        let footerView = Bundle.main.loadNibNamed("HFInteractFooterView", owner: self, options: nil)?.last as! HFInteractFooterView
        return footerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestDetail()
    }
    
    func config() -> Void {
        
        self.title = "互动详情"
        self.view.backgroundColor = .colorBg()
        self.tableView.backgroundColor = .colorBg()
        self.tableView.register(byIdentifiers: ["HFSmallTasksDetailMsgCell","HFSmallTaskShowCell"])
        self.tableView.reloadData()
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 15))
        
        self.tableView.tableFooterView = footerView
    }
    
    func requestDetail() -> Void {
        ShowHUD.showHUDLoading()
        viewModel.loadInteractiveDetail { [weak self] in
            ShowHUD.hiddenHUDLoading()
            self?.updateStatus()
            self?.tableView.reloadData()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    func updateStatus() -> Void {
        if self.viewModel.detailType == .myInteractive && self.viewModel.interactiveDetailModel != nil && self.viewModel.interactiveDetailModel!.actionStatus != 0 {
            var text = self.viewModel.interactiveDetailModel!.actionStatusContent
            if text.isEmptyStr() {
                text = "互动活动异常"
            }
            // 异常状态显示
        }
        let text = "预约失败：活动未正常开展，活动已取消预约失败：活动未正常开展，活动已取消"
        self.headerView.contentLab.text = text
        var height = 0
        height += 31
        height += Int(text.get_heightForComment(fontSize: 13, width: ScreenWidth - 78))
        height += 31
        self.headerView.frame = CGRect.init(x: 0, y: 0, width: Int(ScreenWidth), height: height)
        self.tableView.tableHeaderView = headerView
    }
    
    func selectTask() -> Void {
        let vc = HFSelectTaskViewController()
        vc.viewModel = selectTaskviewModel
        selectTaskviewModel.disableInteractTasks = viewModel.interactiveDetailModel?.taskList ?? []
//        selectTaskviewModel.csId = viewModel.interactiveDetailModel?.gsId ?? ""
//        selectTaskviewModel.grId = viewModel.interactiveDetailModel?.gradeId ?? ""
        // TODO:调试
        selectTaskviewModel.csId = "CS202102191081813677"
        selectTaskviewModel.grId = "GR202011260330789503"
        selectTaskviewModel.selectComplete = { [weak self] (interactTasks) in
            self?.viewModel.taskModels = interactTasks
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///预约
    @IBAction func makeAppointment(_ sender: UIButton) {
        let subscribeHintView = Bundle.main.loadNibNamed("HFSubscribeHintView", owner: nil, options: nil)?.last as! HFSubscribeHintView
        subscribeHintView.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: S_SCREEN_HEIGHT)
        subscribeHintView.clickSure = {
            self.subscribeInteractive()
        }
        UIApplication.shared.keyWindow!.addSubview(subscribeHintView)
        UIApplication.shared.keyWindow!.bringSubviewToFront(subscribeHintView)
    }
    
    func subscribeInteractive() -> Void {
        viewModel.kiiId = viewModel.interactiveDetailModel?.kiiId ?? ""
        viewModel.subscribeInteractive {
            
        } _: {
            
        }
//        let subscribeHintView = Bundle.main.loadNibNamed("HFTopUpSuccessView", owner: nil, options: nil)?.last as! HFTopUpSuccessView
//        subscribeHintView.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: S_SCREEN_HEIGHT)
//        subscribeHintView.topupNumber = NSDecimalNumber(string: "10.1")
//        UIApplication.shared.keyWindow!.addSubview(subscribeHintView)
//        UIApplication.shared.keyWindow!.bringSubviewToFront(subscribeHintView)
    }
}

extension HFInteractCourseDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            let arr = viewModel.interactCourseDetailItems[section - 1]
            return arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFSmallTaskShowCell", for: indexPath) as! HFSmallTaskShowCell
            cell.detailType = viewModel.detailType
            let disableTasks: [HFInteractTaskModel] = self.viewModel.interactiveDetailModel?.taskList.map({ (model) -> HFInteractTaskModel in
                model.isDisable = true
                return model
            }) ?? []
            cell.dataArr = disableTasks + selectTaskviewModel.selectedInteractTasks
            cell.addTask = selectTask
            cell.editTask = selectTask
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFSmallTasksDetailMsgCell") as! HFSmallTasksDetailMsgCell
            let itemArr = viewModel.interactCourseDetailItems[indexPath.section - 1]
            let item = itemArr[indexPath.row]
            cell.tipLabel.text = item.contetText
            if item.contetAttributed != nil {
                cell.tipLabel.attributedText = item.contetAttributed
            }
            if indexPath.section != 2 {
                cell.desLabel.isHidden = false
                cell.topupBtn.isHidden = true
                cell.desLabel.text = "详情"
            }else{
                cell.desLabel.isHidden = true
                cell.topupBtn.isHidden = false
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
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
        if indexPath.section == 1 && indexPath.row == 0 {
            //               // 初始起点为cell的左下角坐标
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            //  起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        } else if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
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


extension HFInteractCourseDetailController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        viewModel.interactCourseDetailItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            var height: CGFloat = 43.0
            var taskArr = viewModel.interactiveDetailModel?.taskList ?? []
            taskArr += selectTaskviewModel.selectedInteractTasks
            for model in taskArr {
                height += CGFloat(model.gatIntro.get_heightForComment(fontSize: 13, width: S_SCREEN_WIDTH - 102.5))
            }
            if viewModel.detailType == .subscribe {
                if viewModel.interactiveDetailModel?.taskList.count ?? 0 < 3 && selectTaskviewModel.selectedInteractTasks.count == 0 {
                    height += 64
                }
            }
            height += 18
            return height
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section != tableView.numberOfSections - 1 && section != 0 {
            return 14
        }
        if section == 0 {
            return 15
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section != tableView.numberOfSections - 1 && section != 0 {
            let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 14))
            let whiteView = UIView.init(frame: CGRect.init(x: 15, y: 0, width: S_SCREEN_WIDTH - 30, height: 14))
            footerView.addSubview(whiteView)
            whiteView.backgroundColor = .white
            let lineY = (whiteView.frame.maxY - 1) / 2
            whiteView.drawDashLine(startPoint: CGPoint.init(x: 15, y: lineY), endPoint: CGPoint.init(x: whiteView.frame.width - 15, y: lineY), strokeColor: .hexColor(0x979797), lineWidth: 1, lineLength: 2, lineSpacing: 2)
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

