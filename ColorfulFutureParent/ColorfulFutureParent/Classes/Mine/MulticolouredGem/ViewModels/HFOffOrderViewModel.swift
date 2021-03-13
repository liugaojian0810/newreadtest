//
//  HFOffOrderViewModel.swift
//  ColorfulFutureParent
//
//  Created by liugaojian on 2021/1/28.
//  Copyright © 2021 huifan. All rights reserved.
//  掉单处理 支付异常结果处理

import UIKit

class HFOffOrderViewModel {
    
    //单例创建
    static let shared = HFOffOrderViewModel()
    
    init() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 保存结果
    func reSubmitUnSolvedOrder() {
        let orders = self.getUnSolvedOrder(HFUserInformation.userInfo()?.usrId ?? "")
        if orders.count > 0 {
            for receipt in orders {
                self.execSave(receipt)
            }
        }
    }
    
    /// 处理未处理订单
    /// - Parameter usrId: 用户id
    /// - Returns: 结果
    private func getUnSolvedOrder(_ usrId: String) -> [String] {
        
        let orders = (UserDefaults.standard.object(forKey: usrId) ?? [String]())
        return orders as! [String]
    }
    
    /// 执行重传操作
    private func execSave(_ receipt: String) {
        let usrId = HFUserInformation.userInfo()?.usrId ?? ""
        if usrId.length() > 0 {
            var parameters = [String: AnyObject]()
            parameters["receipt"] = receipt as AnyObject
            parameters["userId"] = usrId as AnyObject
            HFSwiftService.requestData(requestType: .Post, urlString: HFBaseUseAPI.CancelWalletAPI, para: parameters, successed: { (response) in
                var orders = self.getUnSolvedOrder(HFUserInformation.userInfo()?.usrId ?? "")
                for (index, orderId) in orders.enumerated() {
                    if receipt == orderId {
                        orders.remove(at: index)
                    }
                }
                let userDefault = UserDefaults.standard
                userDefault.setValue(orders, forKey: usrId)
                userDefault.synchronize()
            }) { (error) in }
        }
    }
    
    /// 记忆异常商品订单
    /// - Parameter receipt: 商品id
    func addAbnormalOrder(_ receipt: String) {
        let usrId = HFUserInformation.userInfo()?.usrId ?? ""
        if usrId.length() > 0 {
            var orders = self.getUnSolvedOrder(HFUserInformation.userInfo()?.usrId ?? "")
            orders.append(receipt)
            let userDefault = UserDefaults.standard
            userDefault.setValue(orders, forKey: usrId)
            userDefault.synchronize()
        }
    }
    
}
