//
//  HFMyClassController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/10/9.
//  Copyright © 2020 huifan. All rights reserved.
//  我的班级

import UIKit

class HFMyClassController: HFNewBaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        config()
    }
    
    func config() -> Void {
        self.title = "班级名称"
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
//        flowlayout.itemSize = CGSize(width: (S_SCREEN_WIDTH - 34) / 3, height: 32)
//        flowlayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flowlayout.headerReferenceSize = CGSize(width: S_SCREEN_WIDTH, height: 44)
        self.collectionView.setCollectionViewLayout(flowlayout, animated: true)
        self.collectionView.register(byIdentifiers: ["HFCommEditCollectionCell", "HFCommUserMsgCollectionCell"])
        
        
        self.collectionView.registerSupplemHead(byIdentifiers: ["HFConmmReusableHeadView"])
        
        self.collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ClassSelectCollectionViewCell")
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HFCommEditCollectionCell", for: indexPath) as! HFCommEditCollectionCell
            cell.tipLabel.text = "beautiful teacher"
            return cell
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HFCommUserMsgCollectionCell", for: indexPath) as! HFCommUserMsgCollectionCell
            cell.tipLabel.text = "beautiful me"
            return cell
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HFConmmReusableHeadView", for: indexPath) as! HFConmmReusableHeadView
        if indexPath.row == 0 {
            head.tipLabel.text = "小2班老师"
        }else{
            head.tipLabel.text = "小2班同学"
        }
        return head
    }
    
    // MARK: UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: S_SCREEN_WIDTH, height: 94)
        default:
            return CGSize(width: S_SCREEN_WIDTH / 3, height: 60)
        }
    }
    

}
