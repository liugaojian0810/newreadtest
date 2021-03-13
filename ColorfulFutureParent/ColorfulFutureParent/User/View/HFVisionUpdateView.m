//
//  HFVisionUpdateView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFVisionUpdateView.h"

@implementation HFVisionUpdateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)deteminClick:(UIButton *)sender {
    
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
