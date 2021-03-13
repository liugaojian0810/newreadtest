//
//  ServiceFactory.m
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//

#import "ServiceFactory.h"
#import "MainService.h"

@interface ServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation ServiceFactory

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
+ (NSURL *)baseURL {
    return [NSURL URLWithString:[ServiceFactory getCurrentBaseAPI]];
}

+ (NSString *)getCurrentBaseAPI {
    return [[ServiceFactory sharedInstance] serviceWithType:ServerTypeMain].apiBaseUrl;
}

+ (EnvironmentType)getEnvironmentType {
    return [[ServiceFactory sharedInstance] serviceWithType:ServerTypeMain].environmentType;
}

+ (void)changeEnvironmentType:(EnvironmentType)environmentType {
    ServiceFactory *factory = [self sharedInstance];
    [factory.serviceStorage.allValues enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseService *service = obj;
        service.environmentType = environmentType;
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:environmentType] forKey:@"environmentType"];
}

- (BaseService<BaseServiceProtocol> *)serviceWithType:(ServerType)serverType {
    if (self.serviceStorage[@(serverType)] == nil) {
        self.serviceStorage[@(serverType)] = [self newServiceWithType:serverType];
    }
    return self.serviceStorage[@(serverType)];
}

#pragma mark - private methods
- (BaseService<BaseServiceProtocol> *)newServiceWithType:(ServerType)type {
    BaseService<BaseServiceProtocol> *service = nil;
    switch (type) {
        case ServerTypeMain:
            service = [[MainService alloc] init];
            break;
        default:
            break;
    }
    return service;
}

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage {
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

@end
