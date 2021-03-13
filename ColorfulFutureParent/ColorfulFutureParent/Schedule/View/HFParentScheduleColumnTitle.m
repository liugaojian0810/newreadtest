//
//  HFParentScheduleColumnTitle.m
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFParentScheduleColumnTitle.h"
#import "HFSchedulModel.h"

@implementation HFParentScheduleColumnTitle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMsg:(HFSchedulDetailMessage *)msg{
    _msg = msg;
    if ([msg.week isEqualToString:@"1"]) {
        _week.text = @"周一";
    }else if ([msg.week isEqualToString:@"2"]){
        _week.text = @"周二";
    }else if ([msg.week isEqualToString:@"3"]){
        _week.text = @"周三";
    }else if ([msg.week isEqualToString:@"4"]){
        _week.text = @"周四";
    }else if ([msg.week isEqualToString:@"5"]){
        _week.text = @"周五";
    }else if ([msg.week isEqualToString:@"6"]){
        _week.text = @"周六";
    }else{
        _week.text = @"周日";
    }
    _dateLabel.text = [msg.date substringFromIndex:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
