//
//  NSTimer+HFTimer.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/29.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "NSTimer+HFTimer.h"

@implementation NSTimer (HFTimer)
+ (instancetype)repeatWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *timer))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(trigger:) userInfo:[block copy] repeats:YES];
    return timer;
}

+ (void)trigger:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = [timer userInfo];
    if (block) {
        block(timer);
    }
}
@end
