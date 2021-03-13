//
//  HFVideoController.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/27.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFVideoController : UIViewController
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *courseId;
@property(nonatomic, copy) NSString *classStartTime;
@property(nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *weekDetailId;
@property(nonatomic, assign) BOOL hiddenBottomBar;
@end

NS_ASSUME_NONNULL_END
