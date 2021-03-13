//
//  HFOrderListModel.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

@class HFOrderList;
@class HFParams;
NS_ASSUME_NONNULL_BEGIN

@interface HFOrderListModel : HFBaseModel
@property (nonatomic, copy)NSArray <HFOrderList *> *list;
@property (nonatomic, copy) NSString *offset;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *pages;
@property (nonatomic, strong) HFParams *params;
@property (nonatomic, copy) NSString *total;
@end

@interface HFOrderList : HFBaseModel
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *clientType;
@property (nonatomic, copy) NSString *sourceUserName;
@property (nonatomic, copy) NSString *pageNum;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *gmtCreate;
@property (nonatomic, copy) NSString *goodsFlag;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsThumbnailUrl;
@property (nonatomic, copy) NSString *ownerID;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *pageSize;
@property (nonatomic, copy) NSString *gmtPay;
@property (nonatomic, copy) NSString *payWay;

@end

@interface HFParams : NSObject
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, assign) NSInteger goodsFlag;
@property (nonatomic, assign) NSInteger clientType;
@property (nonatomic, assign) NSInteger childID;
@property (nonatomic, assign) NSInteger userID;
@end

NS_ASSUME_NONNULL_END
