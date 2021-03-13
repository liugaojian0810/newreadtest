//
//  HFTools.m
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/2.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFTools.h"
#import "HFShareView.h"
@implementation HFTools
+(void)shareSureBlock:(void(^)(NSInteger index))sureBlock cancelBlock:(nonnull void (^)(void))cancelBlock{
    HFShareView * shareView= [[NSBundle mainBundle] loadNibNamed:@"HFShareView" owner:nil options:nil].firstObject;
    shareView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    shareView.frame  = [UIScreen mainScreen].bounds;
    [KEYWINDOW addSubview:shareView];
    [KEYWINDOW bringSubviewToFront:shareView];
    shareView.shareClickBlock = ^(NSInteger type) {
        sureBlock(type);
    };
    shareView.cancelClickBlock = ^{
        cancelBlock();
    };
      
}
@end
