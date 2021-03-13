//
//  UILabel+HFEnableClickLabel.m
//  ColorfulFuturePrincipal
//
//  Created by Mac on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UILabel+HFEnableClickLabel.h"
#import <objc/message.h>

static char kLAActionHandlerTapGestureKey;
static char kLAActionHandlerTapBlockKey;

@implementation UILabel (HFEnableClickLabel)
- (void)setTapActionWithBlockWithLabel:(void (^)(void))block {
    // 运行时获取单击对象
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kLAActionHandlerTapGestureKey);
    if (!gesture) {
        // 如果没有该对象，就创建一个
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        // 绑定一下gesture
        objc_setAssociatedObject(self, &kLAActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    // 绑定一下block
    objc_setAssociatedObject(self, &kLAActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        // 取出上面绑定的block
        void(^action)(void) = objc_getAssociatedObject(self, &kLAActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}
@end
