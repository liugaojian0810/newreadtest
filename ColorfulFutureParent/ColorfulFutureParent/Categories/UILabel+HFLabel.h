//
//  UILabel+HFLabel.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HFLabel)
- (void)mydrawTextInRect:(CGRect)rect;
- (void)hfSetText:(NSString *) str;
/// 返回json
/// @param data 数组字典皆可
+ (NSString *)backJson:(id)data;
@end

NS_ASSUME_NONNULL_END
