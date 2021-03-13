//
//  MainService.m
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//  

#import "MainService.h"
#import "ServiceAPI.h"

@implementation MainService
@synthesize developApiBaseUrl = _developApiBaseUrl, releaseApiBaseUrl = _releaseApiBaseUrl;

/** 开发环境 */
- (NSString *)developApiBaseUrl {
    if (_developApiBaseUrl == nil) {
        _developApiBaseUrl = DevelopBaseAPI;
    }
    return _developApiBaseUrl;
}

/** 生产环境 */
- (NSString *)releaseApiBaseUrl {
    if (_releaseApiBaseUrl == nil) {
        _releaseApiBaseUrl = ReleaseBaseAPI;
    }
    return _releaseApiBaseUrl;
}

@end
