//
//  HFGetMulticoloredGemstoneInfoModel.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"
@class HFDateGemstoneList;
@class HFRecordList;
NS_ASSUME_NONNULL_BEGIN

@interface HFGetMulticoloredGemstoneInfoModel : HFBaseModel
@property (nonatomic, copy) NSArray<HFDateGemstoneList *> *dateGemstoneList;
@property (nonatomic, copy) NSString *total;
@end

@interface HFDateGemstoneList : HFBaseModel
@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSArray<HFRecordList *> *recordList;
@end

@interface HFRecordList : HFBaseModel
@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString* createUser;
@property (nonatomic, copy) NSString *currentNum;
@property (nonatomic, copy) NSString *gemstoneId;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *updateDate;
@property (nonatomic, copy) NSString *updateNum;
@property (nonatomic, copy) NSString *updateType;
@property (nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
