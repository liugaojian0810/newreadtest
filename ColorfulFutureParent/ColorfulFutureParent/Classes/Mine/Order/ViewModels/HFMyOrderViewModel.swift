//
//  HFMyOrderViewModel.swift
//  ColorfulFutureParent
//
//  Created by DH Fan on 2021/1/30.
//  Copyright © 2021 huifan. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

// 订单类型
enum HFOrderType {
    case gem // 宝石订单
    case bus_principal // 业务订单（园长端）
    case bus_teacher // 业务订单（教师端）
    case bus_parent // 业务订单（家长端）
}

class HFMyOrderViewModel {
    
    var orderType: HFOrderType = .gem
    
    var dataArr: [HFOrdereItemModelProtocol] = []
    
    var orderTotal = 0
    
    /// 查询订单列表
    func getOrderList(pageNum: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        if orderType == .gem {
            self.getGemOrderList(pageNum: pageNum, successClosure, failClosure)
        }else{
            self.getBusOrderList(pageNum: pageNum, successClosure, failClosure)
        }
    }
    
    /// 查询宝石订单列表
    func getGemOrderList(pageNum: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["pageNum"] = pageNum as AnyObject
        parameters["pageSize"] = 20 as AnyObject
        
        HFSwiftService.requestData(requestType: .Get, urlString: HFOrderAPI.GetMyGemOrderListAPI, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFGemOrderModel>>>().map(JSON: dic as! [String : Any] )
            
            if responseBaseModel?.model?.pageNum == 1 {
                self.dataArr.removeAll()
            }
            self.dataArr += responseBaseModel?.model?.list ?? []
            self.orderTotal = responseBaseModel?.model?.total ?? 0
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    /// 获取业务订单列表
    func getBusOrderList(pageNum: Int, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        
        var parameters = [String: AnyObject]()
        parameters["pageNum"] = pageNum as AnyObject
        parameters["pageSize"] = 20 as AnyObject
        var url = ""
        switch orderType {
        case .bus_principal:
            url = HFOrderAPI.GetPrincipalMyBusOrderListAPI
        case .bus_teacher:
            url = HFOrderAPI.GetTeacherMyBusOrderListAPI
        case .bus_parent:
            url = HFOrderAPI.GetParentMyBusOrderListAPI
        default:
            break
        }
        HFSwiftService.requestData(requestType: .Get, urlString: url, para: parameters, successed: { (response) in
            
            let dic = NSDictionary(dictionary: response as [String: AnyObject])
            let responseBaseModel = Mapper<HFResponseBaseModel<HFResponsePageBaseModel<HFBusOrderModel>>>().map(JSON: dic as! [String : Any] )
            
            if responseBaseModel?.model?.pageNum == 1 {
                self.dataArr.removeAll()
            }
            self.dataArr += responseBaseModel?.model?.list ?? []
            self.orderTotal = responseBaseModel?.model?.total ?? 0
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    // 取消订单
    func cancelOrder(boiId: String, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        var parameters = [String: AnyObject]()
        parameters["boiId"] = boiId as AnyObject
        var url = ""
        switch orderType {
        case .gem:
            url = HFOrderAPI.cancelGemOrderAPI
        case .bus_principal:
            url = HFOrderAPI.cancelPrincipalBusOrderAPI
        case .bus_teacher:
            url = HFOrderAPI.cancelTeacherBusOrderAPI
        case .bus_parent:
            url = HFOrderAPI.cancelParentBusOrderAPI
        }
        HFSwiftService.requestData(requestType: .Put, urlString: url, para: parameters, successed: { (response) in
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
    
    // 取消订单
    func deleteOrder(boiId: String, _ successClosure: @escaping ()->(),  _ failClosure: @escaping ()->()) -> Void {
        var parameters = [String: AnyObject]()
        parameters["boiId"] = boiId as AnyObject
        var url = ""
        switch orderType {
        case .gem:
            url = HFOrderAPI.delGemOrderAPI
        case .bus_principal:
            url = HFOrderAPI.delPrincipalBusOrderAPI
        case .bus_teacher:
            url = HFOrderAPI.delTeacherBusOrderAPI
        case .bus_parent:
            url = HFOrderAPI.delParentBusOrderAPI
        }
        HFSwiftService.requestData(requestType: .Delete, urlString: url, para: parameters, successed: { (response) in
            
            successClosure()
            
        }) { (error) in
            
            failClosure()
        }
    }
}
