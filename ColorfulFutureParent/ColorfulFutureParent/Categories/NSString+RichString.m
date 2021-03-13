//
//  NSString+RichString.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "NSString+RichString.h"

@implementation NSString (RichString)

#pragma mark富文本
- (NSMutableAttributedString *)stringwith:(UIColor *)color whith:(UIFont *)font with:(NSRange)range {
    NSMutableAttributedString *attriutedStr = [[NSMutableAttributedString alloc]initWithString:self];
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

-(NSMutableAttributedString *)stringwith:(UIColor *)color whith:(UIFont *)font with:(NSRange)range defaultColor:(UIColor *)defaultColor defaultFont:(UIFont *)defaultFont{
    NSMutableAttributedString *attriutedStr = [self stringwith: defaultColor whith: defaultFont with: NSMakeRange(0, self.length)];
    attriutedStr = [self attributedStringwith:color whith:font with:range attriutedStr:attriutedStr];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:@{NSBaselineOffsetAttributeName:@((defaultFont.lineHeight - font.lineHeight)/2 + ((defaultFont.descender - font.descender)))}];
    [attriutedStr addAttributes:dic range: range];
    return attriutedStr;
}

- (NSMutableAttributedString *)attributedStringwith:(UIColor *)color whith:(UIFont *)font with:(NSRange)range attriutedStr:(NSMutableAttributedString *) attriutedSTR {
    NSMutableAttributedString *attriutedStr = [attriutedSTR mutableCopy];
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

-(NSMutableAttributedString *)stringwith:(UIColor *)color whith:(UIFont *)font with:(NSRange)range defaultFont:(UIFont *)defaultFont attriutedStr:(NSMutableAttributedString *)attriutedSTR {
    NSMutableAttributedString *attriutedStr = [attriutedSTR mutableCopy];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color != nil) {
        [dic addEntriesFromDictionary:@{NSForegroundColorAttributeName: color }];
    }
    if (font != nil) {
        [dic addEntriesFromDictionary:@{NSFontAttributeName: font }];
    }
    [dic addEntriesFromDictionary:@{NSBaselineOffsetAttributeName:@((defaultFont.lineHeight - font.lineHeight)/2 + ((defaultFont.descender - font.descender)))}];
    [attriutedStr addAttributes:dic range:range];
    return attriutedStr;
}

//返回倒计时
+(NSString *)getTimeStr:(NSString *)fireStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* fireDate = [formater dateFromString:fireStr];
    NSDate *today = [HFCountDown getServerTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    long hour = [d day] *24 + [d hour];
    NSString *seconds;
    NSString *minutes;
    NSString *hours;
    if([d second]<10)
        seconds = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    else
        seconds = [NSString stringWithFormat:@"%ld",(long)[d second]];
    if([d minute]<10)
        minutes = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    else
        minutes = [NSString stringWithFormat:@"%ld",(long)[d minute]];
    if(hour < 10)
        hours = [NSString stringWithFormat:@"0%ld", hour];
    else
        hours = [NSString stringWithFormat:@"%ld",hour];
    return [NSString stringWithFormat:@"%@:%@:%@", hours, minutes,seconds];
}


@end
