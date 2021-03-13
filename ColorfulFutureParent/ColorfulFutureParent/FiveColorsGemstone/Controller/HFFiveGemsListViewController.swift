//
//  HFFiveGemsListViewController.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFFiveGemsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var gemsNumber: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nullImageView: UIImageView!
    @IBOutlet weak var leftBackView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var rightView: UIView!
    var dataModel:HFGetMulticoloredGemstoneInfoModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "HFFiveGemsListTableViewCell", bundle: nil), forCellReuseIdentifier: "HFFiveGemsListTableViewCell")
        Service.post(withUrl: getMulticoloredGemstoneAPI, params: ["userId": HFUserManager.getUserInfo().userId, "babyId": HFUserManager.getUserInfo().babyInfo.babyID], success: { (any: Any?) in
            let dic = NSDictionary(dictionary: any as! [NSObject: AnyObject])
            self.dataModel = HFGetMulticoloredGemstoneInfoModel.mj_object(withKeyValues: dic.value(forKey: "model"))
            self.gemsNumber.text = String(self.dataModel!.total) + "颗"
            guard let count = self.dataModel?.dateGemstoneList.count, count > 0 else {
                self.nullImageView.isHidden = false
                return
            }
            self.tableView.reloadData()
        }) { (error: HFError?) in
             MBProgressHUD.showMessage( error?.errorMessage)
            self.nullImageView.isHidden = false
        }

        // shadowCode
        self.leftBackView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2).cgColor
        self.leftBackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.leftBackView.layer.shadowOpacity = 1
        self.leftBackView.layer.shadowRadius = 7
        self.leftBackView.layer.cornerRadius = 7
        self.leftBackView.shadowColor(with: 2)

        self.rightView.layer.shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.2).cgColor
        self.rightView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.rightView.layer.shadowOpacity = 1
        self.rightView.layer.shadowRadius = 7
        self.rightView.layer.cornerRadius = 7
        self.rightView.shadowColor(with: 2)
        UIView.drawLineOfDash(byCAShapeLayer: self.lineView, lineLength: 3, lineSpacing: 2, lineColor: UIColor.jk_color(withHexString: "#E3D5FF"))

    }
    
    @IBAction func convertAction(_ sender: UIButton) {
         MBProgressHUD.showMessage( "该功能暂未开放，敬请期待！")
    }
    
    @IBAction func ruleAction(_ sender: UIButton) {
         MBProgressHUD.showMessage( "该功能暂未开放，敬请期待！")
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataModel?.dateGemstoneList.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?.dateGemstoneList[section].recordList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFFiveGemsListTableViewCell", for: indexPath) as! HFFiveGemsListTableViewCell
        cell.rowModel = self.dataModel?.dateGemstoneList[indexPath.section].recordList[indexPath.row]
        return cell
    }
}
