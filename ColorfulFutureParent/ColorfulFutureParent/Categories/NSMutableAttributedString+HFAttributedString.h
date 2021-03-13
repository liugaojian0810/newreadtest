//
//  NSMutableAttributedString+HFAttributedString.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (HFAttributedString)
- (NSMutableAttributedString *)attributedStringwith: (UIColor *)color whith:(UIFont *)font with:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
