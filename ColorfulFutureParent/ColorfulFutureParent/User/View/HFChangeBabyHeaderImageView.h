//
//  HFChangeBabyHeaderImageView.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void(^changeImageBlock)(NSInteger tag);
@interface HFChangeBabyHeaderImageView : UIView
@property (nonatomic, copy)changeImageBlock block;
@end

NS_ASSUME_NONNULL_END
