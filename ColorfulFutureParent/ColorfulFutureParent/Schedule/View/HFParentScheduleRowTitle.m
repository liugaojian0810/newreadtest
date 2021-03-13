//
//  HFParentScheduleRowTitle.m
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFParentScheduleRowTitle.h"
#import "HFSchedulModel.h"

@implementation HFParentScheduleRowTitle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMsg:(HFSchedulDetailMessage *)msg{
    _msg = msg;
//    _time.text = [NSString stringWithFormat:@"%@-%@",msg.startDate,msg.endDate];
    
    @try {
        if (msg.startDate.length > 6) {
            NSString *start = [msg.startDate substringWithRange:NSMakeRange(11, 5)];
            NSString *end = [msg.endDate substringWithRange:NSMakeRange(11, 5)];
            _time.text = [NSString stringWithFormat:@"%@\n|\n%@",start,end];
        }else{
            _time.text = [NSString stringWithFormat:@"%@\n|\n%@",msg.startDate,msg.endDate];
        }
    } @catch (NSException *exception) {
        
    } @finally {
            
    }


    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
