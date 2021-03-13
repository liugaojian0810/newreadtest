//
//  MBProgressHUD+JC.m
//  JiecaoNews
//
//  Created by 森 on 15/2/12.
//  Copyright (c) 2015年 shannonchou. All rights reserved.
//

#import "MBProgressHUD+JC.h"
//#import <Reachability/Reachability.h>
@implementation MBProgressHUD (JC)

#pragma mark - CustomMessage

//+ (void)showNetworkError
//{
//    Reachability *reach = [Reachability reachabilityForInternetConnection];
//
//    if (reach.currentReachabilityStatus == NotReachable) {
//        [self showMessage:@"无网络连接"];
//    } else {
//        [self showMessage:@"网络不给力，粗不来啊"];
//    }
//}

#pragma mark - showHUD

+ (MBProgressHUD *)showHUD
{
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
//    [hud hide:true afterDelay:1.5];
    return hud;
}

#pragma mark - showMessage

+ (void)showMessage:(NSString *)text
{
    [self showMessage:text toView:nil];
}

+ (void)showMessage:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    [self showMessage:text toView:nil afterDelay:delay animated:YES];
}

+ (void)showMessage:(NSString *)text toView:(UIView *)view
{
    [self showMessage:text toView:view afterDelay:1.5];
}

+ (void)showMessage:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    [self showMessage:text toView:view afterDelay:delay animated:YES];
}

+ (void)showMessage:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay animated:(BOOL)animated
{
    [[self showHUDText:text toView:view] hide:animated afterDelay:delay];
}

+ (instancetype)showHUDText:(NSString *)text
{
    return [self showHUDText:text toView:nil];
}

+ (instancetype)showHUDText:(NSString *)text toView:(UIView *)view
{
    NSAssert([NSThread isMainThread], @"MBProgressHUD需要在主线程中调用.");
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    return hud;
}


#pragma mark - hideHUD

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
    {
        for (UIView *view1 in [UIApplication sharedApplication].windows) {
            [self hideHUDForView:view1 animated:YES];
        }
    }
    
    [self hideHUDForView:view animated:YES];
}

@end
