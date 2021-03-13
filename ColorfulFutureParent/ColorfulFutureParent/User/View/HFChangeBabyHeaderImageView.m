//
//  HFChangeBabyHeaderImageView.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFChangeBabyHeaderImageView.h"

@implementation HFChangeBabyHeaderImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)butAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}

@end
