//
//  UIDevice+HFDevice.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (HFDevice)
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;
/// 横屏
+ (void)setHScreen;

/// 竖屏
+ (void)setVScreen;
@end

NS_ASSUME_NONNULL_END
