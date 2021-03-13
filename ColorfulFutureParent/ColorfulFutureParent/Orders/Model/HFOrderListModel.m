//
//  HFOrderListModel.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFOrderListModel.h"

@implementation HFOrderListModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":[HFOrderList class]};
}


@end

@implementation HFOrderList

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"identifier":@"id",
             @"ownerID":@"ownerId",
             @"userID":@"userId",
             @"goodsThumbnailURL":@"goodsThumbnailUrl"};
}

@end
@implementation HFParams

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"childID":@"childId",
             @"userID":@"userId"};
}

@end
