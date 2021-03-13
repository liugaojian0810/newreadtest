//
//  HFConfig.m
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFConfig.h"
#import <AFNetworking.h>
@implementation HFConfig

+ (UIWindow *)lastWindow {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            window.windowLevel == UIWindowLevelNormal &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

/** 利用AFJSONRequestSerializer序列化请求地址 */
+ (NSString *)serializedWithURIString:(NSString *)uri params:(id)params {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    if (!params) return uri;
    
    NSURLRequest *request = [serializer requestBySerializingRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:uri]] withParameters:params error:nil];
    return request.URL.absoluteString;
}

//JSON字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字典转JSON
+(NSString *)dictionaryToJson:(NSDictionary *)dic{
    if (dic == nil) {
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    return [[NSString alloc] initWithData:jsonData encoding:enc];
}

+ (NSData *)compressSourceImage:(UIImage *)sourceImage {
    // Compress by quality
    CGFloat compression = 1;
    NSUInteger maxLength = 600 * 1024;
    NSData *data = UIImageJPEGRepresentation(sourceImage, compression);
    if (data.length < maxLength) return data;
    
    // 2分算法
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(sourceImage, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        // Use NSUInteger to prevent white blank
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}

@end
