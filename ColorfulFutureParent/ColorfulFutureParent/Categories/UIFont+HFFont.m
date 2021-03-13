//
//  UIFont+HFFont.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/15.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UIFont+HFFont.h"
#import <objc/runtime.h>

#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375

@implementation UIFont (HFFont)
//只执行一次的方法，在这个地方 替换方法
+(void)load{
    
    //保证线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        //拿到系统方法
        Method orignalMethod = class_getClassMethod(class, @selector(systemFontOfSize:));
        //拿到自己定义的方法
        Method myMethod = class_getClassMethod(class, @selector(HF_systemFontOfSize:));
        //交换方法
        method_exchangeImplementations(orignalMethod, myMethod);
        
        //拿到系统方法
        Method orignalMethodFontName = class_getClassMethod(class, @selector(fontWithName:size:));
        //拿到自己定义的方法
        Method myMethodFontName = class_getClassMethod(class, @selector(HF_FontWithName:size:));
        //交换方法
        method_exchangeImplementations(orignalMethodFontName, myMethodFontName);
        
        //拿到系统方法
        Method orignalMethodFontNameBold = class_getClassMethod(class, @selector(boldSystemFontOfSize:));
        //拿到自己定义的方法
        Method myMethodFontNameBold = class_getClassMethod(class, @selector(HF_boldSystemFontOfSize:));
        //交换方法
        method_exchangeImplementations(orignalMethodFontNameBold, myMethodFontNameBold);
    });
}

+ (UIFont *)HF_systemFontOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"ARYuanGB-LT" size:fontSize];
    return font;
}
+ (nullable UIFont *)HF_FontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    UIFont *font = [UIFont HF_FontWithName:fontName size:fontSize];
    return font;
}

+ (UIFont *)HF_boldSystemFontOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"ARYuanGB-BD" size:fontSize];
    return font;
}
// ARYuanGB-BD-T
@end
