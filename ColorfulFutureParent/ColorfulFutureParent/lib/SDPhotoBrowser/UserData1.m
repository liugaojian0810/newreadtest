//
//  UserData.m
//  PhotoDemoSSS
//
//  Created by sks on 16/9/28.
//  Copyright © 2016年 ALiBaiChuan. All rights reserved.
//

#import "UserData1.h"

@implementation UserData1

+ (UserData1 *)userDataStandard
{
    static UserData1 *userData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userData = [[UserData1 alloc] init];
        
    });
    
    return userData;
}

@end
