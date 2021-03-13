//
//  HFSchedulDateModel.h
//  ColorfulFutureTeacher_iOS
//
//  Created by 刘高见 on 2020/5/28.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFSchedulDate : HFBaseModel

@property(nonatomic, copy)NSString *date;
@property(nonatomic, copy)NSString *week;
@property(nonatomic, copy)NSString *val;

@end


@interface HFSchedulDateModel : HFBaseModel

@property (nonatomic ,strong) NSArray<HFSchedulDate *>*model;


@end

NS_ASSUME_NONNULL_END
