//
//  UIView+HFCornerRadius.h
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HFCornerRadius)

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setCorner:(UIRectCorner)corners withRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
