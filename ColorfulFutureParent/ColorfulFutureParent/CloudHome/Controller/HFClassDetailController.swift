//
//  HFClassDetailController.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/22.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
import SwiftyFitsize

class HFClassDetailController: UIViewController {
    
    var detailModel: HFLessonDetailModel?
    var dataArray = [NSString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMySubViews()
        addSnap()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func addMySubViews() -> Void {
        addBGView()
        self.view.addSubview(backBtn)
        self.view.addSubview(titleLab)
        
        // 左半边
        self.view.addSubview(leftBGView)
        self.view.addSubview(leftImage)
        self.view.addSubview(leftTitleLab)
        self.view.addSubview(priceLab)
        self.view.addSubview(buyBtn)
        
        // 右半边
        self.view.addSubview(rightBGView)
        rightBGView.addSubview(rightTitleLab)
        rightBGView.addSubview(buyPersonCount)
        rightBGView.addSubview(shareBtn)
        rightBGView.addSubview(scrollView)
        scrollView.addSubview(contentText)
        scrollView.addSubview(contentView)
    }
    private func addSnap() -> Void {
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(40)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
        }
        
        // 左半边
        leftBGView.snp.makeConstraints { (make) in
            make.bottom.equalTo(HFTools_Swift.isFullScreen ? -48 : -30)
            make.left.equalTo(HFTools_Swift.isFullScreen ? 40: 20)
        }
        
        leftImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(136)
            make.left.equalTo(leftBGView).offset(17)
            make.top.equalTo(leftBGView).offset(13)
        }
        
        leftTitleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(leftBGView)
            make.left.equalTo(leftBGView).offset(15)
            make.top.equalTo(leftBGView.snp_bottom).offset(-80)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.left.equalTo(leftTitleLab)
            make.top.equalTo(leftTitleLab.snp_bottom).offset(10)
        }
        
        buyBtn.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(leftBGView).offset((-10))
        }
        
        // 右半边
        rightBGView.snp.makeConstraints { (make) in
            make.top.equalTo(leftBGView)
            make.bottom.equalTo(self.view)
            make.left.equalTo(leftBGView.snp_right).offset(15)
            make.right.equalTo(HFTools_Swift.isFullScreen ? -40: -20)
        }
        rightTitleLab.snp.makeConstraints { (make) in
            make.left.top.equalTo(12)
        }
        buyPersonCount.snp.makeConstraints { (make) in
            make.centerY.equalTo(rightTitleLab)
            make.right.equalTo(-105)
        }
        shareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-15)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(40)
        }
        
        contentText.snp.makeConstraints { (make) in
            make.top.equalTo(46)
            make.right.equalTo(-15)
            make.left.equalTo(15)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(contentText.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(15)
        }
    }
    //购买课程
    func payClass() {
        let userInfo:HFUserInfo = HFUserManager.shared().getUserInfo()
        var param = [String: Any]()
        param["childrenId"] = userInfo.babyInfo.babyID
        param["ownerId"] = userInfo.babyInfo.babyID
        param["goodsId"] = 1
        param["kgId"] = userInfo.babyInfo.kgId
        param["payChannel"] = 1
        param["portType"] = 3
        param["thisUserTele"] = userInfo.phone
        param["type"] = 2
        param["userId"] = userInfo.userId
        ShowHUD.showHUDLoading()
        Service.post(withUrl: PayGoodsCommodityAPI, params: param, success: { (any:Any?) in
            ShowHUD.hiddenHUDLoading()
            let dict = NSDictionary(dictionary: any! as! [NSObject: AnyObject])
            let Buy = HFBuyLessonWebController()
            Buy.dataDic = dict["model"] as! [AnyHashable : Any]
            self.present(Buy, animated: true, completion: nil)
        }) { (error:HFError?) in
            ShowHUD.hiddenHUDLoading()
            MBProgressHUD.showMessage(error?.errorMessage)
        }
        
    }
    lazy var titleLab: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "云家园"
        title.font = UIFont.boldSystemFont(ofSize: 28)
        return title
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton()
        backBtn.setBackgroundImage(UIImage.init(named: "icon-fanhui"), for: .normal)
        backBtn.jk_touchUp {
            self.dismiss(animated: false, completion: nil)
        }
        return backBtn
    }()
    
    lazy var leftBGView: UIImageView = {
        let leftBGView = UIImageView()
        leftBGView.image = UIImage.init(named: "img-movie")
        return leftBGView
    }()
    
    lazy var rightBGView: UIView = {
        let rightBGView = UIView()
        rightBGView.backgroundColor = UIColor.jk_color(withHexString: "#FFEEDE")
        rightBGView.layer.cornerRadius = 10
        rightBGView.layer.masksToBounds = true
        return rightBGView
    }()
    
    lazy var leftImage: UIImageView = {
        let leftImage = UIImageView()
        leftImage.layer.cornerRadius = 20
        leftImage.layer.masksToBounds = true
        return leftImage
    }()
    lazy var leftTitleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.numberOfLines = 0
        titleLab.textColor = UIColor.jk_color(withHexString: "#454545")
        titleLab.font = UIFont.boldSystemFont(ofSize: 16)
        titleLab.text = "云家园课程（思维空间站）"
        return titleLab
    }()
    
    lazy var priceLab: HFAttributeTapLabel = {
        let priceLab = HFAttributeTapLabel()
        priceLab.text = "价格:199元"
        return priceLab
    }()
    
    lazy var buyBtn: UIButton = {
        let buyBtn = UIButton()
        buyBtn.setBackgroundImage(UIImage.init(named: "button-buynow"), for: .normal)
        buyBtn.jk_touchUp {
            // 立即购买
            if let detailmodel = self.detailModel {
                let lessonProtoVC = HFLessonProtocolController()
                HFWebManager.shared().presentWeb(withId: "103", fromVc: self) {
                    self.payClass()
                }
            } else {
                 MBProgressHUD.showMessage( "数据异常")
            }
        }
        buyBtn.setTitle("立即购买", for: .normal)
        buyBtn.setTitleColor(.white, for: .normal)
        buyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return buyBtn
    }()
    
    lazy var rightTitleLab: UILabel = {
        let rightTitle = UILabel()
        rightTitle.textColor = UIColor.jk_color(withHexString: "#454545")
        rightTitle.font = UIFont.boldSystemFont(ofSize: 16)
        rightTitle.text = "云家园详情"
        return rightTitle
    }()
    
    lazy var buyPersonCount: UILabel = {
        let personCount = UILabel()
        personCount.text = "2050人已购买"
        return personCount
    }()
    
    lazy var shareBtn: UIButton = {
        let shareBtn = UIButton()
        shareBtn.setBackgroundImage(UIImage.init(named: "button-fenxiang"), for: .normal)
        shareBtn.jk_touchUp {
            // 去分享
            if let detailmodel = self.detailModel {
                let poster = HFPosterListController()
                poster.fromeType = .FRIEND
                poster.detailModel = detailmodel
                self.present(poster, animated: false, completion: nil)
            } else {
                 MBProgressHUD.showMessage( "数据异常")
            }
        }
        return shareBtn
    }()
    
    lazy var scrollView: UIScrollView = {
        let content = UIScrollView()
        content.showsVerticalScrollIndicator = false
        content.showsHorizontalScrollIndicator = false
        content.backgroundColor = .white
        content.addSubview(self.contentTitle)
        self.contentTitle.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.centerX.equalToSuperview()
        }
        
        // 两侧横线
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor.jk_color(withHexString: "#BAB0FF")
        content.addSubview(leftLine)
        leftLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentTitle)
            make.width.equalTo(12)
            make.height.equalTo(0.5)
            make.right.equalTo(self.contentTitle.snp_left).offset(-10)
        }
        
        // 两侧横线
        let rightLine = UIView()
        rightLine.backgroundColor = UIColor.jk_color(withHexString: "#BAB0FF")
        content.addSubview(rightLine)
        rightLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentTitle)
            make.width.equalTo(12)
            make.height.equalTo(0.5)
            make.left.equalTo(self.contentTitle.snp_right).offset(10)
        }
        return content
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var contentTitle: UILabel = {
        let title = UILabel()
        title.text = "关卡简介"
        title.textColor = UIColor.jk_color(withHexString: "#454545")
        title.font = UIFont.boldSystemFont(ofSize: 16)
        return title
    }()
    
    lazy var contentText: UILabel = {
        let content = UILabel()
        content.jk_resizeVertical(40)
        content.numberOfLines = 0
        content.textColor = UIColor.jk_color(withHexString: "#666666")
        content.font = UIFont.systemFont(ofSize: 13)
        return content
    }()
    
    private func addBGView() -> Void {
        let bgView = UIImageView(image: UIImage.init(named: "classDetail_BG"))
        bgView.frame = self.view.bounds
        self.view.addSubview(bgView)
    }
    
    func setLineSpacing(space: CGFloat, text: String, fontSize: CGFloat) -> NSAttributedString {
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = space
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize),
                          NSAttributedString.Key.paragraphStyle: paraph]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func setPrice() -> Void {
        let str = String.init(format: "价格：%.2f元", (detailModel?.showPrice.float() ?? 0) * 0.01)//"价格：\(detailModel?.showPrice)"
        let model1 = HFAttributeModel()
        model1.string = "价格："
        model1.attributeDic = [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("#666666"), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        model1.range = NSRange(location: 0, length: 3)
        
        let model2 = HFAttributeModel()
        model2.string = "元"
        model2.attributeDic = [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("#FF4B37"), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        model2.range = NSRange(location: str.count - 1, length: 1)
        
        self.priceLab.setText(str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.colorWithHexString("#FF4B37"),NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17)], tapStringArray: [model1,model2])
    }
    
    func loadContentView() -> Void {
        leftTitleLab.text = self.detailModel?.goodsName
        buyPersonCount.text = "\(detailModel?.buyNum ?? "0")人已购买"
        setPrice()
        self.contentText.attributedText = setLineSpacing(space: 7, text: self.detailModel?.goodsDetails ?? "", fontSize: 13)
        leftImage.kf.setImage(with: URL(string: self.detailModel?.goodsThumbnailUrl ?? ""), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        setRightScrollViewContent()
    }
    
    func setRightScrollViewContent() -> Void {
        self.dataArray = (self.detailModel?.goodsDetailsH5.components(separatedBy: ",") ?? []) as [NSString]
        let v1 = self.view.bounds.size.width - 15.0 - 227.0
        let v2: CGFloat = HFTools_Swift.isFullScreen ? 80.0: 40.0
        let width = v1 - v2 - 30
        var temps = Array(repeating: UIImageView(), count: self.dataArray.count)
        for (index, item) in self.dataArray.enumerated() {
            let img = UIImageView()
            temps[index] = img
            contentView.addSubview(img)
            img.kf.setImage(with: URL(string: item as String), placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL)  in
                if index == 0 {
                    // 第一个图片
                    img.snp.makeConstraints { (make) in
                        make.left.right.top.equalToSuperview()
                        make.width.equalTo(width)
                        make.height.equalTo(width).multipliedBy((image?.size.width ?? 0) / (image?.size.height ?? 1))
                    }
                } else if (index != self.dataArray.count - 1) {
                    // 中间图片
                    img.snp.makeConstraints { (make) in
                        make.left.right.equalToSuperview()
                        make.top.equalTo(temps[index - 1].snp.bottom)
                        make.height.equalTo(width).multipliedBy((image?.size.width ?? 0) / (image?.size.height ?? 1))
                    }
                } else {
                    // 最后图片
                    img.snp.makeConstraints { (make) in
                        make.left.right.equalToSuperview()
                        make.top.equalTo(temps[index - 1].snp.bottom)
                        make.height.equalTo(width).multipliedBy((image?.size.width ?? 0) / (image?.size.height ?? 1))
                        make.bottom.equalToSuperview()
                    }
                }
            }
        }
    }
    func loadData() -> Void {
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
            self.detailModel = HFLessonDetailModel.mj_object(withKeyValues: dict["model"])
            self.loadContentView()
        }) { (error: HFError?) in
            ShowHUD.hiddenHUDLoading()
        }
    }
}
