//
//  UIView+HFDottedLine.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/10.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UIView+HFDottedLine.h"

@implementation UIView (HFDottedLine)
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    if (CGRectGetHeight(lineView.frame) > CGRectGetWidth(lineView.frame)) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame) / 2)];
        
    } else {
       [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth: CGRectGetHeight(lineView.frame) > CGRectGetWidth(lineView.frame) ? CGRectGetWidth(lineView.frame) : CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin: kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing],nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL, 0,0);
    if (CGRectGetHeight(lineView.frame) > CGRectGetWidth(lineView.frame)) {
        CGPathAddLineToPoint(path,NULL,0,CGRectGetHeight(lineView.frame));
    } else {
        CGPathAddLineToPoint(path,NULL,CGRectGetWidth(lineView.frame),0);
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
@end
