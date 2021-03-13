//
//  HFCustomAlertViewController.m
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFCustomAlertViewController.h"

@interface HFCustomAlertViewController ()

@property (weak, nonatomic) IBOutlet UIView *tipBgView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;

@end

@implementation HFCustomAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tipBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:.8];
    self.tipBgView.layer.cornerRadius = 5;
    self.tipBgView.layer.masksToBounds = YES;
}

-(void)setType:(NSInteger)type{
    switch (type) { //成功
        case 0:
        {
            self.tipImageView.image = [UIImage imageNamed:@"alert_result_icon_success"];
        }
            break;
        case 1: //失败
        {
            self.tipImageView.image = [UIImage imageNamed:@"alert_result_icon_close"];
        }
            break;
        case 2: //警告
        {
            self.tipImageView.image = [UIImage imageNamed:@"alert_result_icon_close"];
        }
            break;
        default: //成功
        {
            self.tipImageView.image = [UIImage imageNamed:@"alert_result_icon_success"];
        }
            break;
    }
    if (self.tipMsg == nil) {
        self.tipLabel.text = @"操作失败";
    }else{
        self.tipLabel.text = self.tipMsg;
    }
}


@end
