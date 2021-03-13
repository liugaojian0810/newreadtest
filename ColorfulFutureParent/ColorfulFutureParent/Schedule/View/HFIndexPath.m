//
//  HFIndexPath.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFIndexPath.h"


@interface HFIndexPath ()
@property (nonatomic, assign, readwrite) NSInteger section;
@property (nonatomic, assign, readwrite) NSInteger row;
@property (nonatomic, assign, readwrite) NSInteger item;
@end

@implementation HFIndexPath

+ (instancetype)indexPathForItem:(NSInteger)item row:(NSInteger)row section:(NSInteger)section{
    HFIndexPath *index = [[HFIndexPath alloc] init];
    index.section = section;
    index.row = row;
    index.item = item;
    return index;
}
+(instancetype)indexPathForItem:(NSInteger)item section:(NSInteger)section{
    HFIndexPath *index = [[HFIndexPath alloc] init];
    index.section = section;
    index.item = item;
    return index;
}

@end
