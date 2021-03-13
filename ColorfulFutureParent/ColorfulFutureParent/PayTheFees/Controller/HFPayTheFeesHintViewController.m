//
//  HFPayTheFeesHintViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPayTheFeesHintViewController.h"
#import "UIView+HFDottedLine.h"
#import "HFPayTheFeesHintViewController.h"
#import "HomeViewController.h"
#import "NSString+RichString.h"
#import "UIView+Extension.h"
#import <JKCategories/JKCategories.h>
#import <WebKit/WebKit.h>

@interface HFPayTheFeesHintViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *bottomPrice;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextField *codeNumber;
@property (weak, nonatomic) IBOutlet UILabel *balanceAmount;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *messageCodeBtn;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger times;
@property (nonatomic, strong)NSString *phone;

@end

@implementation HFPayTheFeesHintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text = self.titleString;
    [UIView drawLineOfDashByCAShapeLayer:self.lineView lineLength:3 lineSpacing:1 lineColor:[UIColor jk_colorWithHexString:@"#CCBFBC"]];
    self.balanceAmount.text = [NSString stringWithFormat:@"¥%.2lf",[[self.dataDic valueForKey:@"payBalance"] doubleValue] *0.01];
    self.amount.text = [NSString stringWithFormat:@"¥%.2lf",[[self.dataDic valueForKey:@"totalAmount"] doubleValue] *0.01];
    self.phone = [HFUserManager getUserInfo].phone;
    self.phoneNumber.text = [NSString stringWithFormat:@"%@****%@",[self.phone substringWithRange:NSMakeRange(0, 3)],[self.phone substringWithRange:NSMakeRange(self.phone.length - 4, 4)]];
    self.messageCodeBtn.layer.borderColor = [UIColor jk_colorWithHexString:@"#FA9030"].CGColor;
    self.messageCodeBtn.layer.borderWidth = 1;
    UIView *leftView = [[UIView alloc]init];
    leftView.size = CGSizeMake(5, 26);
    self.codeNumber.leftView = leftView;
    self.codeNumber.leftViewMode = UITextFieldViewModeAlways;
    self.codeNumber.enablesReturnKeyAutomatically = YES;
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)messageCodeAction:(UIButton *)sender {
    [Service postWithUrl:paymentSendCodeAPI params:@{@"phone":self.phone} success:^(id responseObject) {
        [self countTime:self.messageCodeBtn];
    } failure:^(HFError *error) {
        [MBProgressHUD showMessage:error.errorMessage];
    }];
}

- (IBAction)payAction:(UIButton *)sender {
    if (self.codeNumber.text.length > 3 && self.codeNumber.text.length <7) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params addEntriesFromDictionary:self.dataDic];
        [params setValue:self.codeNumber.text forKey:@"checkCode"];
        sender.userInteractionEnabled = NO;
        [Service postWithUrl:balancePayAPI params:params success:^(id responseObject) {
            sender.userInteractionEnabled = YES;
            [MBProgressHUD showMessage:@"支付成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].keyWindow.rootViewController = [HomeViewController new];
            });
        } failure:^(HFError *error) {
            sender.userInteractionEnabled = YES;
            [MBProgressHUD showMessage:error.errorMessage];
        }];
    } else {
        [MBProgressHUD showMessage:@"请输入验证码"];
    }
}
//验证码倒计时
- (void)countTime:(UIButton*)sender{
    if (self.timer == nil) {
        _times = 60;
        sender.enabled = NO;
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)timeChanged{
    if (_times >= 0) {
        [self.messageCodeBtn setTitle:[NSString stringWithFormat:@"%lds",(long)_times] forState:UIControlStateNormal];
        _times--;
    }else{
        self.messageCodeBtn.enabled = YES;
        [self.messageCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
