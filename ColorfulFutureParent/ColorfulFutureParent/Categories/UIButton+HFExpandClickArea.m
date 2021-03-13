//
//  UIButton+HFExpandClickArea.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/16.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UIButton+HFExpandClickArea.h"
#import <objc/runtime.h>

@implementation UIButton (HFExpandClickArea)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
 
- (void)setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}
 
- (UIView*)hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    [super pointInside:point withEvent:event];
    //获取bounds实际大小
    CGRect bounds = self.bounds;
    if (self.clickArea) {
        CGFloat area = [self.clickArea floatValue];
        CGFloat widthDelta = MAX(area * bounds.size.width - bounds.size.width, .0);
        CGFloat heightDelta = MAX(area * bounds.size.height - bounds.size.height, .0);
        //扩大bounds
        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    }
    //点击的点在新的bounds 中 就会返回YES
    return CGRectContainsPoint(bounds, point);
}


- (void)setClickArea:(NSString *)clickArea{
    objc_setAssociatedObject(self, @selector(clickArea), clickArea, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)clickArea{
    return objc_getAssociatedObject(self, @selector(clickArea));
}


@end
