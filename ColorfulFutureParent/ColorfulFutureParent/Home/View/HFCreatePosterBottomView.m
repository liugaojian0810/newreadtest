//
//  HFCreatePosterBottomView.m
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/6/15.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFCreatePosterBottomView.h"

@implementation HFCreatePosterBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.tag - 101);
    }
}

@end
