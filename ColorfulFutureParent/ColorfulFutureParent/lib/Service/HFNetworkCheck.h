//
//  HFNetworkCheck.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    NetworkStateUnknown,
    NetworkStateWWAN,
    NetworkStateWiFi,
    NetworkStateNotReachable,
} NetworkState;

typedef void(^HFNetworkCheckBlock)(NetworkState state);

@interface HFNetworkCheck : NSObject

HFSingletonH(HFNetworkCheck)

-(void)startNetworkCheckWithStateBlock:(HFNetworkCheckBlock )stateBlock;

@property(nonatomic, assign)BOOL available;

@property(nonatomic, assign)NetworkState state;


@end

NS_ASSUME_NONNULL_END
