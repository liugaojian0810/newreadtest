//
//  HFClassTopView.m
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/6/21.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFClassTopView.h"

@implementation HFClassTopView

-(void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)shareAction:(UIButton *)sender {
    BLOCK_SAFE(self.shareBlock);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
