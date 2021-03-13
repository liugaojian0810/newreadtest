//
//  GCDTimer.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDQueue;

NS_ASSUME_NONNULL_BEGIN

@interface GCDTimer : NSObject

@property (strong, readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化
- (instancetype)init;
- (instancetype)initInQueue:(GCDQueue *)queue;

#pragma mark - 用法
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
- (void)start;
- (void)destroy;

@end
NS_ASSUME_NONNULL_END
