//
//  BaseService.m
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.


#import "BaseService.h"

@interface BaseService ()

@property (nonatomic, weak) id<BaseServiceProtocol> child;


@end

@implementation BaseService
@synthesize privateKey = _privateKey, apiBaseUrl = _apiBaseUrl;

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(BaseServiceProtocol)]) {
            self.child = (id<BaseServiceProtocol>)self;
            // 手动切换环境后会把环境类型保存起来
            NSNumber *type = [[NSUserDefaults standardUserDefaults] objectForKey:@"environmentType"];
            if (type) {
                // 有设置：优先读取手动切换环境设置
                self.environmentType = (EnvironmentType)[type integerValue];
                
//                self.environmentType = EnvironmentTypeDevelop;
                
            } else {
                // 无设置：默认是生产线上环境
//                self.environmentType = EnvironmentTypeRelease;
                // 无设置：默认根据编译环境来决定域名
                #ifdef DEBUG
                                self.environmentType = EnvironmentTypeDevelop;
                #else
                                self.environmentType = EnvironmentTypeRelease;
                #endif
            }
        } else {
            NSAssert(NO, @"子类没有实现协议");
        }
    }
    return self;
}

#pragma mark - getters and setters
- (void)setEnvironmentType:(EnvironmentType)environmentType {
    if (environmentType == EnvironmentTypeHotfix) {
        [[NSUserDefaults standardUserDefaults] setObject:self.customApiBaseUrl forKey:NSStringFromClass([self class])];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromClass([self class])];
    }
    _environmentType = environmentType;
    _apiBaseUrl = nil;
}

- (NSString *)privateKey {
    if (!_privateKey) {
        _privateKey = @"abcdefghijklmn";
    }
    return _privateKey;
}

- (NSString *)apiBaseUrl {
    if (_apiBaseUrl == nil) {
        switch (self.environmentType) {
            case EnvironmentTypeDevelop:
                _apiBaseUrl = self.child.developApiBaseUrl;
                break;
            case EnvironmentTypeRelease:
                _apiBaseUrl = self.child.releaseApiBaseUrl;
                break;
            case EnvironmentTypeHotfix:
                _apiBaseUrl = self.customApiBaseUrl;
                break;
            default:
                break;
        }
    }
    return _apiBaseUrl;
}

- (NSString *)customApiBaseUrl {
    if (!_customApiBaseUrl) {
        _customApiBaseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
    }
    return _customApiBaseUrl;
}

@end
