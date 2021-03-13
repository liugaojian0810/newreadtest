//
//  HFUserInfo.m
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/25.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFUserInfo.h"

@implementation HFBabyInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"babyID":@"id",
        @"babyName":@"name",
        @"babyPhoto":@"photo",
        @"familyDocId":@"familyDocId",
        @"sex":@"sex"

    };
}

@end

@implementation HFUserInfo

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.userLevel forKey:@"userLevel"];
    [encoder encodeObject:self.babyInfo forKey:@"babyInfo"];

}

#pragma mark 从文件中读取
-(id)initWithCoder:(NSCoder *)decoder{
    self.userId = [decoder decodeObjectForKey:@"userId"];
    self.token = [decoder decodeObjectForKey:@"token"];
    self.username = [decoder decodeObjectForKey:@"username"];
    self.phone = [decoder decodeObjectForKey:@"phone"];
    self.name = [decoder decodeObjectForKey:@"name"];
    self.userLevel = [decoder decodeObjectForKey:@"userLevel"];
    self.babyInfo = [decoder decodeObjectForKey:@"babyInfo"];

    return self;
}
@end
