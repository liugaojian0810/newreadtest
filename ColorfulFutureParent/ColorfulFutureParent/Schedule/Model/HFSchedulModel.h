//
//  HFSchedulModel.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFSchedulDetailMessage : HFBaseModel

//yAxisList
@property(nonatomic, copy)NSString *endDate;
@property(nonatomic, copy)NSString *startDate;

//xAxisList
@property(nonatomic, copy)NSString *date;
@property(nonatomic, copy)NSString *week;
@property(nonatomic, copy)NSString *markDate;

//yAxisList
@property(nonatomic, copy)NSString *introduction;
@property(nonatomic, copy)NSString *xLocation;
@property(nonatomic, copy)NSString *yLocation;
@property(nonatomic, copy)NSString *colorRandom; //颜色

//公共参数
@property(nonatomic, copy)NSString *sign;

@end

@interface HFSchedulCurriculumType : HFBaseModel


@property(nonatomic, copy)NSString *curriculumType;
@property (nonatomic ,strong) NSArray<HFSchedulDetailMessage *>*dataList;
@property (nonatomic ,strong) NSArray<HFSchedulDetailMessage *>*xAxisList;
@property (nonatomic ,strong) NSArray<HFSchedulDetailMessage *>*yAxisList;

@end


@interface HFSchedulModel : HFBaseModel

@property(nonatomic, copy)NSString *curriculumName;
@property(nonatomic, strong)HFSchedulCurriculumType *curriculumType;

@end

NS_ASSUME_NONNULL_END



