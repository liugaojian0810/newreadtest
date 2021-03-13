//
//  HFGetMulticoloredGemstoneInfoModel.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFGetMulticoloredGemstoneInfoModel.h"

@implementation HFGetMulticoloredGemstoneInfoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"dateGemstoneList":[HFDateGemstoneList class]};
}
@end

@implementation HFDateGemstoneList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"recordList":[HFRecordList class]};
}

@end

@implementation HFRecordList


@end
