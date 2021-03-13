//
//  UIImage+HGJ.h
//  Selene
//
//  Created by zhaoqiang on 16/3/31.
//  Copyright © 2016年 hairun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HGJ)

/** UIImage不失真压缩 */
- (UIImage *)scaleToSize:(CGSize)size;

/** 根据图片名返回一张能够自由拉伸的图片 */
+ (UIImage *)resizedImage:(NSString *)name;

+ (UIImage *)resizedImage:(NSString *)name capInsets:(UIEdgeInsets)capInsets;

/** 根据RGB颜色值，返回一张图片 */
+ (UIImage *)zq_imageWithColor:(UIColor *)color;

/** tabBar加载最原始的图片不要渲染 */
+ (UIImage *)imageWithOriginalName:(NSString *)imageName;

/** 可拉伸不变形的图片 */
+ (UIImage *)imageWithStretchableName:(NSString *)imageName;

/** 更具图片名字适配不同屏幕的图片主要用于全屏图片适配5/7/7P/X */
+ (NSString *)adaptImageName:(NSString *)imageName;

+ (UIImage *)getImageWithColor:(UIColor *)color;

/** 根据字符串生成二维码图片 */
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

@end
