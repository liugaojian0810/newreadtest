//
//  UIView+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBackGrayAlpha 0.4
@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


- (BOOL)findAndResignFirstResponder;
- (UIViewController *)viewController;
- (void)removeAllSubviews;

/// view切圆角
/// @param corners 各个角
/// @param cornerRadius 角大小
- (void)setCorner:(UIRectCorner)corners withRadius:(CGFloat)cornerRadius;

// 设置view四周圆角
- (void)setCornerRadius:(CGFloat)radius;
- (instancetype)createFromNibFile;
- (void)grayMaskMe;
- (void)showInfo:(NSString *)infoString;
+ (void)setViewStyle:(UIView *)view;
- (void)cornerSelfHeight;
/**
 *  @brief  震动动画
 */
-(void)ShakeView;

/// path画阴影，
/// @param row 阴影范围
- (void)shadowColorWith:(NSInteger)row;


@end
