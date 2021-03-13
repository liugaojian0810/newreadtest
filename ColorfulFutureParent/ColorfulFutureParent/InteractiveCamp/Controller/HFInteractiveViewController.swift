//
//  HFInteractiveViewController.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/14.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFInteractiveViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, YSSDKDelegate {
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nullImage: UIImageView!
    var serverDateString:String? = nil
    var ysSDKManager: YSSDKManager! = nil
    var reserveModel:HFAMyReservedCourseListModel? = nil
    var dotModel: HUFMyNoReservedCourseListModel? = nil
    var width:CGFloat = 0;//指定老师宽度
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.width = UIScreen.main.bounds.width / 667 * 320
        self.tableView.register(UINib (nibName: "HFInteractiveTableViewCell", bundle: nil), forCellReuseIdentifier: "interactiveCell")
        self.tableView.register(UINib (nibName: "HFInteractivedTableViewCell", bundle: nil), forCellReuseIdentifier: "interactivedCell")
        UIDevice.setHScreen()
        self.ysSDKManager = YSSDKManager.sharedInstance()
        self.ysSDKManager.registerDelegate(self)
        self.updateRightButtonS(isTop: true)
        self.updateTableViewData(at: 0)

        //计算时间
        let date: NSDate = HFCountDown.getServerTime() as NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.serverDateString = dateFormatter.string(from: date as Date)
    }
    //空页面判断
    func reloadNullView(at num: NSInteger) -> Void {
        self.nullImage.isHidden = false
        if (num == 0) {
            self.nullImage.image = UIImage.init(named: "interactiveCamp_nullData_icon")
        } else {
            self.nullImage.image = UIImage.init(named: "interactiveCamp_null_icon")
        }
    }
    //更新右边button
    func updateRightButtonS(isTop:Bool) -> Void {
        self.nullImage.isHidden = true
        if isTop {
            self.bottomBtn.isSelected = false
            self.topBtn.isSelected = true
        } else {
            self.bottomBtn.isSelected = true
            self.topBtn.isSelected = false
        }
    }
    //网络请求
    func updateTableViewData(at status: NSInteger) {
        if status == 0 {
            Service.post(withUrl: GetMyReservedCourseAPI, params: ["id":HFUserManager.shared().getUserInfo().babyInfo.babyID
            ], success: { (responseObject: Any?) in
                self.reserveModel = nil
                let dic = NSDictionary(dictionary: responseObject! as! [NSObject: AnyObject])
                self.reserveModel = try? HFAMyReservedCourseListModel.fromJSON(dic.jk_JSONString(), encoding: 4)
                self.tableView.reloadData()
                guard let count = self.reserveModel?.model.count, count > 0 else {
                    self.reloadNullView(at: 1)
                    return
                }
            }) { (error: HFError?) in
                self.reloadNullView(at: 0)
                 MBProgressHUD.showMessage( error?.errorMessage)
            }
        } else {
            Service.post(withUrl: SubscribeListAPI, params: ["id":HFUserManager.shared().getUserInfo().babyInfo.babyID
            ], success: { (responseObject: Any?) in
                let dic = NSDictionary(dictionary: responseObject! as! [NSObject: AnyObject])
                self.dotModel = try? HUFMyNoReservedCourseListModel.fromJSON(dic.jk_JSONString(), encoding: 4)
                self.tableView.reloadData()
                guard let count = self.dotModel?.model.count, count > 0 else {
                    self.reloadNullView(at: 1)
                    return
                }
            }) { (error: HFError?) in
                self.reloadNullView(at: 0)
                 MBProgressHUD.showMessage( error?.errorMessage)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.topBtn.isSelected {
            return self.reserveModel?.model.count ?? 0
        } else {
            return self.dotModel?.model.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.bottomBtn.isSelected {
            let model:HUFList  = self.dotModel!.model[indexPath.section].lists[indexPath.row]
            return CGFloat(46 + 70 * model.teachers.count) + 37
            
        } else {
            return 150;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.topBtn.isSelected {
            let model: HFAModel = self.reserveModel!.model[section]
            return model.lists.count
        } else {
            let model: HUFModel = self.dotModel!.model[section]
            return model.lists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.topBtn.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: "interactiveCell", for: indexPath) as! HFInteractiveTableViewCell
            cell.rowModel = self.reserveModel!.model[indexPath.section].lists[indexPath.row]
            let time = HFCountDown.getDateDifferenceHHmm(withNowDateStr: cell.rowModel!.startTime, deadlineStr: self.serverDateString!)
            if time > -600 {
                cell.button.setTitle("去互动", for: .normal)
                cell.button.setBackgroundImage(UIImage.init(named: "button-quxiaoyuyue-1"), for: .normal)
            } else {
                cell.button.setTitle("取消预约", for: .normal)
                cell.button.setBackgroundImage(UIImage.init(named: "button-quxiaoyuyue"), for: .normal)
            }
            cell.interactiveBlock = {(parm) ->() in
                if time > -600 {
                    UIDevice.setVScreen()
                    self.ysSDKManager.joinRoom(withRoomId: cell.rowModel!.roomNo, nickName: HFUserManager.shared().getUserInfo().babyInfo.babyName, roomPassword: nil, userId: nil, userParams: nil)
                } else {
                    let alert = HFCustomAlertController()
                    alert.alertType = .typeDefault
                    alert.titleStr = "取消预约"
                    alert.descriStr = "您是否确定取消预约？"
                    alert.actureClosure = { ()->() in
                        Service.post(withUrl: CancelSubscribeAPI, params: ["id":cell.rowModel!.hfAppointmentChildenId], success: { (responseObject: Any?) in
                            self.updateTableViewData(at: 0)
                             MBProgressHUD.showMessage( "取消预约成功")
                        }) { (error: HFError?) in
                             MBProgressHUD.showMessage( error?.errorMessage)
                        }
                    }
                    self.present(alert, animated: false, completion: nil)
                }
            }
            if indexPath.row == 0 {
                cell.time.isHidden = false
                cell.timeBackIamge.isHidden = false
                cell.lineViewTop.constant = 67
                cell.lineView.isHidden = false
            } else if indexPath.row == self.reserveModel!.model[indexPath.section].lists.count - 1 {
                cell.lineView.isHidden = true
            } else {
                cell.lineViewTop.constant = 0
                cell.lineViewbottom.constant = 0
                cell.time.isHidden = true
                cell.timeBackIamge.isHidden = true
                cell.lineView.isHidden = false
            }
            cell.reloadLineView()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "interactivedCell", for: indexPath) as! HFInteractivedTableViewCell
            cell.interactivedRowModel = self.dotModel!.model[indexPath.section].lists[indexPath.row]
            if indexPath.row == 0 {
                cell.lineViewTop.constant = 67
                cell.time.isHidden = false
                cell.timeBackIamge.isHidden = false
                cell.lineView.isHidden = false
            } else if indexPath.row == self.dotModel!.model[indexPath.section].lists.count - 1 {
                cell.lineView.isHidden = true
            } else {
                cell.lineViewTop.constant = 0
                cell.lineViewbottom.constant = 0
                cell.time.isHidden = true
                cell.timeBackIamge.isHidden = true
                cell.lineView.isHidden = false
            }
            cell.interactivedBlock = {(tag) ->() in
                Service.post(withUrl: SubscribeAPI, params: ["childId": HFUserManager.getUserInfo().babyInfo.babyID, "appointmentIntervalId":tag], success: { (dic: Any?) in
                    MBProgressHUD.showMessage("您已成功预约，请准时参加互动")
                        self.updateTableViewData(at: 0)
                        self.updateTableViewData(at: 1)
                }) { (error: HFError?) in
                     MBProgressHUD.showMessage( error?.errorMessage)
                }
            }
            cell.reloadLineView(width: self.width)
            return cell
        }
    }
    
    func onRoomLeft() {
        UIDevice.setHScreen()
    }
    
    func onRoomConnectionLost() {
        UIDevice.setHScreen()
    }
    
    func onRoomKickedOut(_ reason: [AnyHashable : Any]!) {
        UIDevice.setHScreen()
    }
    
    func onRoomReportFail(_ errorCode: YSSDKErrorCode, descript: String!) {
        UIDevice.setHScreen()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func butAction(_ sender: UIButton) {
        self.updateRightButtonS(isTop: sender.tag == 0)
        self.updateTableViewData(at: sender.tag)
    }
}
