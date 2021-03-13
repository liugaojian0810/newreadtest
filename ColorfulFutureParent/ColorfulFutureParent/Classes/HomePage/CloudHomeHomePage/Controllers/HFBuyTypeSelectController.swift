//
//  HFBuyTypeSelectController.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/10/26.
//  Copyright © 2020 huifan. All rights reserved.
//
// 五彩宝石充值

import UIKit

class HFBuyTypeSelectController: HFNewBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topBgView: UIView!
    
    // 支付成功回调
    var buySuccessClosure: OptionClosure?
    var selectIndex: Int = -1
    var types = ["50", "110", "230", "350", "600", "1500"]
    var prices = ["50", "100", "200", "300", "500", "1000"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() -> Void {
        
        self.topBgView.setCorner([.topLeft, .topRight], withRadius: 8)
        self.view.backgroundColor = .clear
        self.bottomConstraint.constant = kSafeBottom
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 15
        flowlayout.minimumInteritemSpacing = 10
        flowlayout.itemSize = CGSize(width: (S_SCREEN_WIDTH - 14 * 2 - 20) / 3, height: 100)
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 15, right: 14)
        self.collectionView.setCollectionViewLayout(flowlayout, animated: true)
        self.collectionView.register(byIdentifiers: ["HFBuyTypeSelectCell"])
    }

    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HFBuyTypeSelectCell", for: indexPath) as! HFBuyTypeSelectCell
        cell.setContent(types[indexPath.row], prices[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectIndex = indexPath.row
        self.dismiss(animated: true, completion: {})
        // 支付成功回调
        if buySuccessClosure != nil {
            buySuccessClosure!()
        }
    }
}
