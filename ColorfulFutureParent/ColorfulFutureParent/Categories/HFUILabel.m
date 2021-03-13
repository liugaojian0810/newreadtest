//
//  HFUILabel.m
//  ColorfulFutureParent
//
//  Created by huifan on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFUILabel.h"

@implementation HFUILabel

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

@end
