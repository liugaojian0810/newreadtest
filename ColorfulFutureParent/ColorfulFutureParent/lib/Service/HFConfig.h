//
//  HFConfig.h
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFConfig : NSObject

+ (UIWindow *)lastWindow;

+ (NSData *)compressSourceImage:(UIImage *)sourceImage;

/** JSON转字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** 字典转JSON */
+(NSString *)dictionaryToJson:(NSDictionary *)dic;

+ (NSString *)serializedWithURIString:(NSString *)uri params:(id)params;
@end

NS_ASSUME_NONNULL_END
