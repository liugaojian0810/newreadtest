//
//  HFInsteractStatusheaderView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInsteractStatusheaderView.h"

@implementation HFInsteractStatusheaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)btnActtion:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
    for (UIButton *btn in self.btnArr) {
        if (sender.tag == btn.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

@end
