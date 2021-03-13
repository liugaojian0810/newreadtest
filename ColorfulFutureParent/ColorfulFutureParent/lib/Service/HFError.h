//
//  HFError.h
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFError : NSObject

@property (nonatomic, copy) NSString *errorCode;
@property (nonatomic, copy) NSString *errorMessage;

/**
 构造函数
 */
+ (instancetype)errorWithCode:(NSString *)errorCode errorMessage:(NSString *)errorMessage;
@end

NS_ASSUME_NONNULL_END
