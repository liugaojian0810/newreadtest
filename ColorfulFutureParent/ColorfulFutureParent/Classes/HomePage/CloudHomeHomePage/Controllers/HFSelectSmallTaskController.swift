//
//  HFSelectSmallTaskController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/30.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFSelectSmallTaskController: HFNewBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    func config() -> Void {
        
        self.title = "选择小任务"
        self.tableView.register(byIdentifiers: ["HFSelectSmallTaskCell"])
        self.tableView.reloadData()
    }
    
    ///预约
    @IBAction func makeAppointment(_ sender: UIButton) {
        
        let vc = HFSelectSmallTaskController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HFSelectSmallTaskController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSelectSmallTaskCell") as! HFSelectSmallTaskCell
        return cell
    }
}


extension HFSelectSmallTaskController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        115
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

