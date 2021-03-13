//
//  HFOnedayFlowArrangementController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/22.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFOnedayFlowArrangementController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    var myViewModel = HFOnedayFlowViewModel()
    
    var numRows: Int = 0
    
    /// 切换周
    var dateSwitchView: HFScheduleDateSwitch = {
        let swi = Bundle.main.loadNibNamed("HFScheduleDateSwitch", owner: nil, options: nil)?.last as! HFScheduleDateSwitch
        swi.frame = CGRect(x: 0, y: kNavigatioHeight, width: S_SCREEN_WIDTH, height: 48)
        return swi
    }()
    
    /// 活动名称
    lazy var onedayFlowArrangementHead: HFOnedayFlowArrangementHead = {
        let onedayFlowArrangementHead = Bundle.main.loadNibNamed("HFOnedayFlowArrangementHead", owner: nil, options: nil)?.last as! HFOnedayFlowArrangementHead
        onedayFlowArrangementHead.frame = CGRect(x: 0, y: kNavigatioHeight+48, width: S_SCREEN_WIDTH, height: 60)
        onedayFlowArrangementHead.drawDottedLine()
        return onedayFlowArrangementHead
    }()
    
    ///编辑按钮
    var rightBar: UIBarButtonItem?
    
    ///是不是编辑状态
    var edit = false
    
    ///添加按钮
    lazy var addBtn: UIButton = {
        
        let addBtn = UIButton(frame: CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 40))
        //        addBtn.setTitle("添加", for: .normal)
        addBtn.setTitleColor(.colorWithHexString("FF844B"), for: .normal)
        addBtn.setImage(UIImage(named: "yiriliuchenganpaiqingkong_icon_tianjia"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnClick(_:)), for: .touchUpInside)
        addBtn.jk_setImagePosition(.LXMImagePositionRight, spacing: 1)
        return addBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        weekChooseOpe()
        addRefrash()
    }
    
    
    func config() -> Void {
        
        self.title = "一日流程安排"
        self.view.addSubview(self.dateSwitchView)
        self.view.addSubview(self.onedayFlowArrangementHead)
        rightBar = UIBarButtonItem(title: "编辑", style: .done, target: self, action: #selector(rightBarButtonItemClick(_:)))
        self.navigationItem.rightBarButtonItem = rightBar
        self.updateLayout()
        self.tableView.register(byIdentifiers: ["HFOnedayFlowArrangementCell"])
        //        self.tableView.reloadData()
    }
    
    
    func weekChooseOpe() -> Void {
        
        dateSwitchView.names = ["大班", "中班", "小班"]
        if (dateSwitchView.names.count > 0) {
            
        }
        dateSwitchView.selectBlock = { num in
            
            print("您选择的是： \(num)")
        }
    }
    
    // MARK: 刷新与请求
    
    func addRefrash() -> Void {
        self.getLists()
    }
    
    func getLists() -> Void {
        ShowHUD.showHUDLoading()
        myViewModel.onedayFlowList({
            ShowHUD.hiddenHUDLoading()
            Asyncs.async({
                print("")
            }) {
//                self.tableView.endRefrash()
                self.numRows = self.myViewModel.dppafLists.count
                self.tableView.reloadData()
            }
        }) {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    // MARK: 按钮点击
    
    /// 编辑按钮点击
    @objc func rightBarButtonItemClick(_ sender: UIBarButtonItem ) {
        
        if sender.title == "编辑" {
            sender.title = "清空"
            edit = true
            updateLayout()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else if sender.title == "清空" {
            self.showCustomAlert("提示", "点击即清空，请确认清空当前一日活动安排吗？", "取消", "清空", {
                
            }) {
                sender.title = "重置"
                self.edit = false
                self.updateLayout()
                self.numRows = 0
                self.myViewModel.dppafLists.removeAll()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }else {
            self.showCustomAlert("提示", "点击即重置，请确认清空当前一日活动安排吗？", "取消", "重置", {
                
            }) {
                
                self.myViewModel.restoreOnedayFlow({
                    sender.title = "清空"
                    self.addRefrash()
                }) {
                 
                }
                
            }
        }
    }
    
    
    @IBAction func saveClick(_ sender: UIButton) {
        
        self.myViewModel.updateOnedayFlow({
            
            self.rightBar?.title = "编辑"
            self.edit = false
            self.updateLayout()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) {
            //这段代码需要删除
            self.rightBar?.title = "编辑"
            self.edit = false
            self.updateLayout()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateLayout() -> Void {
        
        if edit {
            self.bottomViewHeight.constant = 60
            self.bottomView.isHidden = false
            self.tableView.tableFooterView = self.addBtn
        }else{
            self.bottomViewHeight.constant = 0
            self.bottomView.isHidden = true
            self.tableView.tableFooterView = UIView()
        }
    }
    
    @objc func addBtnClick(_ btn: UIButton) -> Void {
        ///需要删除操作
        self.numRows += 1
        let addModel = myViewModel.generateModel()
        self.myViewModel.dppafLists.append(addModel)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension HFOnedayFlowArrangementController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFOnedayFlowArrangementCell", for: indexPath) as! HFOnedayFlowArrangementCell
        //删除操作
        cell.deleteClosure = {
            self.numRows -= 1
            self.myViewModel.dppafLists.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        cell.dppaf = self.myViewModel.dppafLists[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let disCell = cell as! HFOnedayFlowArrangementCell
//        if self.edit == true {
//            disCell.edit = true
//        }else{
//            disCell.edit = false
//        }
        disCell.edit = self.edit
        disCell.drawDottedLine()
    }
}

extension HFOnedayFlowArrangementController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if edit {
            let vc =  HFOnedayFlowActivitySetupController()
            vc.model =  self.myViewModel.dppafLists[indexPath.row]
            vc.confirmClosure = { activity in
                print(activity as Any)
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // 进详情
            let activeDdetail = HFPopDetailViewController()
            activeDdetail.model = self.myViewModel.dppafLists[indexPath.row]
            self.present(activeDdetail, animated: true, completion: nil)
        }
    }
}
