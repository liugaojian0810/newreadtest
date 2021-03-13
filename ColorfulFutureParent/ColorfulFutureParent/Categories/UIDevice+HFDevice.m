//
//  UIDevice+HFDevice.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UIDevice+HFDevice.h"
#import "AppDelegate.h"

@implementation UIDevice (HFDevice)
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt: interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

+(void)setHScreen {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 允许转成横屏
    appDelegate.allowRotation = YES;
    // 调用横屏代码
    [UIDevice switchNewOrientation: UIInterfaceOrientationLandscapeRight];
}

+ (void)setVScreen {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 允许转成横屏
    appDelegate.allowRotation = NO;
    // 调用横屏代码
    [UIDevice switchNewOrientation: UIInterfaceOrientationPortrait];
}
@end
