//
//  HFUserManager.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFUserManager.h"
@implementation HFUserManager

HFSingletonM(HFUserManager)

- (void)userLoginWithInfo:(NSDictionary *)info
                onFinised:(LoginFinishedBlock)finished{
    //登录成功以后
//    HFUser *user = [[HFUser alloc] initWithDicionary:response];
//    [self saveUserInfo:user];
//    finished (YES, nil);
//    finished (NO, nil);
   
}

- (void)userRegisterWithInfo:(NSDictionary *)info
                  onFinished:(RegistFinishedBlock)finished{
    
}

- (void)saveUserInfo:(HFUserInfo *)user {
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSString *path = [self getDataFilePath];
    BOOL isWriteSuccess = [userData writeToFile:path atomically:YES];
    if (isWriteSuccess) {
        HFLog(@"write success");
    } else {
        HFLog(@"write failure");
    }
}


- (HFUserInfo *)getUserInfo{
    NSString *path = [self getDataFilePath];
    NSData *userData = [[NSData alloc] initWithContentsOfFile:path];
    if (!userData) {
        return nil;
    }
    HFUserInfo *user = (HFUserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return user;
}
+(HFUserInfo *)getUserInfo{
    NSString *path = [[HFUserManager sharedHFUserManager] getDataFilePath];
    NSData *userData = [[NSData alloc] initWithContentsOfFile:path];
    if (!userData) {
        return nil;
    }
    HFUserInfo *user = (HFUserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return user;
}

- (void)removeUserInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserToken];
    NSString *path = [self getDataFilePath];
    [self deleteFileWithName:path];
}

- (void)deleteFileWithName:(NSString *)pathName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self getDataFilePath];
    BOOL deleteSuccess = [fileManager removeItemAtPath:path error:nil];
    if (deleteSuccess) {
        HFLog(@"delete  success");
    } else {
        HFLog(@"delete failure");
    }
}


-(NSString *)getDataFilePath{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"HFUserInfo.plist"];
    return path;
}

-(BOOL)isLogin{
    
    HFUserInfo *user = [self getUserInfo];
    if ( user.token.length  > 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isLogin{
    return [HFUserManager sharedHFUserManager].isLogin;
}


- (void)goLogin{
//    HFLoginViewController *login = [[HFLoginViewController alloc]init];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = login;
}

- (void)logOut{
    [self removeUserInfo];
    [self goLogin];
}

@end
