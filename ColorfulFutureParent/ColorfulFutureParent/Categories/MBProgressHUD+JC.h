//
//  MBProgressHUD+JC.h
//  JiecaoNews
//
//  Created by 森 on 15/2/12.
//  Copyright (c) 2015年 shannonchou. All rights reserved.
//

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
@interface MBProgressHUD (JC)

/**
 *  显示网络请求失败
 */
//+ (void)showNetworkError;

/**
 *  显示加载，手动隐藏
 */
+ (MBProgressHUD *)showHUD;
/**
 *  显示消息，自动隐藏
 *
 *  @param text     消息文字
 *  @param view     消息所在视图，为nil时自动使用当前视图
 *  @param delay    消息隐藏延迟
 *  @param animated 启用隐藏动画
 */
+ (void)showMessage:(NSString *)text;
+ (void)showMessage:(NSString *)text afterDelay:(NSTimeInterval)delay;
+ (void)showMessage:(NSString *)text toView:(UIView *)view;
+ (void)showMessage:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay;
+ (void)showMessage:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay animated:(BOOL)animated;

/**
 *  显示文字消息并返回实例，需手动隐藏
 *  @param text 消息文字
 *  @param view 消息所在视图，为nil时自动使用当前视图
 *  @return MBProgressHUD
 */
+ (instancetype)showHUDText:(NSString *)text;
+ (instancetype)showHUDText:(NSString *)text toView:(UIView *)view;
/**
 *  手动隐藏消息
 *  @param view 消息所在视图，为nil时清除所有消息
 */
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
