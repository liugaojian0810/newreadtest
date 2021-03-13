//
//  HFInteractiveStatusListHeaderView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractiveStatusListHeaderView.h"

@implementation HFInteractiveStatusListHeaderView

-(void)setModel:(HFCoursePlaybackListModelElement *)model{
    self.des.text = [model.appointmentDate substringWithRange:NSMakeRange(0, 10)];
}
- (void)setReservedModel:(HFAModel *)reservedModel {
    self.des.text = [reservedModel.appointmentDate substringWithRange:NSMakeRange(0, 10)];;
}

- (void)setNoReservedModel:(HUFModel *)noReservedModel {
    self.des.text = [noReservedModel.appointmentDate substringWithRange:NSMakeRange(0, 10)];;

}

@end
