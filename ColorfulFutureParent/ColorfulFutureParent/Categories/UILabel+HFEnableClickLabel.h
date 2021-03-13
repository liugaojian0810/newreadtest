//
//  UILabel+HFEnableClickLabel.h
//  ColorfulFuturePrincipal
//
//  Created by Mac on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HFEnableClickLabel)
- (void)setTapActionWithBlockWithLabel:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
