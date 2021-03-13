//
//  HFAddPresentViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/5.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFAddPresentViewController.h"

@interface HFAddPresentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *presentName;
@property (weak, nonatomic) IBOutlet UIView *butBackView;
@property (weak, nonatomic) IBOutlet UIImageView *butbackImageView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (nonatomic, assign) BOOL isHidden;
@end

@implementation HFAddPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidden = YES;
    [self setupButStatus];
}

- (void)setupButStatus {
    
    WS(weakSelf);
    [[self.name.rac_textSignal filter:^BOOL(NSString *value) {
        return value.length > 6;
    }] subscribeNext:^(NSString *string) {
        weakSelf.name.text = [weakSelf.name.text substringToIndex:6];
    }] ;
    [[self.phone.rac_textSignal filter:^BOOL(NSString *value) {
        return value.length > 11;
    }] subscribeNext:^(NSString *value) {
        weakSelf.phone.text = [weakSelf.phone.text substringToIndex:11];
    }] ;
}


- (IBAction)butAction:(UIButton *)sender {
    if (self.isHidden) {
        self.isHidden = NO;
    } else {
        self.isHidden = YES;
    }
    if (sender.tag != 444) {
        self.presentName.text = sender.titleLabel.text;

    }
    self.butBackView.hidden = self.isHidden;
    self.butbackImageView.hidden = self.isHidden;
    
}
- (IBAction)confirmAction:(UIButton *)sender {
    if (self.presentName.text.length != 2) {
        [MBProgressHUD showMessage:@"请选择关系"];
        return;
    }
    if (self.name.text.length < 2) {
        [MBProgressHUD showMessage:@"请输入姓名"];
        return;
    }
    if (self.phone.text.length != 11) {
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    if (self.block) {
        self.block(@{@"name":self.name.text,@"present":self.presentName.text,@"phone":self.phone.text});
    };
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
