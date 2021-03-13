//
//  HFInteractStatusListHeaderView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/10.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractStatusListHeaderView.h"

@implementation HFInteractStatusListHeaderView

- (IBAction)btnAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
    for (UIButton *btn in self.btnArr) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}


@end
