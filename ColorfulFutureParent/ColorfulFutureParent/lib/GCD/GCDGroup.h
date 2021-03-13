//
//  GCDGroup.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDGroup : NSObject

@property (strong, nonatomic, readonly) dispatch_group_t dispatchGroup;

#pragma 初始化
- (instancetype)init;

#pragma mark - 用法
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end

NS_ASSUME_NONNULL_END
