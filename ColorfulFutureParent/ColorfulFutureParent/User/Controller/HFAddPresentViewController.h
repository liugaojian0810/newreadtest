//
//  HFAddPresentViewController.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/5.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^changeBlock)(NSDictionary *dic);
@interface HFAddPresentViewController : UIViewController
@property (nonatomic, copy)changeBlock block;
@end

NS_ASSUME_NONNULL_END
