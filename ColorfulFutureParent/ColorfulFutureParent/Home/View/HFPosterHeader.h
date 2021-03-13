//
//  HFPosterHeader.h
//  ColorfulFutureParent
//
//  Created by ql on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPosterHeader : UIView
- (IBAction)back:(id)sender;
@property(nonatomic,copy)void(^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
