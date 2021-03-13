//
//  HFHistoryFooderView.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/26.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFHistoryFooderView.h"

@implementation HFHistoryFooderView

- (IBAction)btnAction:(YLButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}

@end
