//
//  HFSmallTaskShowCell.swift
//  ColorfulFutureTeacher_iOS
//
//  Created by 范斗鸿 on 2021/2/21.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFSmallTaskShowCell: UITableViewCell {
    
    var detailType: HFInteractiveDetailType = .subscribe
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var editTaskBtn: UIButton!
    var editTask: OptionClosure?
    
    @IBOutlet weak var addTaskBtn: UIButton!
    var addTask: OptionClosure?
    
    @IBOutlet weak var tableView: UITableView!
    
    // 虚线框
    let borderLayer = CAShapeLayer.init()
    
    var dataArr: [HFInteractTaskModel] = [] {
        didSet {
            if detailType == .subscribe {
                // 判断是否全部禁止（如果都为禁用状态，则说明所有的小任务都不是自己选择的）
                var allDisable = true
                for taskModel in dataArr {
                    if !taskModel.isDisable {
                        allDisable = false
                        break
                    }
                }
                if allDisable {
                    if dataArr.count < 3 {
                        // 可添加小任务
                        editTaskBtn.isHidden = true
                        addTaskBtn.isHidden = false
                        bottomConstraint.constant = 64
                    }else{
                        // 仅显示小任务
                        editTaskBtn.isHidden = true
                        addTaskBtn.isHidden = true
                        bottomConstraint.constant = 0
                    }
                }else{
                    // 允许编辑小任务
                    editTaskBtn.isHidden = false
                    addTaskBtn.isHidden = true
                    bottomConstraint.constant = 0
                }
            }else{
                // 仅显示小任务
                editTaskBtn.isHidden = true
                addTaskBtn.isHidden = true
                bottomConstraint.constant = 0
            }
            if dataArr.count == 0 {
                tableView.isHidden = true
            }else{
                tableView.isHidden = false
                tableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .colorBg()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.estimatedRowHeight = 20
        tableView.register(byIdentifiers: ["HFSmallTaskShowItemCell"])
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        contentView.backgroundColor = .white
        
        editTaskBtn.isHidden = true
        addTaskBtn.isHidden = true
        bottomConstraint.constant = 0
        
        
        borderLayer.strokeColor = UIColor.hexColor(0xFFFFFF).cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1.0
        borderLayer.lineDashPattern = [4,2]
        addTaskBtn.layer.cornerRadius = 8
        addTaskBtn.layer.masksToBounds = true
        addTaskBtn.layer.addSublayer(borderLayer)
        addTaskBtn.jk_setImagePosition(.LXMImagePositionLeft, spacing: 7)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let addTaskBounds = addTaskBtn.bounds
        let path = UIBezierPath.init(roundedRect: addTaskBounds, cornerRadius: 8)
        borderLayer.path = path.cgPath
        borderLayer.frame = addTaskBounds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickEditTask(_ sender: UIButton) {
        if editTask != nil {
            editTask!()
        }
    }
    
    @IBAction func clickAddTask(_ sender: UIButton) {
        if addTask != nil {
            addTask!()
        }
    }
    
}

extension HFSmallTaskShowCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSmallTaskShowItemCell") as! HFSmallTaskShowItemCell
        cell.index = indexPath.row
        let model = dataArr[indexPath.row]
        cell.content = model.gatIntro
        return cell
    }
}

extension HFSmallTaskShowCell: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
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
}
