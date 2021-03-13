//
//  HFCountDown.h
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//  倒计时

/**
 应用举例：每隔一秒钟回调一次 返回剩余时间信息
 HFCountDown *countDown = [[HFCountDown alloc]initWithTimeString:@"1234567" countDownBlock:^(NSString * _Nonnull timeStr) {
     
 }];
 self.countDown = countDown;
 */

#import <Foundation/Foundation.h>
#import "HFBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^CountDownBlock)(NSString *timeStr);
typedef void(^CountDownBlockReturnSeconds)(NSUInteger timeStr);

@interface HFSystemTime : HFBaseModel  // 获取系统时间

@property(nonatomic, copy)NSString *date;//时间戳
@property(nonatomic, copy)NSString *dateString;//时间字符串
@property(nonatomic, copy)NSString *dateTime;//毫秒值

@end

typedef void(^CountDownSuccessBlock)(HFSystemTime *time);


@interface HFCountDown : NSObject

+ (instancetype)sharedHFCountDown;

/**
 根据时间戳创建倒计时对象
 */
+(instancetype)initWithTimeStampStr:(NSString *)timeStamp countDownBlock:(CountDownBlock)countdown;

/**
根据时间字符串创建倒计时对象
*/
+(instancetype)initWithTimeString:(NSString *)timeString countDownBlock:(CountDownBlock)countdown;

/**
根据时间字符串创建倒计时对象 回调显示服务器时间距离指定时间的秒数
*/
+(instancetype)GetTimeInteger:(NSString *)timeString countDownBlock:(CountDownBlockReturnSeconds)countdown;
/**
 根据时间戳创建倒计时对象
 */
-(instancetype)initWithTimeStampStr:(NSString *)timeStamp countDownBlock:(CountDownBlock)countdown;

/**
根据时间字符串创建倒计时对象
*/
-(instancetype)initWithTimeString:(NSString *)timeString countDownBlock:(CountDownBlock)countdown;


/**
 根据两个时间戳创建倒计时对象
 */
+(instancetype)initWithFirstTimeStampStr:(NSString *)first secondTimeStamp:(NSString *)second countDownBlock:(CountDownBlock)countdown;

/**
根据两个时间字符串创建倒计时对象
*/
+(instancetype)initWithFirstTimeStr:(NSString *)first secondTimeStr:(NSString *)second countDownBlock:(CountDownBlock)countdown;


/**
 根据两个时间戳创建倒计时对象
 */
-(instancetype)initWithFirstTimeStampStr:(NSString *)first secondTimeStamp:(NSString *)second countDownBlock:(CountDownBlock)countdown;

/**
根据两个时间字符串创建倒计时对象
*/
-(instancetype)initWithFirstTimeStr:(NSString *)first secondTimeStr:(NSString *)second countDownBlock:(CountDownBlock)countdown;


/**
 时间变化回调 返回剩余时间：时：分：秒
 */
@property(nonatomic, copy)CountDownBlock countDownBlock;
@property(nonatomic, copy)CountDownBlockReturnSeconds countDownBlockReturnSeconds;

/**
 获取系统时间
 */
-(void)getSystemTimeWithBlock:(CountDownSuccessBlock)block;
+(void)getSystemTimeWithBlock:(CountDownSuccessBlock)block;

-(NSDate *)getServerTime;
+(NSDate *)getServerTime;

-(NSString *)getServerTimeStr: (NSString *) timeFormate;
+(NSString *)getServerTimeStr: (NSString *) timeFormate;

/// 返回时间差（HH:mm）
/// @param nowDateStr 当前时间
/// @param deadlineStr 稍后时间
+(NSInteger)getDateDifferenceHHmmWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;

@end

NS_ASSUME_NONNULL_END
