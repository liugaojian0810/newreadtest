//
//  NSString+RichString.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (RichString)

- (NSMutableAttributedString *)stringwith: (UIColor *)color whith:(UIFont *)font with:(NSRange)range;//富文本
- (NSMutableAttributedString *)stringwith: (UIColor *)color whith:(UIFont *)font with:(NSRange)range defaultColor: (UIColor *) defaultColor defaultFont:(UIFont *)defaultFont;
/// 返回一个垂直居中对齐的富文本字符串
/// @param color 当前设置的文本颜色
/// @param font 当前设置的文本字号
/// @param range 当前设置的文本区间
/// @param defaultFont 整个文本的默认字号
/// @param attriutedSTR 带有富文本格式的文本
- (NSMutableAttributedString *)stringwith: (UIColor *)color whith:(UIFont *)font with:(NSRange)range defaultFont: (UIFont *)defaultFont attriutedStr:(NSMutableAttributedString *) attriutedSTR;

/// 返回与服务器时间差
/// @param fireStr 传入时间字符串
+(NSString *)getTimeStr:(NSString *)fireStr;

@end

NS_ASSUME_NONNULL_END
