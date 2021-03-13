//
//  HFTodayTaskListViewController.swift
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/18.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFTodayTaskListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,YSSDKDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nullImageView: UIImageView!
    var dataModel: HFTodayTaskListModel? = nil
    var serverDateString: String = ""
    var ysSDKManager: YSSDKManager? = nil
    var timer: Timer? = nil
    var status:Int = 0
    var dataArr = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib.init(nibName: "HFTodayTaskListTableViewCell", bundle: nil), forCellReuseIdentifier: "todayCell")
        self.ysSDKManager = YSSDKManager.sharedInstance()
        self.ysSDKManager?.registerDelegate(self)
        self.reloadTableViewWith()
    }
    
    //网络请求
    func reloadTableViewWith() -> Void {
        let babyID = HFUserManager.getUserInfo().babyInfo.babyID
        let group = DispatchGroup()
        group.enter()
         Service.post(withUrl: alreadyCourceAPI, params: ["babyId":babyID, "campTypeId": "0"], success: { (any: Any?) in
            group.leave()
             let dic = NSDictionary(dictionary:any! as! [NSObject : AnyObject])
             self.dataModel = try? HFTodayTaskListModel.fromJSON(dic.mj_JSONString(), encoding: 4)
            guard let count = self.dataModel?.model.count, count > 0 else {
                return
            }
            for rowModel in self.dataModel!.model {
                rowModel.name = "成长营"
            }
             self.dataArr.append(contentsOf: self.dataModel!.model)

         }) { (error: HFError?) in
            group.leave()
              MBProgressHUD.showMessage( error?.errorMessage)
         }
        group.enter()
        Service.post(withUrl: currentCourceDtoAPI, params: ["babyId":babyID, "campTypeId": "0"], success: { (any: Any?) in
            group.leave()
            let dic = NSDictionary(dictionary:any! as! [NSObject : AnyObject])
            self.dataModel = try? HFTodayTaskListModel.fromJSON(dic.mj_JSONString(), encoding: 4)
            guard let count = self.dataModel?.model.count, count > 0 else {
                return
            }
            for rowModel in self.dataModel!.model {
                rowModel.name = "互动营"
            }
            self.dataArr.append(contentsOf: self.dataModel!.model)
        }) { (error: HFError?) in
            group.leave()
             MBProgressHUD.showMessage( error?.errorMessage)
        }
        
        group.notify(queue: DispatchQueue.main) {
            guard self.dataArr.count > 0 else {
                self.reloadNullView(1)
                return
            }
            self.sortTime()
            self.tableView.reloadData()
            self.reloadTimer()
        }
    }
    //按时间排序
    func sortTime() -> Void {//暂时用冒泡，以后看能不能用sorted
        if self.dataArr.count > 1 {
            for i in 0..<self.dataArr.count {
                let rowModelI = self.dataArr[i]
                for j in 0..<self.dataArr.count - 1 - i {
                    let rowModelJ = self.dataArr[j]
                    if HFCountDown.getDateDifferenceHHmm(withNowDateStr: rowModelI.startDate, deadlineStr: rowModelJ.startDate)  > 0 {
                        let temp = self.dataArr[j+1]
                         self.dataArr[j+1] = self.dataArr[j]
                         self.dataArr[j] = temp
                    }
                }
            }
        }
    }
    //倒计时
    func reloadTimer() -> Void {
        //计算时间
        let date: NSDate = HFCountDown.getServerTime() as NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.serverDateString = dateFormatter.string(from: date as Date)
        self.timer = Timer.repeat(withInterval: 1, block: { (timer: Timer) in
            self.calTime()
        })
    }
    //时间倒计时
    func calTime() -> () {
        for cell in self.tableView.visibleCells {
            let rowCell =
            cell as! HFTodayTaskListTableViewCell
            let rowData: HFTodayTaskListModelElement = self.dataArr[cell.tag] as! HFTodayTaskListModelElement
            let timeString = NSString.getTimeStr(self.serverDateString + " " + rowData.startDate + ":00")
            let endTimeString = NSString.getTimeStr(self.serverDateString + " " + rowData.endDate + ":00")

//            if rowData.name == "成长营" {
            if timeString.localizedStandardContains("-") {
                if endTimeString.localizedStandardContains("-") {
                    rowCell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
                    rowCell.todayTaskButton.setTitle("已结束", for: .normal)
                    rowCell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-daojishi"), for: .normal)
                    rowCell.todayTaskButton.isUserInteractionEnabled = false
                } else {
                    rowCell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
                    rowCell.todayTaskButton.setTitle("去冲关", for: .normal)
                    rowCell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-quxiaoyuyue-1"), for: .normal)
                    rowCell.todayTaskButton.isUserInteractionEnabled = true

                }
            } else {
                rowCell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
                rowCell.todayTaskButton.setTitle(timeString, for: .normal)
                rowCell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-daojishi"), for: .normal)
                rowCell.todayTaskButton.isUserInteractionEnabled = false
            }
//            }
        }
    }
    
    func reloadNullView(_ status: NSInteger) -> Void {
        self.nullImageView.isHidden = false
        self.nullImageView.image = status > 0 ? UIImage.init(named: "todayTask_null_icon") : UIImage.init(named: "interactiveCamp_nullData_icon")
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todayCell") as! HFTodayTaskListTableViewCell
        cell.tag = indexPath.section
        let rowModel: HFTodayTaskListModelElement = self.dataArr[indexPath.section] as! HFTodayTaskListModelElement
        cell.rowModel = rowModel
//        if rowModel.name == "成长营" {
        let timeString = NSString.getTimeStr(self.serverDateString + rowModel.startDate + ":00")
        let endTimeString = NSString.getTimeStr(self.serverDateString + rowModel.endDate + ":00")

        if timeString.localizedStandardContains("-") {
            if endTimeString.localizedStandardContains("-") {
                cell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
                cell.todayTaskButton.setTitle("已结束", for: .normal)
                cell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-daojishi"), for: .normal)
            } else {
                cell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
                cell.todayTaskButton.setTitle("去冲关", for: .normal)
                cell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-quxiaoyuyue-1"), for: .normal)
            }
        } else {
            cell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
            cell.todayTaskButton.setTitle(timeString, for: .normal)
            cell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-daojishi"), for: .normal)
        }
            
//        } else {
//            if HFCountDown.getDateDifferenceHHmm(withNowDateStr: rowModel.startDate, deadlineStr: self.serverDateString) > -600 {
//                                cell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
//                cell.todayTaskButton.setTitle("去冲关", for: .normal)
//                cell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-quxiaoyuyue-1"), for: .normal)
//            } else {
//                cell.todayTaskButton.setTitleColor(UIColor.white, for: .normal)
//                cell.todayTaskButton.setTitle("未开始", for: .normal)
//                cell.todayTaskButton.setBackgroundImage(UIImage.init(named: "button-weikaishi"), for: .normal)
//            }
//        }
        cell.block = {(tag) ->() in
            if rowModel.name == "成长营" {
                ShowHUD.showHUDLoading()
                Service.post(withUrl: PlayVideoAPI, params: ["videoId": rowModel.courseUrl, "babyId": HFUserManager.getUserInfo().babyInfo.babyID], success: { (any: Any?) in
                    let dic = NSDictionary(dictionary: any as! [NSObject: AnyObject])
                    ShowHUD.hiddenHUDLoading()
//                    Service.post(withUrl: GetGoIntoRoomStuSaveAPI, params: ["babyId": HFUserManager.getUserInfo().babyInfo.babyID, "courseId": rowModel.courseID], success: { (any: Any?) in
//                    }) { (error: HFError?) in
//                    }
                    let video = HFVideoController.init()
                    let dataModel = try? HFClassVideoURLModel.fromJSON(dic["model"] as! String, encoding: 4)
                    video.url = dataModel!.data.videoURL.last!.originURL 
                    video.hiddenBottomBar = true
                    video.courseId = String(rowModel.courseID)
                    video.titleText = rowModel.courceName
                    video.classStartTime = rowModel.startDate
                    video.weekDetailId = String(rowModel.weekDetailId)
                    self.present(video, animated: false, completion: nil)
                    }) { (error: HFError?) in
                        ShowHUD.hiddenHUDLoading()
                         MBProgressHUD.showMessage( error?.errorMessage)
                }
            } else {
                UIDevice.setVScreen()
                self.ysSDKManager?.joinRoom(withRoomId: rowModel.roomNo, nickName: HFUserManager.getUserInfo().babyInfo.babyName, roomPassword: nil, userRole: YSSDKUserRoleType.YSSDKSUserType_Student, userId: nil, userParams: nil)
            }
        }
        
        return cell
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
   
    deinit {
        self.timer?.invalidate()
    }
    
}
