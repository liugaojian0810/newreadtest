//
//  HFClassPreViewController.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/21.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFClassPreViewController: UIViewController {
    typealias goToPlay = () -> ()
    @objc var callBackPlay: goToPlay?
    
    @objc var model: HFCourseForeshowModel? {
        willSet {
            if newValue == nil {
                return
            }
            titleLab.text = "关卡开始时间"
            headerView.text = newValue?.courseName
            beginTime.text = "7月15日 18：30"
            HFCountDown.getTimeInteger("\(newValue?.teachingDate ?? "") \(newValue?.startDate ?? ""):00") { (timeInteger: UInt) in
                if timeInteger <= 1{
                    // 跳转到播放页面
                    self.dismiss(animated: false) {
                        if self.callBackPlay != nil {
                            self.callBackPlay!()
                        }
                    }
                } else {
                    var timeStr = ""
                    var titleStr = newValue?.startDate
                    if timeInteger > 86400 {
                        // 超过24小时
                        timeStr = String.localizedStringWithFormat("%d天%02d:%02d:%02d", timeInteger / 60 / 60 / 24, timeInteger % (60 * 60 * 24) / 60 / 60, timeInteger % (60 * 60 * 24) % 3600 / 60, timeInteger % 60)
                        let tempArray = newValue?.teachingDate.split(separator: "-")
                        titleStr = "\(tempArray?[0] ?? "")月\(tempArray?[1] ?? "")日 \(newValue?.startDate ?? "")"
                    } else {
                        timeStr = String.localizedStringWithFormat("%02d:%02d:%02d", timeInteger / 60 / 60, timeInteger % 3600 / 60, timeInteger % 60)
                    }
                    self.countdownLabText = timeStr as NSString
                    self.beginTime.text = titleStr
                }
            }
        }
    }
    
    lazy var menusListView: HFVideoPlayEnumListView = {
        let menusListView = HFVideoPlayEnumListView()
        menusListView.rightEnums(isLive: true)
        menusListView.callBackBlock { (isOpen: Bool) in
            UIView.animate(withDuration: 0.4) {
                menusListView.snp.remakeConstraints { (make) in
                    make.centerY.equalToSuperview()
                    make.right.equalTo(isOpen ? 0: 78)
                }
                self.view .layoutIfNeeded()
            }
        }
        menusListView.enumClickCallBackBlock { (index: Int) in
            switch index {
            case 0:
                // 查看回放
                self.playBack()
                break
            case 1:
                // 查看课程表
                self.classCard()
                break
            case 2:
                // 分享
                self.share()
                break
            default:
                break
            }
        }
        return menusListView
    }()
    
    @objc func tapClick(sender: UITapGestureRecognizer){
        let enumTemp = (sender.view) as! HFVideoPlayEnumItemView
        switch enumTemp.playType {
        case .playback:
            // 查看回放
            playBack()
            break
        case .classCard:
            // 查看课程表
            classCard()
            break
        case .share:
            // 分享
            share()
            break
        }
    }
    
    func playBack() -> Void {
        // 查看回放
        self.present(HFPlayBackVideoViewController(), animated: false, completion: nil)
    }
    
    func classCard() -> Void {
        // 查看课程表
        self.present(HFPareScheduleController(), animated: false, completion: nil)
    }
    
    func share() -> Void {
        // 分享
        let userInfo = HFUserManager.getUserInfo()
        
        var parameters = [String:Any]()
        parameters["userId"] = userInfo.userId
        parameters["ownerId"] = userInfo.babyInfo.babyID
        parameters["clientType"] = 0
        parameters["goodsId"] = 1
        parameters["earningsSource"] = 2
        ShowHUD.showHUDLoading()
        Service.post(withUrl:  CloudHomeDetailAPI, params: parameters, success: { (responseObject: Any?) in
            ShowHUD.hiddenHUDLoading()
            let dict = NSDictionary(dictionary: responseObject! as! [NSObject: AnyObject])
            let detailModel = HFLessonDetailModel.mj_object(withKeyValues: dict["model"])
            let poster = HFPosterListController()
            poster.fromeType = .FRIEND
            if let detail = detailModel {
                poster.detailModel = detail
            }
            self.present(poster, animated: false, completion: nil)
            
        }) { (error: HFError?) in
            ShowHUD.hiddenHUDLoading()
        }
    }
    
    @objc func classPreViewCallBackBlock(block: @escaping goToPlay) {
        callBackPlay = block
    }
    
    lazy var bgView: UIImageView = {
        let bgView = UIImageView()
        return bgView
    }()
    
    lazy var headerView: UILabel = {
        let headerView = UILabel()
        headerView.backgroundColor = UIColor.jk_color(withWholeRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        headerView.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.textColor = .white
        headerView.textAlignment = .center
        headerView.isEnabled = false
        return headerView
    }()
    
    lazy var closeBtn: UIButton = {
        let closeBtn = UIButton()
        closeBtn.setBackgroundImage(UIImage.init(named: "icon-fanhui"), for: .normal)
        closeBtn.jk_touchUp {
            self.dismiss(animated: false, completion: nil)
        }
        return closeBtn
    }()
    
    lazy var contentView: UIView = {
        let content = UIView(frame: CGRect(x: 0, y: 0, width: 202, height: 180))
        content.backgroundColor = UIColor.jk_color(withWholeRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        content.layer.cornerRadius = 20
        content.layer.masksToBounds = true
        let img = UIImageView(image: UIImage.init(named: "img-tishi"))
        content.addSubview(img)
        img.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        content.addSubview(self.titleLab)
        self.titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        
        content.addSubview(self.beginTime)
        self.beginTime.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(48)
        }
        content.addSubview(self.line)
        self.line.center = content.center
        
        let subTitle = UILabel(text: "距离关卡开始还有")
        subTitle.font = UIFont.boldSystemFont(ofSize: 16)
        subTitle.textColor = .white
        content.addSubview(subTitle)
        subTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(110)
        }
        
        content.addSubview(self.timeLab)
        self.timeLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(140)
        }
        
        return content
    }()
    
    lazy var timeLab: UILabel = {
        let timeLab = UILabel()
        timeLab.text = "=:=:="
        timeLab.textColor = UIColor.jk_color(withHexString: "#FA9030")
        timeLab.textAlignment = .center
        timeLab.font = UIFont.boldSystemFont(ofSize: 18)
        return timeLab
    }()
    
    var countdownLabText: NSString? {
        willSet {
            if newValue!.length <= 8 {
                // 当天的
                self.timeLab.textColor = UIColor.jk_color(withHexString: "#FA9030")
                self.timeLab.text = newValue! as String
            } else {
                // 大于1天的
                let attrString = newValue!.stringwith(.white, whith: UIFont.boldSystemFont(ofSize: 18), with: NSRange(location: 1, length: 1), defaultColor: UIColor.jk_color(withHexString: "#FA9030"), defaultFont: UIFont.boldSystemFont(ofSize: 18));//NSMutableAttributedString(string: newValue!)
                timeLab.attributedText = attrString
            }
        }
    }
    
    
    lazy var beginTime: UILabel = {
        let beginTime = UILabel()
        beginTime.text = "敬请期待"
        beginTime.font = UIFont.boldSystemFont(ofSize: 23)
        beginTime.textColor = .white
        return beginTime
    }()
    
    lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.text = "暂无课程预告"//"关卡开始时间"
        titleLab.font = UIFont.boldSystemFont(ofSize: 16)
        titleLab.textColor = .white
        return titleLab
    }()
    
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 202, height: 0.5))
        UIView.drawLineOfDash(byCAShapeLayer: line, lineLength: 2, lineSpacing: 2, lineColor: .white)
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addVideoThumbnail()
        self.addMySubViews()
        self.addSnap()
        
        // Do any additional setup after loading the view.
    }
    func addMySubViews() -> Void {
        self.view.addSubview(bgView)
        self.view.addSubview(headerView)
        self.view.addSubview(closeBtn)
        
        self.view.addSubview(contentView)
        self.view.addSubview(menusListView)
    }
    
    func addSnap() -> Void {
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }
        closeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(22)
        }
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(202)
            make.height.equalTo(180)
        }
        
        menusListView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(78)
        }
    }
    
    //添加视频缩略图
    func addVideoThumbnail() -> Void {
        let img = UIImageView(frame: self.view.frame)
        img.image = UIImage(named: "img_video_thumbnail")
        self.view.addSubview(img)
    }
}
