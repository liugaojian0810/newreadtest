//
//  HFPosterListController.h
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//
typedef NS_ENUM(NSInteger,identifiType) {
    PLATFORT = 0,//平台身份
    FRIEND = 1//好友身份
};

NS_ASSUME_NONNULL_BEGIN
@class HFLessonDetailModel;

@interface HFPosterListController : UIViewController

@property (nonatomic,assign) identifiType fromeType;

@property (nonatomic, strong) HFLessonDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
