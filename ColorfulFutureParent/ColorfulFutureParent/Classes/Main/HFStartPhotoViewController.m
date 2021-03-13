//
//  HFStartPhotoViewController.m
//  ColorfulFutureTeacher_iOS
//
//  Created by wzz on 2020/5/30.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFStartPhotoViewController.h"
#import "HFViewController.h"
#import <JKCategories/JKCategories.h>
#import "ColorfulFutureParent-Swift.h"

@interface HFStartPhotoViewController ()

@end

@implementation HFStartPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    BOOL logout = [[NSUserDefaults standardUserDefaults] boolForKey:@"LoginOutTag"];
    if (logout) {
        [ShowHUD showHUDWithInfo:@"登录失效，请重新登录"];
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main_Parent" bundle:nil];
//    [[NSUserDefaults standardUserDefaults]setObject:[UIDevice jk_version] forKey:@"version"];
//    [UIApplication sharedApplication].keyWindow.rootViewController = [board instantiateViewControllerWithIdentifier:@"TabBarControllerID"];
    
    
    NSUserDefaults *userDef =  [NSUserDefaults standardUserDefaults];
    [userDef setObject:[UIDevice jk_version] forKey:@"version"];
    [userDef setBool:YES forKey:@"LoginOutTag"];
    [userDef synchronize];
    HFNewBaseNavigationController *nc = [[HFNewBaseNavigationController alloc] initWithRootViewController:[HFNewLoginViewController new]];
    nc.modalPresentationStyle = UIModalPresentationFullScreen;
    [UIApplication sharedApplication].keyWindow.rootViewController = nc;
    
}


@end
