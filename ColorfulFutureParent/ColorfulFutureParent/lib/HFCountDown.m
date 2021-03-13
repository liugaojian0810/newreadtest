//
//  HFCountDown.m
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFCountDown.h"
#import "NSDate+HFDateConversion.h"


@implementation HFSystemTime

@end

@interface HFCountDown ()

@property (nonatomic, copy)NSString *timeString;
@property (nonatomic, copy)NSString *timeStamp;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, copy)NSString *firstTimeStamp;
@property (nonatomic, copy)NSString *secondTimeStamp;
@property (nonatomic, copy)NSString *firstTimeStr;
@property (nonatomic, copy)NSString *secondTimeStr;
@property (nonatomic, strong)NSDateComponents *dateCom;//时间差值
@property (nonatomic, assign)NSInteger timeDifference;//时间差值
@property (nonatomic, assign)NSInteger timeServerAndCurrent;// 服务器时间与本地时间的差值
@end

@implementation HFCountDown


static id _instace;

+ (instancetype)sharedHFCountDown {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    _instace = [[self alloc] init];
    });
    return _instace;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    _instace = [super allocWithZone:zone];
});
return _instace;
}

- (id)copyWithZone:(NSZone *)zone 
{
return _instace;
}

/**
 根据时间戳创建倒计时对象
 */
+(instancetype)initWithTimeStampStr:(NSString *)timeStamp countDownBlock:(CountDownBlock)countdown{
    return [[HFCountDown alloc]initWithTimeStampStr:timeStamp countDownBlock:countdown];
}

/**
 根据时间字符串创建倒计时对象
 */
+(instancetype)initWithTimeString:(NSString *)timeString countDownBlock:(CountDownBlock)countdown{
    return [[HFCountDown alloc]initWithTimeString:timeString countDownBlock:countdown];
}

/**
根据时间字符串创建倒计时对象 回调显示服务器时间距离指定时间的秒数
*/
+(instancetype)GetTimeInteger:(NSString *)timeString countDownBlock:(CountDownBlockReturnSeconds)countdown{
    return [[HFCountDown alloc]initWithTimeStringReturnSeconds:timeString countDownBlock:countdown];
}


/**
 根据时间戳创建倒计时对象
 */
