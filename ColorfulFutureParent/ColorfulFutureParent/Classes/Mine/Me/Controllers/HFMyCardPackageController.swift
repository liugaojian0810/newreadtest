//
//  HFMyCardPackageController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/2/21.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFMyCardPackageController: HFNewBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myViewModel = HFCardPackgeViewModel()
    
    // 页面底部视图
    lazy var footer: HFCardPackageNoContentView = {
        let footer = Bundle.main.loadNibNamed("HFCardPackageNoContentView", owner: nil, options: nil)?.last as! HFCardPackageNoContentView
        footer.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: 278)
        return footer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        addRefrash()

    }

    func config() {
        self.title = "我的卡包"
        self.tableView.register(byIdentifiers: ["HFMyCardPackageCell"])
        self.tableView.customNoDataView = UIView()
    }
    
    func addRefrash() -> Void {
        
        self.tableView.headerRefreshingBlock { (page) in
            self.getsCardPackagesList(page)
        }
        self.tableView.footerRefreshingBlock { (page) in
            self.getsCardPackagesList(page)
        }
        self.tableView.mj_header?.beginRefreshing()
    }
    
    ///获取卡包列表
    func getsCardPackagesList(_ page: Int) {
        myViewModel.getCards(page) {
            Asyncs.async({
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing()
                self.tableView.reloadData()
            }
        } _: {
            Asyncs.async({
            }) {
                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
}

extension HFMyCardPackageController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.myViewModel.cards.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFMyCardPackageCell") as! HFMyCardPackageCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let disCell = cell as! HFMyCardPackageCell
        disCell.addCard(with: self.myViewModel.cards[indexPath.row])
        disCell.clikClosure = { titleStr in
            print("点击赠送按钮")
            self.useCard()
        }
    }
    
    func useCard() {
        ShowHUD.showHUDLoading()
        myViewModel.useCard {
            ShowHUD.hiddenHUDLoading()
            self.tableView.mj_header?.beginRefreshing()
        } _: {
            ShowHUD.hiddenHUDLoading()
        }
    }
    
}

extension HFMyCardPackageController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 159 + 12
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let edit = HFSemesterEditController()
        //        self.navigationController?.pushViewController(edit, animated: true)
    }
    
}
