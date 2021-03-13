//
//  HFAlert.m
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFAlert.h"
#import "HFCustomAlertViewController.h"

@implementation HFAlert

+(void)showAlertWithMsg:(NSString *)mes inController:(UIViewController *)vc alertStatus:(AlertStatus)status completeBlock:(HFAlertCompletionBlock)completeBlock{
    HFCustomAlertViewController *alert = [[HFCustomAlertViewController alloc]init];
    alert.view.frame = CGRectMake(0, 0, 170, 90);
    alert.view.jk_centerX = [UIApplication sharedApplication].keyWindow.jk_centerX;
    alert.view.jk_centerY = [UIApplication sharedApplication].keyWindow.jk_centerY - 100;
    alert.tipMsg = mes;
    alert.type = status;
    [vc.view addSubview:alert.view];
    [vc.view bringSubviewToFront:alert.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert.view removeFromSuperview];
        if (completeBlock != nil) {
            completeBlock();
        }
    });
}

+(void)showAlertWithMsg:(NSString *)mes inController:(UIViewController *)vc alertStatus:(AlertStatus)status{
    [self showAlertWithMsg:mes inController:vc alertStatus:status completeBlock:nil];
}

-(void)showPopAlertWithBtn:(UIButton *)barBtn popSize:(CGSize)size text:(NSString *)text inController:(UIViewController *)vc{
    
    UIViewController *temp = [[UIViewController alloc]init];
    temp.modalPresentationStyle = UIModalPresentationPopover;
    temp.preferredContentSize = size;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, size.width - 20, size.height - 20)];
    label.textColor = [UIColor whiteColor];
    label.text = text;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    [temp.view addSubview:label];
    UIPopoverPresentationController *popVC = temp.popoverPresentationController;
    popVC.delegate = self;
    popVC.backgroundColor = [UIColor blackColor];
    popVC.barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barBtn];
    [vc presentViewController:temp animated:YES completion:nil];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    // 此处为不适配(如果选择其他,会自动视频屏幕,上面设置的大小就毫无意义了)
    return UIModalPresentationNone;
}

@end
