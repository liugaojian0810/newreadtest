//
//  UILabel+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
- (void)adjust;
- (CGSize)boundingRectWithSize:(CGSize)size;

/**
 *  设置字间距
 */
- (void)setColumnSpace:(CGFloat)columnSpace;
/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace;
@end
