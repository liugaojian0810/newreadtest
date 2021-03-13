//
//  ShowHUD.m
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "ShowHUD.h"
#import "HFConfig.h"


@interface ShowHUD () {
    MBProgressHUD   *_hud;
}

@end

@implementation ShowHUD

const CGFloat TopMargin        = 10.f;

+ (MBProgressHUD *)showHUD:(UIView *)superView info:(NSString *)info afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.bezelView.layer.cornerRadius = 5;
    [hud setUserInteractionEnabled: NO];
    hud.label.text = info;
    hud.margin = TopMargin;
    [hud removeFromSuperViewOnHide];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

+ (MBProgressHUD *)showHUD {
    return [self showHUD:[HFConfig lastWindow] info:nil afterDelay:0.8];
}


+ (MBProgressHUD *)showHUDWithInfo:(NSString *)info {
    return [self showHUD:[HFConfig lastWindow] info:info afterDelay:1.8];
}

+ (MBProgressHUD *)showHUDWithInfo:(NSString *)info afterDelay:(NSTimeInterval)delay {
    return [self showHUD:[HFConfig lastWindow] info:info afterDelay:delay];
}

+ (MBProgressHUD *)showHUDLoading {
    return [MBProgressHUD showHUDAddedTo:[HFConfig lastWindow] animated:YES];
}

+ (void)hiddenHUDLoading {
    [MBProgressHUD hideHUDForView:[HFConfig lastWindow] animated:YES];
}
@end
