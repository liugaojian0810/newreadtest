//
//  HFAllNavView.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFAllNavView.h"

@implementation HFAllNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, HFCREEN_WIDTH, 64);
}


@end
