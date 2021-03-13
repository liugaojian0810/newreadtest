//
//  NSMutableAttributedString+HFAttributedString.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "NSMutableAttributedString+HFAttributedString.h"

@implementation NSMutableAttributedString (HFAttributedString)
- (NSMutableAttributedString *)attributedStringwith:(UIColor *)color whith:(UIFont *)font with:(NSRange)range {
    NSMutableAttributedString *attriutedStr = [self mutableCopy];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color != nil) {
        [dic addEntriesFromDictionary:@{NSForegroundColorAttributeName: color }];
    }
    if (font != nil) {
        [dic addEntriesFromDictionary:@{NSFontAttributeName: font }];
    }
    [attriutedStr addAttributes:dic range:range];
    return attriutedStr;
}

@end
