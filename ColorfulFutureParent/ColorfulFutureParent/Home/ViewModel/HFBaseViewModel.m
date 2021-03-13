//
//  HFBaseViewModel.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseViewModel.h"

@implementation HFBaseViewModel

-(void)dealloc{
    NSString *className = NSStringFromClass([self class]);
    HFLog(@"%@--dealloc方法调用了",className);
}

@end
