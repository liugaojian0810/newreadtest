//
//  HFIndexPath.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFIndexPath : NSObject
@property (nonatomic, assign, readonly) NSInteger section;
@property (nonatomic, assign, readonly) NSInteger row;
@property (nonatomic, assign, readonly) NSInteger item;

+(instancetype)indexPathForItem:(NSInteger)item row:(NSInteger)row section:(NSInteger)section;
+(instancetype)indexPathForItem:(NSInteger)item section:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
