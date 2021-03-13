//
//  UILabel+HFLabel.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UILabel+HFLabel.h"
#import <objc/runtime.h>
#define kScale MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) / 375

@implementation UILabel (HFLabel)
- (void)mydrawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 5, 0, 5};
    [self drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

-(void)hfSetText:(NSString *)str {
    
}

+ (NSString *)backJson:(id)data {
    NSError *error = nil;
    NSString *jsonString;
    if ([data isKindOfClass:[NSArray class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
