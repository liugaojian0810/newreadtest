//
//  HFAnswerQuestionView.swift
//  ColorfulFutureParent
//
//  Created by huifan on 2020/7/16.
//  Copyright © 2020 huifan. All rights reserved.
//

import UIKit
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width
let cellId = "HFAnswerQuestionCell"
class HFAnswerQuestionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias enumClick = (_ type : Int) -> Void
    var enumClicCallBack: enumClick?
    @objc var questionList: HFRequestionList? {
        willSet {
            bodyView.snp.remakeConstraints { (make) in
                make.top.equalTo(40)
                make.centerX.equalToSuperview()
                make.width.equalTo((newValue?.list.count ?? 1) * 92)
                make.bottom.equalTo(-18)
            }
            titleLab.text = newValue?.name
            bodyView.reloadData()
        }
    }
    
    @objc func enumClickCallBackBlock(block: @escaping enumClick) {
        enumClicCallBack = block
    }
    
    lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.textColor = UIColor.jk_color(withHexString: "#8A695E")
        titleLab.numberOfLines = 0
        titleLab.font = UIFont.boldSystemFont(ofSize: 12)
        titleLab.textAlignment = .center
        titleLab.text = "小朋友请你找出这些文案中，哪个是礼貌用语？小朋友请你找出这些文案中，哪个是礼貌用语？"
        return titleLab
    }()
    
    lazy var bodyView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 82 , height: 82)
        layout.minimumInteritemSpacing = 10
        let bodyView =  UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 380, height: 90), collectionViewLayout: layout)
        bodyView.delegate = self
        bodyView.backgroundColor = UIColor.white
        bodyView.dataSource = self
        bodyView.register(HFAnswerQuestionCell.self, forCellWithReuseIdentifier: cellId)
        return bodyView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
            make.height.greaterThanOrEqualTo(20)
            make.left.greaterThanOrEqualTo(52.5)
        }
        self.addSubview(bodyView)
        bodyView.snp.makeConstraints { (make) in
            make.top.equalTo(54)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(-4)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let questionList = questionList {
            return questionList.list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HFAnswerQuestionCell
        cell.questModel = questionList?.list[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView .cellForItem(at: indexPath) as! HFAnswerQuestionCell
        cell.setResult(resultTag: String(questionList?.list[indexPath.row].isRealanswer ?? 0))
        if enumClicCallBack != nil {
            enumClicCallBack!(indexPath.row)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
