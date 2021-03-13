//
//  UIImage+HGJ.m
//  Selene
//
//  Created by zhaoqiang on 16/3/31.
//  Copyright © 2016年 hairun. All rights reserved.
//

#import "UIImage+HGJ.h"

#define IS_iPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size): NO)

#define IS_iPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size): NO)

#define IS_iPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size)): NO)

#define IS_iPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001),[[UIScreen mainScreen] currentMode].size)): NO)

#define IS_iPhoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation UIImage (HGJ)

/** UIImage不失真压缩http://blog.csdn.net/iot_li/article/details/51085253 */
- (UIImage *)scaleToSize:(CGSize)size {
    // 参照YYKit UIImage的分类
    if (size.width <= 0 || size.height <= 0) return nil;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   
}

+ (UIImage *)resizedImage:(NSString *)name {
    // 设置图片的如何拉伸,定好四个边的内边距,只拉伸里面的外面保持原状（实际是外边不变 内部来个平铺图片）
    UIImage *image = [UIImage imageNamed:name];
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
}

// 该方法返回的是UIImage类型的对象,即返回经该方法拉伸后的图像
// 传入的第一个参数capInsets是UIEdgeInsets类型的数据,即原始图像要被保护的区域
// 这个参数是一个结构体,定义如下
// typedef struct { CGFloat top, left , bottom, right ; } UIEdgeInsets;
// 该参数的意思是被保护的区域到原始图像外轮廓的上部,左部,底部,右部的直线距离,参考图2.1
// 传入的第二个参数resizingMode是UIImageResizingMode类似的数据,即图像拉伸时选用的拉伸模式,
// 这个参数是一个枚举类型,有以下两种方式
// UIImageResizingModeTile,     平铺
// UIImageResizingModeStretch,  拉伸
+ (UIImage *)resizedImage:(NSString *)name capInsets:(UIEdgeInsets)capInsets {
    UIImage *image = [UIImage imageNamed:name];
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)zq_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithStretchableName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (NSString *)adaptImageName:(NSString *)imageName {
    NSString *fullImageName = imageName;
    // iphone4/4S
    if (IS_iPHONE4) {
        fullImageName = [NSString stringWithFormat:@"%@_iphone4", fullImageName];
    }
    
    // iphone5/5S/5C/SE
    if (IS_iPHONE5) {
        fullImageName = [NSString stringWithFormat:@"%@_iphone5", fullImageName];
    }
    
    // iphone6/6S/7/8
    if (IS_iPHONE6) {
        fullImageName = [NSString stringWithFormat:@"%@_iphone6", fullImageName];
    }
    
    // iphone6P/6SP/7P/8P
    if (IS_iPHONE6P) {
        fullImageName = [NSString stringWithFormat:@"%@_iphone6P", fullImageName];
    }
    
    // iphoneX
    if (IS_iPhoneX) {
        fullImageName = [NSString stringWithFormat:@"%@_iphoneX", fullImageName];
    }
    
    return fullImageName;
}

+ (UIImage *)getImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/// 生成二维码
/// @param code 二维码字符串
/// @param width 二维码宽度
/// @param height 二维码高度
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

@end
