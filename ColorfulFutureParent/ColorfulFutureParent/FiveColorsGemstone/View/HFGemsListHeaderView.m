//
//  HFGemsListHeaderView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFGemsListHeaderView.h"
#import <JKCategories/JKCategories.h>
@implementation HFGemsListHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.backView jk_shadowWithColor:[UIColor blackColor] offset:CGSizeMake(0, 2) opacity:0.1 radius:7];
}


@end
