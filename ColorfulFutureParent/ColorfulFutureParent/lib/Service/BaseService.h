//
//  BaseService.h
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//

#import <Foundation/Foundation.h>

/** 开发环境、生产环境和自定义环境(环境的切换是给开发人员和测试人员用的，对于外部正式打包不应该有环境切换的存在)*/
typedef NS_ENUM(NSUInteger, EnvironmentType) {
    EnvironmentTypeDevelop,     // 开发测试环境
    EnvironmentTypeRelease,     // 生产发布环境
    EnvironmentTypeHotfix,      // 其他自定义环境
};

@protocol BaseServiceProtocol <NSObject>

/**
 *  开发、测试等环境的baseUrl在子类中实现，获取对应的URL赋值给apiBaseUrl，自定义在基类中进行保存获取
 */
@property (nonatomic, copy, readonly) NSString *developApiBaseUrl;

@property (nonatomic, copy, readonly) NSString *releaseApiBaseUrl;

@end

@interface BaseService : NSObject

@property (nonatomic, assign) EnvironmentType environmentType;

@property (nonatomic, copy, readonly) NSString *publicKey;

@property (nonatomic, copy, readonly) NSString *privateKey;

@property (nonatomic, copy, readonly) NSString *apiBaseUrl;

@property (nonatomic, copy) NSString *customApiBaseUrl;

@end
