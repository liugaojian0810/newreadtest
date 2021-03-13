//
//  HFUserManager.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginFinishedBlock) (BOOL isSuccess, NSString *errorMsg);

typedef void(^RegistFinishedBlock)(BOOL isSuccess, NSString *errorMsg);

@interface HFUserManager : NSObject

HFSingletonH(HFUserManager)

@property (nonatomic, assign, readonly) BOOL isLogin;

@property (nonatomic, copy) LoginFinishedBlock loginBlock;

@property (nonatomic, copy) RegistFinishedBlock registBlock;

- (void)saveUserInfo:(HFUserInfo *)user;

- (HFUserInfo *)getUserInfo;
+ (HFUserInfo *)getUserInfo;
- (void)logOut;

- (void)removeUserInfo;

- (void)userLoginWithInfo:(NSDictionary *)info
                onFinised:(LoginFinishedBlock)finished;

- (void)userRegisterWithInfo:(NSDictionary *)info
                  onFinished:(RegistFinishedBlock)finished;

- (void)goLogin;

@end

NS_ASSUME_NONNULL_END
