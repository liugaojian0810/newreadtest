//
//  HFViewController.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFViewController : UIViewController
@property(nonatomic, copy) NSString *coverName, *bgImageName, *titleName;
@property(nonatomic, assign) BOOL hiddenAllView;
@property(nonatomic, assign) BOOL hiddenCloseBtn;
@property(nonatomic, strong) UIImageView *contentView;
@property(nonatomic, strong) UIView *bgViewBaseColor;
-(void)addMySubViews;
-(void)setMasonry;
- (void)back;
@end

NS_ASSUME_NONNULL_END
