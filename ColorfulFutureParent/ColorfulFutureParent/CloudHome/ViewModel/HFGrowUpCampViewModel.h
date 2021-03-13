//
//  HFGrowUpCampViewModel.h
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//  成长营ViewModel

#import "HFBaseViewModel.h"
@class HFCourseMessage;

NS_ASSUME_NONNULL_BEGIN

@interface HFGrowUpCampViewModel : HFBaseViewModel

/**
 参数
 */
//@property(nonatomic, copy)NSString *;
//@property(nonatomic, copy)NSString *;
//@property(nonatomic, copy)NSString *;
//@property(nonatomic, copy)NSString *;
//@property(nonatomic, copy)NSString *;
//@property(nonatomic, copy)NSString *;


@property (nonatomic, strong)HFCourseMessage *msg;
@property (nonatomic, strong)HFCourseMessage *timeMsg;


@property (nonatomic, strong)RACCommand *getPlayTimeCommand;
@property (nonatomic, strong)RACCommand *getCourseMsgCommand;


-(void)getCourseMsg;
-(void)getPlayTime;


@end

NS_ASSUME_NONNULL_END
