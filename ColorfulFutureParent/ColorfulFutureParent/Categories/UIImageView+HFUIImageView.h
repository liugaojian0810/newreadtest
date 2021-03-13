//
//  UIImageView+HFUIImageView.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (HFUIImageView)
- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;
@end

NS_ASSUME_NONNULL_END
