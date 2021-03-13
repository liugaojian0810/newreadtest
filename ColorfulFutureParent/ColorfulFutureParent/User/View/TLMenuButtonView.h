//
//  TLMenuButtonView.h
//  ColorfulFutureParent
//
//  Created by Ruby的MacBook Pro on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMenuButton.h"

@interface TLMenuButtonView : UIView

@property (nonatomic, assign) CGPoint centerPoint;

- (void)showItems;

- (void)dismiss;

- (void)dismissAtNow;

@property (nonatomic, copy) void (^clickAddButton)(NSInteger index, UIColor *);

+ (instancetype)standardMenuView;
@end
