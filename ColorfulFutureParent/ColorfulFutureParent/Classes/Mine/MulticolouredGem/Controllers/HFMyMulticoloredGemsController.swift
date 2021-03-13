//
//  HFMyMulticoloredGemsController.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import StoreKit

class HFMyMulticoloredGemsController: HFNewBaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var myViewModel = HFGemViewModel()
    var curProduct: SKProduct?
    
    /// 充值成功提醒弹窗
    func showTopUpPop() {
        let subscribeHintView = Bundle.main.loadNibNamed("HFTopUpSuccessView", owner: nil, options: nil)?.last as! HFTopUpSuccessView
        subscribeHintView.frame = CGRect(x: 0, y: 0, width: S_SCREEN_WIDTH, height: S_SCREEN_HEIGHT)
        subscribeHintView.topupNumber = curProduct!.price
        UIApplication.shared.keyWindow!.addSubview(subscribeHintView)
        UIApplication.shared.keyWindow!.bringSubviewToFront(subscribeHintView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        addRefrash()
    }
    
    func config() {
        self.title = "我的五彩宝石"
        /// 添加支付交易监听
        self.myViewModel.addTransactionObs()
        /// 充值成功
        self.myViewModel.topUpSuccessClosure = { totalNum in
            self.showTopUpPop()
            Asyncs.async({  }) {
                self.collectionView.reloadData()
            }
        }
        /// 充值失败
        self.myViewModel.topUpFailClosure = {
            
        }
        /// 重复购买回调
        self.myViewModel.rePayClosure = {
            
        }
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 15
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.itemSize = CGSize(width: (S_SCREEN_WIDTH - 13) / 3, height: (S_SCREEN_WIDTH - 10) / 3)
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.collectionView.setCollectionViewLayout(flowlayout, animated: true)
        self.collectionView.register(byIdentifiers: ["HFMyMulticoloredGemCell"])
        self.collectionView.register(UINib.init(nibName: "HFMyMulticoloredGemsHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HFMyMulticoloredGemsHeadView")
        self.collectionView.register(UINib.init(nibName: "HFPayInstructionsView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HFPayInstructionsView")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "消费明细", style: .done, target: self, action: #selector(consumptionDetail))
    }
    
    /// 请求商品id集合
    func addRefrash() {
        self.collectionView.headerRefreshingBlock { (page) in
            self.myViewModel.getProductsIds({
                self.collectionView.mj_header?.endRefreshing()
                self.getProducts()
            }, { self.collectionView.mj_header?.endRefreshing() })
        }
        self.collectionView.mj_header?.beginRefreshing()
    }
    
    /// 根绝商品集合id请求商品列表
    func getProducts() {
        self.myViewModel.getConsumableGoodsList(self.myViewModel.prodIds) {
            Asyncs.async({
                
            }) {
                self.collectionView.reloadData()
            }
        } _: {
            Asyncs.async({
                
            }) {
                self.collectionView.reloadData()
            }
        }
    }
    
    /// 消费明细
    @objc func consumptionDetail() {
        let vc = HFConsumptionDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 互动活动
    @IBAction func interactiveActivities(_ sender: UIButton) {
        let activitie = HFAllInteractiveViewController()
        self.navigationController?.pushViewController(activitie, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.myViewModel.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HFMyMulticoloredGemCell", for: indexPath) as! HFMyMulticoloredGemCell
        cell.setContent()
        cell.product = self.myViewModel.products?[indexPath.row]
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: S_SCREEN_WIDTH, height: 220)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: S_SCREEN_WIDTH, height: 180)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HFMyMulticoloredGemsHeadView", for: indexPath) as! HFMyMulticoloredGemsHeadView
            headerView.balanceLabel.text = String(self.myViewModel.productsIds?.gemAccount?.gaBalance ?? 0)
            return headerView
        }else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HFPayInstructionsView", for: indexPath)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /// 检测关闭未完成的交易
        let ingTransations = SKPaymentQueue.default().transactions
        if ingTransations.count > 0 {
            let transation = ingTransations.first!
            if transation.transactionState == SKPaymentTransactionState.purchased {
                SKPaymentQueue.default().finishTransaction(transation)
                return
            }
        }
        /// 发送购买请求
        ShowHUD.showHUDLoading()
        curProduct = (self.myViewModel.products?[indexPath.row])!
        let payment = SKPayment(product: (self.myViewModel.products?[indexPath.row])!)
        SKPaymentQueue.default().add(payment)
    }
    
}
