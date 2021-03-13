//
//  HFOrderDetailModel.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/29.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFOrderDetailModel : HFBaseModel
@property (nonatomic, copy) NSString *couponAmount;
@property (nonatomic, copy) NSString *gmtCancel;
@property (nonatomic, copy) NSString *gmtComplete;
@property (nonatomic, copy) NSString *gmtCreate;
@property (nonatomic, copy) NSString *gmtPay;
@property (nonatomic, copy) NSString *gmtRefundApply;
@property (nonatomic, copy) NSString *gmtRefundComplete;
@property (nonatomic, copy) NSString *goodsMainPhotoUrl;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsThumbnailUrl;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *outerNo;
@property (nonatomic, copy) NSString *payAmount;
@property (nonatomic, copy) NSString *payChannel;
@property (nonatomic, copy) NSString *payStatus;
@property (nonatomic, copy) NSString *payWay;
@property (nonatomic, copy) NSString *refundApplyReason;
@property (nonatomic, copy) NSString *showPrice;
@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *goodsDetails;
@property (nonatomic, copy) NSString *goodsDetailsH5;

@end

NS_ASSUME_NONNULL_END
