//
//  HFGemViewModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/26.
//  Copyright © 2021 huifan. All rights reserved.
//

import UIKit
import StoreKit
import ObjectMapper
import SwiftyJSON

class HFGemViewModel: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    /// 请求商品成功回调
    var getGoodsSuccessClosure: OptionClosure?
    
    /// 请求商品失败回调
    var getGoodsFailClosure: OptionClosure?
    
    /// 充值成功
    var topUpSuccessClosure: OptionClosureInt?
    
    /// 充值失败
    var topUpFailClosure: OptionClosure?
    
    /// 重复购买回调
    var rePayClosure: OptionClosure?
    
    /// 商品id列表
    var prodIds = [String]()
    
    /// 商品列表
    var products: [SKProduct]?
    
    /// 添加支付交易监听
    func addTransactionObs() {
        SKPaymentQueue.default().add(self)
    }
    
    /// 异常商品订单管理
    var myViewModel = HFOffOrderViewModel.shared
    
    /// 解决支付交易监听
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    /// 商品id列表
    var productsIds: HFGemAccountConfigModel?
    
    /// 商品id列表请求（慧凡后端）
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    /// - Returns: 无
    func getProductsIds(_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) -> Void {
        let parameters = [String: AnyObject]()
        /**
         gemAccount    obj    宝石账户
         - gaTotal    string    宝石总额
         - gaBalance    string    宝石余额
         - gaFrozen    string    冻结金额
         - gaStatus    string    账户状态
         chooseList    list    宝石购买配置列表
         - gpId    string    宝石购买配置ID
         - gpName    string    名称
         - gpGemNum    string    数量
         - gpGemPrice    string    金额
         */
        HFSwiftService.requestData(requestType: .Get, urlString: HFCoinAPI.GetCoinAccountConfigAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFGemAccountConfigModel>>().map(JSON: dic as! [String : Any])
            self.productsIds = responseBaseModel?.model
            self.prodIds.removeAll()
            for item in self.productsIds?.chooseList ?? [] {
                self.prodIds.append(item.productId)
            }
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    /// 苹果服务器请求商品(消耗性商品列表)
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getConsumableGoodsList(_ ids: [String] ,_ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        self.getGoodsSuccessClosure = successClosure
        self.getGoodsFailClosure = failClosure
        let set: Set<String> = Set(ids)
        let request = SKProductsRequest(productIdentifiers: set)
        request.delegate = self
        request.start()
    }
    
    
    /// 商品查询的回调函数
    /// - Parameters:
    ///   - request: 请求对象
    ///   - response: 返回结果
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        /// 获取商品所有价格
        var prices = [Int]()
        for product in response.products {
            prices.append(Int(truncating: product.price))
//            prices.append(number)
        }
        
        /// 按照价格从高到低排序
        prices.sort()
        
        /// 实际商品添加进数组
        var actureProduces = [SKProduct]()
        for price in prices {
            for product in response.products {
                if Int(truncating: product.price) == price {
                    actureProduces.append(product)
                }
            }
        }
        
        self.products = actureProduces
        
        /// 请求回调
        if self.products?.count == 0 {
            if self.getGoodsFailClosure != nil {
                self.getGoodsFailClosure!()
            }
        }else{
            if self.getGoodsSuccessClosure != nil {
                self.getGoodsSuccessClosure!()
            }
        }
    }
    
    /// 监听购买结果
    /// - Parameters:
    ///   - queue: 支付队列
    ///   - transactions: 交易详细信息
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                //交易完成
                self.completeTransaction(transaction)
            case .purchasing:
                //商品添加进列表，购买中
                print("购买中...")
            case .failed:
                //交易失败
                ShowHUD.hiddenHUDLoading()
                self.failedTransaction(transaction)
            case .restored:
                //已经购买过该商品
                ShowHUD.hiddenHUDLoading()
                self.restoreTransaction(transaction)
            default:
                print(".deferred:事务在队列中，但是它的最终状态是等待外部操作。")
            }
        }
    }
    
    
    /// 苹果扣款完成后回调
    /// - Parameter transaction: 交易详情
    func completeTransaction(_ transaction: SKPaymentTransaction) {
        
        let url = Bundle.main.appStoreReceiptURL
        let receipt = NSData(contentsOf: url!)
        
        let finalReceipt = receipt?.base64EncodedString(options: .lineLength64Characters)
        
        let userId = HFUserInformation.userInfo()?.usrId
        if (((finalReceipt?.length() ?? 0) > 0) && ((userId?.length() ?? 0) > 0)) == false {
            ShowHUD.hiddenHUDLoading()
            return
        }else{
            var parameters = [String: AnyObject]()
            parameters["receipt"] = finalReceipt as AnyObject
            parameters["userId"] = userId as AnyObject
            HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.CancelWalletAPI, para: parameters, successed: { (response) in
                ShowHUD.hiddenHUDLoading()
                let dic = NSDictionary(dictionary: response as [NSObject: AnyObject])
                let totalNum = dic["totalMoney"] as! Int
                if self.topUpSuccessClosure != nil {
                    self.topUpSuccessClosure!(totalNum)
                }
            }) { (error) in
                self.myViewModel.addAbnormalOrder(finalReceipt!)
                ShowHUD.hiddenHUDLoading()
                if self.topUpFailClosure != nil {
                    self.topUpFailClosure!()
                }
            }
        }
        /// 完成以后关闭当前交易
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    /// 支付失败
    /// - Parameter transaction: 交易详情
    func failedTransaction(_ transaction: SKPaymentTransaction) {
        
        //        if transaction.error.code == SKErrorPaymentCancelled {
        //            print("用户取消交易")
        //        }else{
        //            print("购买失败")
        //        }
        if self.topUpFailClosure != nil {
            self.topUpFailClosure!()
        }
        /// 完成以后关闭当前交易
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    /// 对于已购商品，处理恢复购买的逻辑
    /// - Parameter transaction: 交易详情
    func restoreTransaction(_ transaction: SKPaymentTransaction) {
        
        if self.rePayClosure != nil {
            self.rePayClosure!()
        }
        /// 完成以后关闭当前交易
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    /// 消费明细集合
    var consumptions: [HFConsumptionDetailModel]?
    
    /// 消费明细列表
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getConsumptions(_ page: Int, _ successClosure: @escaping OptionClosure, _ failClosure: @escaping OptionClosure) {
        var parameters = [String: AnyObject]()
        parameters["pageNum"] = page as AnyObject
        parameters["pageSize"] = 15 as AnyObject
        HFSwiftService.requestData(requestType: .Get, urlString: HFCoinAPI.GetCoinPaymentsRecordsAPI, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponsePageBaseModel<HFConsumptionDetailModel>>().map(JSON: dic["model"] as! [String : Any])
            if page == 1 {
                self.consumptions?.removeAll()
            }
            self.consumptions? += responseBaseModel?.list ?? []
            successClosure()
        }) { (error) in
            failClosure()
        }
    }
    
    
    /// 宝石余额
    /// - Parameters:
    ///   - successClosure: 成功
    ///   - failClosure: 失败
    func getGemBalance(_ successClosure: @escaping OptionClosureInt, _ failClosure: @escaping OptionClosure) {
        let parameters = [String: AnyObject]()
        HFSwiftService.requestData(requestType: .Get, urlString: HFCoinAPI.GetGemBalance, para: parameters, successed: { (response) in
            let dic = NSDictionary(dictionary: response["model"] as! [String: AnyObject])
            let gaBalance = dic["gaBalance"] as! Int
            successClosure(gaBalance)
        }) { (error) in
            failClosure()
        }
    }
    
}
