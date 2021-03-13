//
//  SetViewController.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^letoutUpdataBabyNameBlock)(void);

@interface SetViewController : HFViewController
@property(nonatomic, copy)letoutUpdataBabyNameBlock block;//清除宝宝名字block

@end

NS_ASSUME_NONNULL_END
