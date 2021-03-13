//
//  HFError.m
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFError.h"

@implementation HFError

+ (instancetype)errorWithCode:(NSString *)errorCode errorMessage:(NSString *)errorMessage{
    HFError *error = [[HFError alloc]init];
    error.errorCode = errorCode;
    error.errorMessage = errorMessage;
    if (!error.errorMessage) {
        error.errorMessage = @"请求数据错误，请重试";
    }
    return error;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"errorCode:%@,errorMessage:%@", self.errorCode,self.errorMessage];
}
@end
