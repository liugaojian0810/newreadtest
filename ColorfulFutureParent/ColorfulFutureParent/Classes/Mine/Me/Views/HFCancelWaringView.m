//
//  HFCancelWaringView.m
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFCancelWaringView.h"

@implementation HFCancelWaringView

- (IBAction)withdraw:(UIButton *)sender {
    BLOCK_SAFE(self.withdrawBlock);
}

- (IBAction)agree:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    BLOCK_SAFE(self.agreeBlock);
}

- (IBAction)nextStep:(UIButton *)sender {
    BLOCK_SAFE(self.nextStepBlock);
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.agreeBtn.jk_touchAreaInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // 金额为0时显示，初始化时先隐藏
    self.withdrawBtn.hidden = YES;
}

@end
