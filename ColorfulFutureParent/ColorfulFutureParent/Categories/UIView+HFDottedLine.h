//
//  UIView+HFDottedLine.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/10.
//  Copyright © 2020 huifan. All rights reserved.
//  绘制一条虚线
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HFDottedLine)
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
