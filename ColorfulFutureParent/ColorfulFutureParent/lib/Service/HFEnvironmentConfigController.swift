//
//  HFEnvironmentConfigController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/9/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFEnvironmentConfigController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lable: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerUnXib(byIdentifiers: ["UITableViewCell"])
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceHosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        cell.textLabel?.text = ServiceHosts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let host = ServiceHosts[indexPath.row]
        
        UserDefaults.standard.setValue(host, forKey: HFHotfixServiceHostUrlKry)
        UserDefaults.standard.synchronize()
        
        print("切换完毕，host:\(host)")
        
        self.dismiss(animated: false, completion: {})
        
    }
    
}
