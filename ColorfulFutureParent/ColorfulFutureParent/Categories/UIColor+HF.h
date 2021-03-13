//
//  UIColor+HF.h
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/11.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HF)

+ (instancetype)randomColor;

+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
