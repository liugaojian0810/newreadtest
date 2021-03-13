//
//  HFAPIConstant.swift
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/8/17.
//  Copyright © 2020 huifan. All rights reserved.
//

import Foundation

// MARK: 接口版本控制
public let S_VERSION = 1

// MARK: 网络请求主机地址
//public let S_HOST_DEBUG = "https://test-server.huifanayb.cn"
//public let S_HOST_DEBUG = "https://dev-mall.huifanayb.cn"
//public let S_HOST_DEBUG = "https://dev-edu-hfsaas.huifanayb.cn"
public let S_HOST_DEBUG = "https://test-edu-hfsaas.huifanayb.cn"

public let S_HOST_RELEASE = "https://mall.huifanayb.com"

// MARK: 商品和订单
public let S_HOST_GOODS = "/api-goods"
public let S_HOST_ORDER = "/api-order"
public let S_HOST_TUITION = "/api-tuition"


// MARK: ****************************************商城相关的接口订单部分
///********************商品部分
/// 首页
public let HomePageURL = "\(S_HOST_GOODS)/goods/v\(S_VERSION)/getGoodsIndex"

/// 首页商品列表
public let HomeGoodListURL = "\(S_HOST_GOODS)/goods/v\(S_VERSION)/getIndexGoodsList"

/// 添加收货地址
public let AddAddressURL = "\(S_HOST_ORDER)/hfMallAddressManage/v\(S_VERSION)/setAddressManage"

/// 首页商品详情
public let getGoodsDetailsAPI = "\(S_HOST_GOODS)/goods/v\(S_VERSION)/getGoodsDetails"

/// 首页商品规格列表
public let getGoodsSkuListAPI = "\(S_HOST_GOODS)/goods/v\(S_VERSION)/getGoodsSkuList"

/// 合同 api-order/orderContract/v1/getContractList
public let getSignListAPI = "\(S_HOST_ORDER)/contract/v\(S_VERSION)/getContractList"

/// 签署方查询接口 api-order/signContr/v1/signObjectList
public let signObjectList = "\(S_HOST_ORDER)/signContr/v\(S_VERSION)/signObjectList"
/// 请求手动签署接口 api-order/orderContract/v1/getSignUrl
public let getSignUrl = "\(S_HOST_ORDER)/orderContract/v\(S_VERSION)/getSignUrl"

///********************订单
///
/// 创建订单
public let paymentAPI = "\(S_HOST_ORDER)/orderCoreManagement/v\(S_VERSION)/payment"

/// 订单列表
public let orderListAPI = "\(S_HOST_ORDER)/leaderOrder/v\(S_VERSION)/orderList"

/// 订单详情
public let OrderDetailURL = "\(S_HOST_ORDER)/leaderOrder/v\(S_VERSION)/orderDetail"

/// 根据支付订单号查询订单金额信息
//public let RemainingMoneyURL = "\(S_HOST_ORDER)/leaderOrder/v\(S_VERSION)/getOrderAmountDetail"

/// 确认收货
public let ConfirmConsignURL = "\(S_HOST_ORDER)/leaderOrder/v\(S_VERSION)/confirmConsignee"

/// 取消订单
public let CancelOrderURL = "\(S_HOST_ORDER)/order/v\(S_VERSION)/cancelAnOrder"

/// 待发货去支付
public let PaymentConsignURL = "\(S_HOST_ORDER)/orderCoreManagement/v\(S_VERSION)/payment"

/// 收货地址列表
public let GetAddressListURL = "\(S_HOST_ORDER)/hfMallAddressManage/v\(S_VERSION)/getAddressManageList"

/// 添加收获地址
public let AddAddressListURL = "\(S_HOST_ORDER)/hfMallAddressManage/v\(S_VERSION)/setAddressManage"

/// 编辑收货地址
public let EditAddressListURL = "\(S_HOST_ORDER)/hfMallAddressManage/v\(S_VERSION)/updateAddressManage"

/// 删除收获地址
public let DeleteAddressListURL = "\(S_HOST_ORDER)/hfMallAddressManage/v\(S_VERSION)/delAddressManage"

// MARK: ********************活动
/// 活动列表【满赠】
public let ActivityListURL = "/activity/v\(S_VERSION)/getActivityList"

/// 活动商品列表【满赠】
public let ActivityGoodsListURL = "/activity/goods/v\(S_VERSION)/getGoodsList"

/// 根据活动id获取活动详情，赠品列表【满赠】
public let ActivityDetailsURL = "/activity/v\(S_VERSION)/getRedemptionByAiId"












// MARK: 缴费相关

//园长端审核列表
public let PayCostAuditListURL = "\(S_HOST_TUITION)/studentBalanceLog/v\(S_VERSION)/getBalanceAuditList"

//园长端审核操作
public let PayCostAuditURL = "\(S_HOST_TUITION)/studentBalance/v\(S_VERSION)/updBalanceType"


