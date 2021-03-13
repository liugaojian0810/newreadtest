//
//  GCDSemaphore.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDSemaphore : NSObject

@property (strong, readonly, nonatomic) dispatch_semaphore_t dispatchSemaphore;

#pragma 初始化
- (instancetype)init;
- (instancetype)initWithValue:(long)value;

#pragma mark - 用法
- (BOOL)signal;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end

NS_ASSUME_NONNULL_END
