//
//  HFTeacherArchivesController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/12.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFTeacherArchivesController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var personInfo: HFPersonInfoHeaderView = {
       
        let personInfo = Bundle.main.loadNibNamed("HFPersonInfoHeaderView", owner: nil, options: nil)?.last as! HFPersonInfoHeaderView
        personInfo.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 176)
        return personInfo
    }()
    
    lazy var footerView = HFExactlyView.create()
    
    ///分组提示
    lazy var tips = ["幼儿园", "班级", "岗位", "性别", "联系方式", "教师名片"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    private func config() {
        self.title = "教师信息"
        self.tableView.tableHeaderView = personInfo
        self.tableView.tableFooterView = footerView
        self.tableView.register(byIdentifiers: ["HFComEditCell"])
        self.tableView.reloadData()
    }
    
}

extension HFTeacherArchivesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
        cell.lineView.isHidden = false
        cell.contentView.backgroundColor = .white
        cell.tipLabel.text = tips[indexPath.row]
        cell.textField.text = tips[indexPath.row]
        cell.arrowIntoImg.isHidden = true
        cell.arrowRightConstrint.constant = 0
        return cell
    }
}


extension HFTeacherArchivesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

