//
//  HFPosterView.m
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPosterView.h"

@implementation HFPosterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setType:(NSInteger)type{
    if (type==1) {
//        self.avatar.image = [HFUserManager sharedHFUserManager].getUserInfo;
        self.presenter.text = [NSString stringWithFormat:@"”%@“",[HFUserManager sharedHFUserManager].getUserInfo.babyInfo.kgName];
    }
}
- (IBAction)btn:(id)sender {
    UIButton * btn = sender;
    self.btnBlock(btn.tag);
}
@end
