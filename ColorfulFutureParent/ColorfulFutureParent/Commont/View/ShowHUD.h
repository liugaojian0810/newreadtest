//
//  ShowHUD.h
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface ShowHUD : NSObject

+ (MBProgressHUD *)showHUDWithInfo:(NSString *)info;

+ (MBProgressHUD *)showHUDLoading;

+ (void)hiddenHUDLoading;

@end
