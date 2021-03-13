//
//  UIView+Extension.m
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import "UIView+Extension.h"
@implementation UIView (Extension)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}

#pragma mark -

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    /// Finds the view's view controller.
    
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}



- (void)setCorner:(UIRectCorner)corners withRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *shapLayer = [[CAShapeLayer alloc] init];
    shapLayer.frame = rect;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
}

- (void)setCornerRadius:(CGFloat)radius{
    [self setCorner:UIRectCornerAllCorners withRadius:radius];
}

- (void)cornerSelfHeight {
    CGFloat height = self.height;
    UIBezierPath *maskPath=  [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(height/ 2-1, height/ 2-1)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    self.layer.masksToBounds=YES;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (instancetype)createFromNibFile {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)grayMaskMe{
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
}

- (void)showInfo:(NSString *)infoString{
    UIViewController *vc = [self viewController];
//    [KKKHelper showToViewController:vc withTitle:@"提示" andInfo:infoString];
}
+ (void)setViewStyle:(UIView *)view {
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowOpacity = 0.3;
    view.layer.shadowRadius = 1;

}
/**
 *  @brief  震动动画
 */
-(void)ShakeView
{
    self.translatesAutoresizingMaskIntoConstraints = YES;
    CALayer *lbl = [self layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-3, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+3, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.07];
    [animation setRepeatCount:2];
    [lbl addAnimation:animation forKey:nil];
    self.translatesAutoresizingMaskIntoConstraints = NO;
}
+ (void)loadBTGifImageIsClose:(BOOL)isClose {
}

- (void)shadowColorWith:(NSInteger)row {
    //路径阴影
       UIBezierPath *path = [UIBezierPath bezierPath];
       
       float width = self.bounds.size.width;
       float height = self.bounds.size.height;
       float x = self.bounds.origin.x;
        float y = self.bounds.origin.y;
       float addWH = row;
       
       CGPoint topLeft      = self.bounds.origin;
       CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
       CGPoint topRight     = CGPointMake(x+width,y);
       
       CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
       
       CGPoint bottomRight  = CGPointMake(x+width,y+height);
       CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
       CGPoint bottomLeft   = CGPointMake(x,y+height);
       
       
       CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
       
       [path moveToPoint:topLeft];
       //添加四个二元曲线
       [path addQuadCurveToPoint:topRight
                    controlPoint:topMiddle];
       [path addQuadCurveToPoint:bottomRight
                    controlPoint:rightMiddle];
       [path addQuadCurveToPoint:bottomLeft
                    controlPoint:bottomMiddle];
       [path addQuadCurveToPoint:topLeft
                    controlPoint:leftMiddle];
       //设置阴影路径
       self.layer.shadowPath = path.CGPath;
}

@end
