//
//  UIButton+HFExpandClickArea.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/16.
//  Copyright © 2020 huifan. All rights reserved.
//  增加按钮点击范围

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark--------扩大按钮点击区域

@interface UIButton (HFExpandClickArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat) bottom left:(CGFloat)left;
 
- (void)setEnlargeEdge:(CGFloat)size;

//扩大按钮热区的比例系数(曲线救国)
@property (nonatomic, copy) NSString *clickArea;

@end

NS_ASSUME_NONNULL_END
