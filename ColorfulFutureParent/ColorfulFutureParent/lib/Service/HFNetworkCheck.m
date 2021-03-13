//
//  HFNetworkCheck.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFNetworkCheck.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

@implementation HFNetworkCheck

HFSingletonM(HFNetworkCheck)

-(void)startNetworkCheckWithStateBlock:(HFNetworkCheckBlock )state{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                self.available = YES;
                self.state = NetworkStateUnknown;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                self.available = NO;
                self.state = NetworkStateNotReachable;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                self.available = YES;
                self.state = NetworkStateWWAN;
            }
                break;
            default:
            {
                self.available = YES;
                self.state = NetworkStateWiFi;
            }
                break;
        }
        state(self.state);
    }];
    
    [manager startMonitoring];

}


@end
