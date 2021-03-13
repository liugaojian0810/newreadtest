//
//  HFSetUpController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/7/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import WebKit

enum SetUpSelectProject {
    
    case SetUpBabyInfo //宝宝信息
    case SetUpAcountSetUp //账号设置
    case SetUpSuggest //用户建议
    case SetUpAboutUs //关于我们
    case SetUpAcountSecur //用户安全
    case SetFamilyMembers //家庭成员
    case SetDelegate//协议
}

class HFSetUpController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var bgHomeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var followLine: UIView!
    @IBOutlet weak var followLine1: UIView!
    @IBOutlet weak var followLine2: UIView!
    @IBOutlet weak var followLine3: UIView!
    @IBOutlet weak var babyInfoBtn: UIButton!
    @IBOutlet weak var aboutUsView: UIView!
    @IBOutlet weak var followCenterY: NSLayoutConstraint!
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    var web: WKWebView?
    var selectPro = SetUpSelectProject.SetUpBabyInfo
    var curButton: UIButton?
    var curLine: UIView?
    var adviceFeedback: UIView?
    var url101 = ""
    var url102 = ""
    
    var level: Int? = 0
//    var tipMsg = [["宝宝昵称：","性别：","出生日期：","所属幼儿园：","宝宝班级：","家庭成员："],["手机号码：","微信号：","登录密码：","版本更新：","清理缓存：","账户安全："],["账号注销","退出登录"]]
    var tipMsg = [["宝宝昵称：","性别：","出生日期：","所属幼儿园：","宝宝班级：","家庭成员："],["手机号码：","清理缓存：","账户安全："],["版本更新","用户协议","隐私政策"],["退出登录"]]

    var newVersion: Bool = false
    var version: String = ""
    var upAttach: String = ""
    var cacheMem: String = ""
    
    var myViewModel: HFMyViewModel?
    var dataModel: HFBabyDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        getBabyData()
    }
    
    func config() {
        
        self.myViewModel = HFMyViewModel.init()
        let defaults: UserDefaults = UserDefaults.standard
        let update_Msg: [String : String] = defaults.object(forKey: "Update_Msg") as! [String : String]
        let versionCode: String = String(update_Msg["versionCode"]!)
        let locaVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        self.version = versionCode
        
        if locaVersion.elementsEqual(versionCode) {
            newVersion = false
        }else{
            self.newVersion = true
            let attach: String = update_Msg["attach"]!
            self.upAttach = attach
        }
        
        self.cacuMem()
        
        self.curButton = self.babyInfoBtn
        self.curLine = self.followLine
        self.aboutUsView.isHidden = true
        self.curButton?.titleLabel?.font = UIFont.init(name: "ARYuanGB-BD", size: 18)
        
        self.view.layer.contents = UIImage(named: "person_center_bg")?.cgImage
        self.tableView.register(UINib.init(nibName: "HFSetUpCommonCell", bundle: Bundle.main), forCellReuseIdentifier: "HFSetUpCommonCell")
        self.tableView.register(UINib.init(nibName: "HFCommButton", bundle: Bundle.main), forCellReuseIdentifier: "HFCommButton")
        
        self.adviceFeedback = (Bundle.main.loadNibNamed("HFAdviceFeedbackView", owner: nil, options: nil)?.last as! UIView)
        self.adviceFeedback?.frame = self.aboutUsView.frame
        self.bgHomeView.addSubview(self.adviceFeedback!)
        self.adviceFeedback?.isHidden = true
//        self.web = WKWebView(frame: self.webView.bounds)
        self.web = WKWebView()
        self.web?.scrollView.bounces = false
        self.web?.scrollView.showsVerticalScrollIndicator = false
        self.web?.scrollView.showsHorizontalScrollIndicator = false
        self.webView.addSubview(self.web!)
        self.web?.snp.makeConstraints({ (maker) in
            maker.top.left.right.bottom.equalToSuperview()
        })
//        self.edgesForExtendedLayout = .bottom
//        self.automaticallyAdjustsScrollViewInsets = true
//        self.web?.setNeedsLayout()
    }
    
    
    /// 缓存内容计算
    func cacuMem() {
        let bytesCache = SDImageCache.shared.totalDiskSize()
        let temp: Double = Double(bytesCache)/1000.00/1000.00
        self.cacheMem = "\(temp.keepDecimal(places: 2))MB"
    }
    
    
    /// 获取宝宝信息
    func getBabyData() {
        
//        let babyId = HFUserManager.shared().getUserInfo().babyInfo.babyID
//        Service.post(withUrl: GetChildInfoAPI, params: ["id": babyId], success: { (responseObject) in
//            let dic = NSDictionary(dictionary: responseObject! as! [NSObject : AnyObject])
//            self.dataModel = try? HFBabyDataModel.fromJSON(dic.mj_JSONString(), encoding: 4)
//            let placeHolder: String = (self.dataModel?.model.sex == 1) ? "img-nvbaby": "img-nanbaby"
//            self.headerImgView.sd_setImage(with: URL(string: (self.dataModel?.model.photo)!), placeholderImage: UIImage.init(named: placeHolder), options:SDWebImageOptions.init(), completed: nil)
//            self.nameLabel.text = self.dataModel?.model.name;
//
//            let date = NSDate()
//            print(date)
//            let curStr = "\(date)"
//            let culArr: Array = (curStr.substring(to: 10).components(separatedBy: "-"))
//
//            var culYear = 0
//            var culMonth = 0
//
//            if culArr.count>0{
//                culYear = Int(culArr[0])!
//                culMonth = Int(culArr[1])!
//            }
//
//            let arr: Array = (self.dataModel?.model.birth.components(separatedBy: "-"))!
//            var year = 0
//            var month = 0
//            if arr.count>0{
//                year = Int(arr[0])!
//                month = Int(arr[1])!
//            }
//            year = culYear - year
//            month = culMonth - month
//            self.ageLabel.text = "\(year)年\(month)个月"
//            self.tableView.reloadData()
//        }) { (error) in
//
//        }
        
        HFWebManager.shared().getUrlWithId("101", successBlock: { (model) in
            self.url101 = ServiceFactory.getCurrentBaseAPI() + model.agreeUrl
        }) {
            
        }
        HFWebManager.shared().getUrlWithId("102", successBlock: { (model) in
            self.url102 = ServiceFactory.getCurrentBaseAPI() + model.agreeUrl
        }) {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch selectPro {
            
        case .SetUpBabyInfo:
            return tipMsg[0].count
            
        case .SetUpAcountSetUp:
            return tipMsg[1].count
            
        case .SetUpAboutUs:
            return tipMsg[2].count
            
        case .SetFamilyMembers:
//            return (self.dataModel?.model.parentsInfoVOS.count)! + 1
//            return (self.dataModel?.model.parentsInfoVOS.count)!
        return 0
        case .SetUpSuggest:
            return 0
        case .SetUpAcountSecur:
            return tipMsg[3].count
        case .SetDelegate:
        return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSetUpCommonCell", for: indexPath) as! HFSetUpCommonCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HFSetUpCommonCell") as! HFSetUpCommonCell
        
        cell.corverView.isHidden = true
        cell.textField.isHidden = false
        cell.textField.textColor = .colorWithHexString("ABABAB")
        //        cell.contentView.isHidden = false
        switch selectPro {
        case .SetUpBabyInfo:
            cell.tipLabel.text = self.tipMsg[0][indexPath.row]
            switch indexPath.row {
            case 0:
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 5
//                cell.textField.text = self.dataModel?.model.name
            case 1:
                cell.intoImg.isHidden = true
                
                //下面这两行代码不能删除 是对下一个版本功能的注释
//                cell.corverView.isHidden = false
//                cell.sex(sex: (self.dataModel?.model.sex ?? 0))
                
//                if self.dataModel?.model.sex == 0 {
//                    cell.textField.text = "男"
//                }else{
//                    cell.textField.text = "女"
//                }
                cell.infoImgTrailing.constant = 5

            case 2:
                //                cell.intoImg.isHidden = false
                //                cell.infoImgTrailing.constant = 15
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 5
//                let str = String(self.dataModel?.model.birth ?? "")
//                if str.count > 0 {
//                    let pre = self.dataModel?.model.birth.substring(to: 10)
//                    cell.textField.text = pre
//                }
            case 3:
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 5
//                cell.textField.text = self.dataModel?.model.kindergartenName
            case 4:
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 5
//                cell.textField.text = self.dataModel?.model.className
            default:
                cell.intoImg.isHidden = false
                cell.infoImgTrailing.constant = 15
//                cell.textField.text = "完善信息"
                cell.textField.text = "查看"
            }
        case .SetUpAcountSecur:
            cell.tipLabel.text = self.tipMsg[3][indexPath.row]
            cell.textField.isHidden = true;
            cell.intoImg.isHidden = false
            cell.infoImgTrailing.constant = 15
            
        case .SetFamilyMembers:
//            if indexPath.row == self.dataModel?.model.parentsInfoVOS.count ?? 0{
//                let btn = tableView.dequeueReusableCell(withIdentifier: "HFCommButton") as! HFCommButton
//                return btn
//            }else{
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 5
//                let parent:HFParentsInfoVO  = (self.dataModel?.model.parentsInfoVOS[indexPath.row])!
//                cell.textField.text = parent.phone
//                cell.tipLabel.text = parent.name
//            }
        case .SetUpAboutUs:
            self.aboutUsView.isHidden = true
            cell.tipLabel.text = self.tipMsg[2][indexPath.row]
            if indexPath.row == 0 {
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 15
                cell.textField.text = "当前版本 \(self.version)"
                if newVersion{
                    
                }else{
                    
                }
            }
            if indexPath.row == 1 {
                cell.intoImg.isHidden = false
                cell.infoImgTrailing.constant = 15
                cell.textField.text = ""
            }

            if indexPath.row == 2 {
                cell.intoImg.isHidden = false
                cell.infoImgTrailing.constant = 15
                cell.textField.text = ""
            }
        default:
            cell.tipLabel.text = self.tipMsg[1][indexPath.row]
            switch indexPath.row {
            case 0:
                cell.intoImg.isHidden = true
                cell.infoImgTrailing.constant = 5
                cell.textField.text = HFUserManager.shared().getUserInfo().phone
//            case 1:
//                cell.intoImg.isHidden = false
//                cell.infoImgTrailing.constant = 15
//                cell.textField.text = HFUserManager.shared().getUserInfo().phone
//
//            case 2:
//                cell.intoImg.isHidden = false
//                cell.infoImgTrailing.constant = 15
//                cell.textField.text = "去修改"
//                cell.textField.textColor = .colorWithHexString("FA9030")
            case 1:
                cell.intoImg.isHidden = false
                cell.infoImgTrailing.constant = 15
                cell.textField.text = self.cacheMem
            default:
                cell.intoImg.isHidden = false
                cell.infoImgTrailing.constant = 15
                cell.textField.text = ""
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        switch self.selectPro {
        //        case .SetUpAcountSetUp:
        //            switch indexPath.row {
        //            case 1, 2:
        //                return 0
        //            default:
        //                return 49
        //            }
        //        default:
        //            return 49
        //        }
        switch self.selectPro {
        case .SetFamilyMembers:
//            if indexPath.row == self.dataModel?.model.parentsInfoVOS.count{
//                return 80
//            }else{
                return 49
//            }
        default:
            return 49
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch selectPro {
        case .SetUpBabyInfo:
            print("")
            switch indexPath.row {
            case 0 :
                print("")
            case 2:
                return;
                self.view.endEditing(true)
                let now = Date.init()
                let fmt = DateFormatter.init()
                fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let nowStr = fmt.string(from: now)
                CGXPickerView.showDatePicker(withTitle: "", dateType: .date, defaultSelValue: nil, minDateStr: "1900-01-01 00:00:00", maxDateStr: nowStr, isAutoSelect: false, manager: nil) { (selectValue) in
                }
            case 5:
                selectPro = .SetFamilyMembers
                self.tableView.reloadData()
            default:
                print("")
            }
        case .SetUpAcountSetUp:
            switch indexPath.row {
            case 0:
                print("手机号码")
//            case 1:
//                print("微信号")
//            case 2:
//                print("登录密码")
                
            case 1:
                print("清理缓存")
                alertCustom(1 ,indexPath as NSIndexPath, "清理缓存", "您当前已经使用\(self.cacheMem)\n清空不会影响app使用，您要清理吗？") {
                    self.clearCache()
                }
            default:
                print("账户安全")
                selectPro = .SetUpAcountSecur
                self.tableView .reloadData()
            }
        case .SetUpAcountSecur:
            print("")
            switch indexPath.row {
            case 1:
                print("账号注销")
                alertCustom(2 ,indexPath as NSIndexPath, "账号注销风险提示", "") {
                    self.destroyApply()
                }
            default:
                print("退出登录")
                alertCustom(1 ,indexPath as NSIndexPath, "退出登录", "您确定要退出登录吗？") {
                    self.letout()
                }
            }
//        case .SetFamilyMembers:
//            if indexPath.row == self.dataModel?.model.parentsInfoVOS.count{
//
//            }else{
//
//            }
        case .SetUpAboutUs:
            switch indexPath.row {
            case 0:
                print("版本更新")
                if newVersion{
                    alertCustom(1 ,indexPath as NSIndexPath, "版本更新", "发现新的版本\n版本已升级，让你使用更流畅") {
                        //这个时候跳转应用更新模块
                        let isExsit: Bool = UIApplication.shared.canOpenURL(URL(string: self.upAttach)!)
                        if isExsit{
                            UIApplication.shared.openURL(URL(string: self.upAttach)!)
                        }
                    }
                }else{
                    AlertTool.showCenter(withText: "当前版本已是最新")
                }
            case 1:
                selectPro = .SetDelegate
                self.aboutUsView.isHidden = false
                self.web?.load(URLRequest(url: URL(string: self.url101)!))
            default:
                selectPro = .SetDelegate
                self.aboutUsView.isHidden = false
                self.web?.load(URLRequest(url: URL(string: self.url102)!))
            }
        default:
            print("")
        }
    }
    
    
    func destroyApply() {
        //注销申请
        print("destroyApply")
    }
    
    
    /// 清除缓存
    func clearCache() {
        
        SDImageCache.shared.clearDisk {
            
        }
        AlertTool.showCenter(withText: "清理缓存成功")
        self.cacheMem = "0.00MB"
        self.tableView.reloadData()
    }
    
    
    /// 退出登录
    func letout() {
        
        self.myViewModel?.letout()
        self.myViewModel?.fetchLetoutCommand.execute(nil)?.subscribeCompleted({
            HFUserManager.shared().removeUserInfo()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLogindata"), object: ["name": "请登录", "sex": "1", "islogin": "1"])
            UIApplication.shared.keyWindow?.rootViewController = HomeViewController.init()
        })
    }
    
    
    /// 切换宝宝信息 账号设置 建议反馈 关于我们
    /// - Parameter sender: sender description
    @IBAction func selectItem(_ sender: UIButton) {
        if sender.tag == self.curButton?.tag {
            return
        }
        sender.titleLabel?.font = UIFont.init(name: "ARYuanGB-BD", size: 18)
        self.curButton?.titleLabel?.font = UIFont.init(name: "ARYuanGB-BD", size: 15)
        self.curButton = sender
        self.curLine?.isHidden = true
        self.aboutUsView.isHidden = true
        self.adviceFeedback?.isHidden = true
        switch sender.tag {
        case 101:
            self.curLine = self.followLine
            selectPro = .SetUpBabyInfo
        case 102:
            self.curLine = self.followLine1
            selectPro = .SetUpAcountSetUp
        case 103:
            self.curLine = self.followLine2
            selectPro = .SetUpSuggest
            self.adviceFeedback?.isHidden = false
        default:
            self.curLine = self.followLine3
            selectPro = .SetUpAboutUs
//            self.aboutUsView.isHidden = false
        }
        self.curLine?.isHidden = false
        self.tableView.reloadData()
    }
    
    //type弹窗的样式 1 取消确定弹窗。2 销毁账号。3、申请注销
    func alertCustom(_ type: Int ,_ indexPath: NSIndexPath ,_ title: String, _ message: String , _ actureClosure: @escaping ()->() ) {
        let custom: HFCustomAlertController = HFCustomAlertController.init()
        custom.titleStr = title
        custom.descriStr = message
        if type == 1 {
            custom.alertType = .typeDefault
        }else if type == 2{
            custom.alertType = .typeAcountDestroy
        }else{
            custom.alertType = .typeApplyDestroy
        }
        custom.actureClosure = { ()->() in
            actureClosure()
        }
        self.present(custom, animated: false, completion: nil)
    }
    
    
    /// 返回按钮点击
    /// - Parameter sender: 按钮
    @IBAction func backClick(_ sender: UIButton) {
        if self.selectPro == .SetUpAcountSecur {
            selectPro = .SetUpAcountSetUp
            self.tableView.reloadData()
        }else if self.selectPro == .SetFamilyMembers {
            selectPro = .SetUpBabyInfo
            self.tableView.reloadData()
        }else if self.selectPro == .SetDelegate {
            selectPro = .SetUpAboutUs
            self.tableView.reloadData()
        } else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
