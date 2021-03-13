//
//  UIView+HFCornerRadius.m
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UIView+HFCornerRadius.h"

@implementation UIView (HFCornerRadius)
- (void)setCornerRadius:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    shapLayer.frame = rect;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
}

- (void)setCorner:(UIRectCorner)corners withRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    shapLayer.frame = rect;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
}

@end
