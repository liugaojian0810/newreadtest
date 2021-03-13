//
//  HFPopDetailViewController.swift
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/12/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFPopDetailViewController: UIViewController {
    

    @IBOutlet weak var tableview: UITableView!
    let CURRENTCOLOR = UIColor.colorWithHexString("8BBF0A")
    var model: OnedayFlowDppafListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.backgroundColor = CURRENTCOLOR
        self.tableview.layer.cornerRadius = 10
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissCurrent))
        self.view.addGestureRecognizer(tapGes)
    }

    @objc func dismissCurrent() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HFPopDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UINib(nibName: "HFDetailPageHeader", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HFDetailPageHeader
        headerView.backgroundColor = CURRENTCOLOR
        headerView.heaertitle.text = model.dppName
        headerView.headertime.text = "\(model.dpkStartTime)-\(model.dpkEndTime)"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 86
    }
}

extension HFPopDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.pfList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listArr = model.pfList ?? []
        let listM = listArr[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HFPopDetailViewController")
        cell.backgroundColor = CURRENTCOLOR
        cell.textLabel?.text = listM.pfName
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.semiboldFont(ofSize: 13)
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.text = listM.pfInfo
        cell.detailTextLabel?.font = UIFont.semiboldFont(ofSize: 13)
        return cell
    }
    
}
