//
//  HFClassOrdersListViewController.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFClassOrdersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nullImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var dataModel: HFOrderListModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "HFClassOrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "HFClassOrderListTableViewCell")
        Service.post(withUrl: OrderListAPI, params: ["orderStatus": "2", "clientType": "0", "goodsFlag": "2", "pageNum":"1", "pageSize": "10", "userId":HFUserManager.getUserInfo().userId, "childId": HFUserManager.getUserInfo().babyInfo.babyID, "ownerId":HFUserManager.getUserInfo().babyInfo.babyID], success: { (any: Any?) in
            let dic = NSDictionary.init(dictionary: any as! [NSObject: AnyObject])
            self.dataModel = HFOrderListModel.mj_object(withKeyValues: dic["model"])
            if self.dataModel?.list.count == 0 {
                self.reloadNullView(status: 0)
            }
            self.tableView.reloadData()
        }) { (error: HFError?) in
             MBProgressHUD.showMessage( error?.errorMessage)
            self.reloadNullView(status: 1);
        }
    }
    
    func reloadNullView(status: NSInteger) -> Void {
        self.nullImage.isHidden = false
        if status == 0 {
            self.nullImage.image = UIImage.init(named: "order_list_NullImage")
        } else {
            self.nullImage.image = UIImage.init(named: "order_list_Null_data")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFClassOrderListTableViewCell", for: indexPath) as! HFClassOrderListTableViewCell
        cell.rowModel = self.dataModel?.list[indexPath.section]
        return cell
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
