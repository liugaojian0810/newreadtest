//
//  HFHistoryHeaderView.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFHistoryHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *allNumber;

@end

NS_ASSUME_NONNULL_END
