//
//  HFParentScheduleItemOrigin.m
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFParentScheduleItemOrigin.h"

@implementation HFParentScheduleItemOrigin

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.frame = CGRectMake(0, 0, 55, 60);
}

-(void)setMonthStr:(NSString *)monthStr{
    _monthStr = monthStr;
    self.datePeriod.text = monthStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
