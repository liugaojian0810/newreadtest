//
//  HFAnswerQuestionItem.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/15.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit

class HFAnswerQuestionItem: HFBaseView {
    
    @objc var bgImgName, contentStr: String?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 13
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.jk_color(withHexString: "#FF5276")
        return bgView
    }()
    lazy var bgImg: UIImageView = {
        let bgImg = UIImageView()
        bgImg.backgroundColor = UIColor.jk_color(withHexString: "#FFD280")
        bgImg.layer.cornerRadius = 10
        bgImg.layer.masksToBounds = true
        return bgImg
    }()
    lazy var contentLab: UILabel = {
        let content = UILabel()
        content.textColor = UIColor.jk_color(withHexString: "#90501D")
        content.font = UIFont.boldSystemFont(ofSize: 16)
        return content
    }()
    lazy var resultImg: UIImageView = {
        let resultImg = UIImageView()
        return resultImg
    }()
    
    override func addMySubViews() {
        self.addSubview(bgView)
        self.addSubview(bgImg)
        self.addSubview(contentLab)
        self.addSubview(resultImg)
    }
    
    override func addSnap() {
        bgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(81)
            make.center.equalToSuperview()
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
        }
    }
}
