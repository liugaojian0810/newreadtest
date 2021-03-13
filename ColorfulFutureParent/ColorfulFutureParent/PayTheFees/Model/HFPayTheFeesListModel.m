//
//  HFPayTheFeesListModel.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPayTheFeesListModel.h"

@implementation HFPayTheFeesListModel
+(NSDictionary *)mj_objectClassInArray {
    return @{@"projects":[ProjectsListModel class]};
}
@end

@implementation ProjectsListModel

+(NSDictionary *)mj_objectClassInArray {
    return @{@"payTypeList":[PayTypeListModel class]};
}

@end

@implementation PayTypeListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"identifier":@"id"};
}

@end
