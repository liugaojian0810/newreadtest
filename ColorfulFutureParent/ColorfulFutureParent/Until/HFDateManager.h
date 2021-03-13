//
//  HFDateManager.h
//  ColorfulFutureTeacher_iOS
//
//  Created by 李春展 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//  时间管理类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFDateManager : NSObject

+ (instancetype)shareManager;

/** 获得当前时间戳 */
- (NSString *)getCurrentTimeStamp;
@end

NS_ASSUME_NONNULL_END
