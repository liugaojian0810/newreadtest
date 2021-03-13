//
//  HFAnswerQuestionCell.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFAnswerQuestionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addMySubViews()
        self.addSnap()
    }
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        bgView.isHidden = true
        bgView.backgroundColor = UIColor.jk_color(withHexString: "#FF5276")
        return bgView
    }()
    
    lazy var preView: UIView = {
        let pre = UIView()
        pre.backgroundColor = UIColor.jk_color(withHexString: "#FFD280")
        pre.layer.cornerRadius = 10
        pre.layer.masksToBounds = true
        return pre
    }()
    lazy var bgImg: UIImageView = {
        let bgImg = UIImageView()
        bgImg.layer.cornerRadius = 10
        bgImg.layer.masksToBounds = true
        return bgImg
    }()
    lazy var contentLab: UILabel = {
        let content = UILabel()
        content.textColor = UIColor.jk_color(withHexString: "#90501D")
        content.font = UIFont.boldSystemFont(ofSize: 16)
        content.textAlignment = .center
        content.text = "测试"
        return content
    }()
    
    @objc var resultTag: String? {
        willSet {
            
        }
    }
    
    func setResult(resultTag: String) -> Void {
        bgView.isHidden = false
        if resultTag == "1" {
            // 正确
            bgView.backgroundColor = UIColor.jk_color(withHexString: "#21D354")
            resultImg.image = UIImage.init(named: "anwser_right")
        } else {
            // 错误
            bgView.backgroundColor = UIColor.jk_color(withHexString: "#FF5276")
            resultImg.image = UIImage.init(named: "anwser_wrong")
        }
        self.layoutIfNeeded()
    }
    
    
    public var questModel: HFQequestModel? {
        willSet{
            bgView.isHidden = true
            resultImg.image = nil
            if newValue?.title.count ?? 0 > 10 {
                // 图片
                bgImg.isHidden = false
                contentLab.isHidden = true
                bgImg.kf.setImage(with: URL(string: newValue!.title))
                contentLab.text = ""
            } else {
                bgImg.isHidden = true
                contentLab.isHidden = false
                contentLab.text = newValue?.title
            }
        }
    }
    
    lazy var resultImg: UIImageView = {
        let resultImg = UIImageView()
        return resultImg
    }()
    
    func addMySubViews() {
        self.addSubview(bgView)
        self.addSubview(preView)
        self.addSubview(bgImg)
        self.addSubview(contentLab)
        self.addSubview(resultImg)
    }
    
    func addSnap() {
        bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(81)
            make.center.equalToSuperview()
        }
        
        preView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.top.equalTo(3)
        }
        
        bgImg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.top.equalTo(3)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(bgImg)
        }
        
        resultImg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(48)
            make.height.equalTo(46)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
