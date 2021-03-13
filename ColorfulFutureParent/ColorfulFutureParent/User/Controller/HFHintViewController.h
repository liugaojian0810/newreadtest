//
//  HFHintViewController.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//
#import "HFCourseForeshowModel.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^HintBlock)(void);

@interface HFHintViewController : HFViewController
@property (nonatomic, strong)NSString *massageString;
@property (nonatomic, copy)HintBlock block;
@property (nonatomic, strong)NSString *titleString;
@property (nonatomic, strong)HFCourseForeshowModel *model;
@end

NS_ASSUME_NONNULL_END