-(instancetype)initWithTimeStampStr:(NSString *)timeStamp countDownBlock:(CountDownBlock)countdown{
    if (self == [super init]) {
        self.timeStamp = timeStamp;
        self.countDownBlock = countdown;
        
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
        dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        // 当前时间字符串格式
        NSString *firstStr = [dateFomatter stringFromDate:nowDate];
        NSString *secondStr = [NSDate timeStringFromTimestamp:[self.timeStamp integerValue] formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSInteger diff = [self getDateDifferenceWithNowDateStr:firstStr deadlineStr:secondStr];
        self.timeDifference = diff;
        [self detimer];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

/**
 根据时间字符串创建倒计时对象
 */
-(instancetype)initWithTimeString:(NSString *)timeString countDownBlock:(CountDownBlock)countdown{
    if (self == [super init]) {
        self.timeString = timeString;
        self.countDownBlock = countdown;
        NSDate *nowDate = [self getServerTime];
        NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
        dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        // 当前时间字符串格式
        NSString *firstStr = [dateFomatter stringFromDate:nowDate];
        NSInteger diff = [self getDateDifferenceWithNowDateStr:firstStr deadlineStr:self.timeString];
        self.timeDifference = diff;
        [self detimer];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(instancetype)initWithTimeStringReturnSeconds:(NSString *)timeString countDownBlock:(CountDownBlockReturnSeconds)countdown{
    if (self == [super init]) {
        self.timeString = timeString;
        self.countDownBlockReturnSeconds = countdown;
        
        NSDate *nowDate = [self getServerTime];
        NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
        dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        // 当前时间字符串格式
        NSString *firstStr = [dateFomatter stringFromDate:nowDate];
        NSInteger diff = [self getDateDifferenceWithNowDateStr:firstStr deadlineStr:self.timeString];
        self.timeDifference = diff;
        if (self.countDownBlockReturnSeconds) {
            self.countDownBlockReturnSeconds(diff);
        }
        [self detimer];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChangeBackSeconds) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)detimer{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


/**
 根据两个时间戳创建倒计时对象
 */
+(instancetype)initWithFirstTimeStampStr:(NSString *)first secondTimeStamp:(NSString *)second countDownBlock:(CountDownBlock)countdown{
    return [[HFCountDown alloc]initWithFirstTimeStampStr:first secondTimeStamp:second countDownBlock:countdown];
}

/**
 根据两个时间字符串创建倒计时对象
 */
+(instancetype)initWithFirstTimeStr:(NSString *)first secondTimeStr:(NSString *)second countDownBlock:(CountDownBlock)countdown{
    return [[HFCountDown alloc]initWithFirstTimeStr:first secondTimeStr:second countDownBlock:countdown];
}


/**
 根据两个时间戳创建倒计时对象
 */
-(instancetype)initWithFirstTimeStampStr:(NSString *)first secondTimeStamp:(NSString *)second countDownBlock:(CountDownBlock)countdown{
    if (self == [super init]) {
        self.firstTimeStamp = first;
        self.secondTimeStamp = second;
        self.countDownBlock = countdown;
        NSString *firstStr = [NSDate timeStringFromTimestamp:[self.firstTimeStamp integerValue] formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSString *secondStr = [NSDate timeStringFromTimestamp:[self.secondTimeStamp integerValue] formatter:@"yyyy-MM-dd HH:mm:ss"];
        NSInteger diff = [self getDateDifferenceWithNowDateStr:firstStr deadlineStr:secondStr];
        self.timeDifference = diff;
        [self detimer];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

/**
 根据两个时间字符串创建倒计时对象
 */
-(instancetype)initWithFirstTimeStr:(NSString *)first secondTimeStr:(NSString *)second countDownBlock:(CountDownBlock)countdown{
    if (self == [super init]) {
        self.firstTimeStr = first;
        self.secondTimeStr = second;
        self.countDownBlock = countdown;
        NSInteger diff = [self getDateDifferenceWithNowDateStr:self.firstTimeStr deadlineStr:self.secondTimeStr];
        self.timeDifference = diff;
        [self detimer];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

/**
*  获取时间差值  截止时间-当前时间
*  nowDateStr : 当前时间
*  deadlineStr : 截止时间
*  @return 时间戳差值
*/
- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    NSInteger timeDifference = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    return timeDifference;
}

/**
*  获取时间差值  截止时间-当前时间
*  nowDateStr : 当前时间
*  deadlineStr : 截止时间
*  @return 时间戳差值
*/
+ (NSInteger)getDateDifferenceHHmmWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    NSInteger timeDifference = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    return timeDifference;
}

/**
 时间改变
 */
-(void)timeChange{
    _timeDifference--;
    //时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", _timeDifference / 3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (_timeDifference % 3600) / 60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", _timeDifference % 60];
    NSString *format_time = [NSString stringWithFormat:@"%@ : %@ : %@", str_hour, str_minute, str_second];
    // 修改倒计时标签及显示内容
    NSString *time = [NSString stringWithFormat:@"倒计时: %@", format_time];
    // 当倒计时结束时做需要的操作: 比如活动到期不能提交
    if(_timeDifference <= 0) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    if (self.countDownBlock) {
        self.countDownBlock(time);
    }
}

/**
 时间改变
 */
-(void)timeChangeBackSeconds{
    _timeDifference--;
    // 当倒计时结束时做需要的操作: 比如活动到期不能提交
    if(_timeDifference <= 0) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    if (self.countDownBlockReturnSeconds) {
        self.countDownBlockReturnSeconds(_timeDifference);
    }
}

/**
 获取系统时间
 */
-(void)getSystemTimeWithBlock:(CountDownSuccessBlock)block{
    
    NSDictionary *paremeters = [NSMutableDictionary dictionary];
    [Service getWithUrl:GetSystemTimeAPI params:paremeters success:^(NSDictionary *responseObject) {
        HFSystemTime *time = [HFSystemTime mj_objectWithKeyValues:responseObject];
        block(time);
    } failure:^(HFError *error) {
        
    }];
}
+(void)getSystemTimeWithBlock:(CountDownSuccessBlock)block{
    
    [Service postWithUrl:GetSystemTimeAPI params:nil success:^(NSDictionary *responseObject) {
        HFSystemTime *time = [HFSystemTime mj_objectWithKeyValues:responseObject[@"model"]];
        block(time);
        HFLog(@"time.dateTime:%@",time.dateTime);
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
        NSTimeInterval timeInterval = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
        HFLog(@"timeInterval: %f", timeInterval);
        NSTimeInterval result = [time.dateTime integerValue] - timeInterval;
        [HFCountDown sharedHFCountDown].timeServerAndCurrent = result;
    } failure:^(HFError *error) {
        HFLog(@"error:%@",error);
    }];
}

-(NSDate *)getServerTime {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval timeInterval = [date timeIntervalSince1970]*1000 + [HFCountDown sharedHFCountDown].timeServerAndCurrent;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    
    NSDate *UTCDate = [NSDate dateWithTimeIntervalSince1970: timeInterval / 1000];
    return UTCDate;
}

+(NSDate *)getServerTime {
   return [[HFCountDown sharedHFCountDown] getServerTime];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
//    NSTimeInterval timeInterval = [date timeIntervalSince1970]*1000 + [HFCountDown sharedHFCountDown].timeServerAndCurrent];// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
//    return [[NSDate date] dateByAddingTimeInterval: ;
}

-(NSString *)getServerTimeStr: (NSString *) timeFormate {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval timeInterval = [date timeIntervalSince1970]*1000 + [HFCountDown sharedHFCountDown].timeServerAndCurrent;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSDate *Date = [NSDate dateWithTimeIntervalSince1970: (timeInterval)/1000];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = timeFormate;
    return [format stringFromDate: Date];
}
+(NSString *)getServerTimeStr: (NSString *) timeFormate {
    return [[HFCountDown sharedHFCountDown] getServerTimeStr: timeFormate];
}
@end
