//
//  HFShareView.m
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/2.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFShareView.h"

@implementation HFShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bottomBgv.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.bottomBgv.layer.mask = layer;

}
- (IBAction)btn:(id)sender {
    [self removeFromSuperview];
    UIButton * btn = sender;
    self.shareClickBlock(btn.tag);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.cancelClickBlock();
    [self removeFromSuperview];
}
@end
