//
//  HFOrderDetailModel.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/29.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFOrderDetailModel.h"

@implementation HFOrderDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"identifier":@"id"};
}
@end
