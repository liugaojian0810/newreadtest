//
//  HFBabyListViewController.swift
//  ColorfulFutureParent
//
//  Created by 范斗鸿 on 2021/1/12.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit

class HFBabyListViewController: UIViewController {

    @IBOutlet weak var topBgView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HFBabyViewModel.shared
    
    // 点击添加宝宝
    var addBabyClosure: OptionClosure?
    // 点击加入新学校
    var joinClosure: ((_ babyModel: HFBabyModel) -> ())?
    // 选择宝宝
    var selectClosure: ((_ babyModel: HFBabyModel) -> ())?
    
    lazy var addBabyView: HFAddBabyView = {
        let addBabyView = Bundle.main.loadNibNamed("HFAddBabyView", owner: self, options: nil)?.last as! HFAddBabyView
        return addBabyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() -> Void {
        topBgView.addSubview(addBabyView)
        addBabyView.frame = CGRect.init(x: 0, y: topBgView.height - 70, width: self.view.frame.size.width, height: 70)
        addBabyView.isUserInteractionEnabled = true
        addBabyView.setTapActionWith {
            if self.addBabyClosure != nil {
                self.addBabyClosure!()
            }
            self.dismiss(animated: false, completion: {})
        }
        
        tableView.showNoDataNotice = false
        tableView.register(byIdentifiers: ["HFBabyComeTableViewCell","HFBabyTableViewCell"])
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HFBabyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.babys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let babyModel = viewModel.babys[indexPath.row]
        if babyModel.isEntranceKg == 1 {
            // 已入学宝宝
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFBabyComeTableViewCell") as! HFBabyComeTableViewCell
            cell.babyModel = babyModel
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HFBabyTableViewCell") as! HFBabyTableViewCell
            cell.babyModel = babyModel
            cell.joinClosure = {
                if self.joinClosure != nil {
                    self.joinClosure!(babyModel)
                }
                self.dismiss(animated: false, completion: {})
            }
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension HFBabyListViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let babyModel = viewModel.babys[indexPath.row]
        return babyModel.isEntranceKg == 1 ? 140 : 70
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
        let babyModel = viewModel.babys[indexPath.row]
        viewModel.currentBaby = babyModel
        if self.selectClosure != nil {
            self.selectClosure!(babyModel)
        }
        self.dismiss(animated: true, completion: {})
    }
}
