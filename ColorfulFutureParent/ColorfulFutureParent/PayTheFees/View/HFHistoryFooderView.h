//
//  HFHistoryFooderView.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/26.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^historyFooderViewBlock)(NSInteger section);

NS_ASSUME_NONNULL_BEGIN

@interface HFHistoryFooderView : UIView
@property (weak, nonatomic) IBOutlet YLButton *fooderBtn;
@property (nonatomic, copy) historyFooderViewBlock block;

@end

NS_ASSUME_NONNULL_END
