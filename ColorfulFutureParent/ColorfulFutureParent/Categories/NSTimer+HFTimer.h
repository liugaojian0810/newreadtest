//
//  NSTimer+HFTimer.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/29.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (HFTimer)
+ (instancetype)repeatWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
