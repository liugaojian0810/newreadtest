//
//  HFResponse.h
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFResponse : NSObject

/**公共返回参数*/
@property(nonatomic,assign) NSInteger errorCode;
@property(nonatomic,copy) NSString *errorMessage;
@property(nonatomic,assign) BOOL success;

/**是否请求数据成功 */
@property(nonatomic,assign) BOOL isRequestSuccess;

/**返回的实体数据*/
@property(nonatomic,strong) id  model;

@end

NS_ASSUME_NONNULL_END
