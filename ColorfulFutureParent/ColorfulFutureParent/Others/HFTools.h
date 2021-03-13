//
//  HFTools.h
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/2.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HFTools : NSObject

/// 分享
/// @param sureBlock 选中的分享类型 0-3朋友圈、 微信好友、生成海报、赋值链接
+(void)shareSureBlock:(void(^)(NSInteger index))sureBlock cancelBlock:(void(^)(void))cancelBlock;
@end

NS_ASSUME_NONNULL_END
