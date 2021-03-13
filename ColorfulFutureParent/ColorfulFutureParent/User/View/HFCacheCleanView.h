//
//  HFCacheCleanView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^cacheBlock)(void);

@interface HFCacheCleanView : UIView
@property (weak, nonatomic) IBOutlet UILabel *space;
@property (weak, nonatomic) IBOutlet UILabel *cache;
@property (nonatomic, copy) cacheBlock block;
@property (weak, nonatomic) IBOutlet UIView *lineView;

-(void)clearCache:(NSString *)path;

@end


NS_ASSUME_NONNULL_END
