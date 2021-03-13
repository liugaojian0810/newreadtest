//
//  HFSettingsController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSettingsController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var tips = ["修改个人资料", "清理缓存", "关于我们", "宝宝档案", "教师信息"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    private func config() {
        self.title = "个人设置"
        self.tableView.register(byIdentifiers: ["HFComEditCell"])
        self.tableView.reloadData()
    }
    
}

extension HFSettingsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFComEditCell") as! HFComEditCell
        cell.tipLabel.text = tips[indexPath.row]
        return cell
    }
}


extension HFSettingsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let personData = HFPersonalDataController()
            self.navigationController?.pushViewController(personData, animated: true)
        case 1:
            let myClass = HFMyClassController()
            self.navigationController?.pushViewController(myClass, animated: true)
        case 2:
            let personData = HFPersonalDataController()
            self.navigationController?.pushViewController(personData, animated: true)
        case 3:
            let personData = HFBabyArchivesController()
            self.navigationController?.pushViewController(personData, animated: true)
        default:
            let teacherArchiver = HFTeacherArchivesController()
            self.navigationController?.pushViewController(teacherArchiver, animated: true)
        }
    }
}

