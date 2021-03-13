//
//  ServiceFactory.h
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//  服务器工厂模式

#import <Foundation/Foundation.h>
#import "ServiceConfig.h"
#import "BaseService.h"

@interface ServiceFactory : NSObject

+ (instancetype)sharedInstance;

+ (NSURL *)baseURL;

/** 获取当前的BaseAPI */
+ (NSString *)getCurrentBaseAPI;

/** 获取当前的环境类型 */
+ (EnvironmentType)getEnvironmentType;

/** 切换环境 */
+ (void)changeEnvironmentType:(EnvironmentType)environmentType;

- (BaseService<BaseServiceProtocol> *)serviceWithType:(ServerType)serverType;

@end
