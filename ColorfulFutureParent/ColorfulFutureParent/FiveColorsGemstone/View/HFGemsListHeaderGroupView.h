//
//  HFGemsListHeaderGroupView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef void(^gemsHeaderGroupBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface HFGemsListHeaderGroupView : UIView
@property (nonatomic, copy) gemsHeaderGroupBlock block;

@end

NS_ASSUME_NONNULL_END
