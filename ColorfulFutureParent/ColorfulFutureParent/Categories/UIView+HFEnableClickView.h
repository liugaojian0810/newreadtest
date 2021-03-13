//
//  UIView+HFEnableClickView.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HFEnableClickView)
- (void)setTapActionWithBlock:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
