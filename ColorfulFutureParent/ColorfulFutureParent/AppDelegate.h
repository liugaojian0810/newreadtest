//
//  AppDelegate.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *appKey = @"2cdd89695d3fec0169108080";
static NSString *channel = @"appStore";
static BOOL isProduction = FALSE;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,assign)BOOL allowRotation;
@property (strong, nonatomic) UIWindow *window;
@end

