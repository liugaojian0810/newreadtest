//
//  HFDateManager.m
//  ColorfulFutureTeacher_iOS
//
//  Created by 李春展 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFDateManager.h"

@implementation HFDateManager

+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    static HFDateManager *manager;

    dispatch_once(&onceToken, ^{
        manager = [[HFDateManager alloc] init];
    });
    return manager;
}

- (NSString *)getCurrentTimeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
       NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
       NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
       return timeString;
}
@end
