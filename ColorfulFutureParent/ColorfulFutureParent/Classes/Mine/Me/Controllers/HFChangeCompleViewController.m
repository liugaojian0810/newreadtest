//
//  HFChangeCompleViewController.m
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFChangeCompleViewController.h"
#import "HFChangeInfoView.h"
#import <ColorfulFutureParent-Swift.h>

@interface HFChangeCompleViewController ()

@property (nonatomic, strong) HFChangeInfoView *mainView ;
@property (nonatomic, strong) HFSetupViewModel *myViewModel;
@property (nonatomic, strong) HFSwiftCountDown *countDown;

@end

@implementation HFChangeCompleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaviga];
    // Do any additional setup after loading the view.
}

- (void)setupNaviga {
    self.title = @"新的手机号";
//    [self initNAVTitle:@"更换手机号" withColor:[UIColor blackColor] withFont:[UIFont fontWithName:@"PingFangSC-Medium" size:20]];
//    [self setupBackItem:@"ic_fanhui_hei_"];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#F6F6F6"];
}

-(void)addSubViews {

    _myViewModel = [[HFSetupViewModel alloc]init];
    _myViewModel.oldPhone = self.oldPhone;
    self.mainView = [[NSBundle mainBundle] loadNibNamed:@"HFChangeInfoView" owner:nil options:nil].firstObject;
    [self.view addSubview:self.mainView];
    self.mainView.frame = self.view.frame;
    self.mainView.passWordView.hidden = YES;
    self.mainView.passRuleLab.hidden = YES;
    self.mainView.phoneTF.placeholder = @"请输入手机号";
    self.mainView.verfiCodeTF.placeholder = @"请输入验证码";
    [self.mainView.completeBut setTitle:@"提交" forState:UIControlStateNormal];
    [self.mainView.completeBut addTarget:self action:@selector(chagneComplete) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.phoneTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.mainView.verfiCodeTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.mainView.getCodeBut addTarget:self action:@selector(getMsgCode) forControlEvents:UIControlEventTouchUpInside];
    self.mainView.completeBut.alpha = 0.5;
    self.mainView.completeBut.userInteractionEnabled = NO;
}


-(void)textChanged:(UITextField *)tf {

    if (self.mainView.phoneTF.text.length > 11) {
        self.mainView.phoneTF.text = [self.mainView.phoneTF.text substringToIndex:11];
    }
    if (self.mainView.verfiCodeTF.text.length > 6) {
        self.mainView.verfiCodeTF.text = [self.mainView.verfiCodeTF.text substringToIndex:6];
    }
    
    if (self.mainView.phoneTF.text.length == 11 && self.mainView.verfiCodeTF.text.length == 6) {
        self.mainView.completeBut.alpha = 1;
        self.mainView.completeBut.userInteractionEnabled = YES;
    }else{
        self.mainView.completeBut.alpha = 0.5;
        self.mainView.completeBut.userInteractionEnabled = NO;
    }
}

#pragma mark - 完成

- (void)getMsgCode
{
    [ShowHUD showHUDLoading];
    [_myViewModel updateNewPhoneSendMsg:self.mainView.phoneTF.text :^{
        [ShowHUD hiddenHUDLoading];
        [ShowHUD showHUDWithInfo:@"发送成功"];
        if (self.countDown != nil) {
            [self.countDown stop];
            self.countDown = nil;
        }
        self.countDown = [[HFSwiftCountDown alloc]init];
        [self.countDown countDownWithTimeInterval:1 repeatCount:60 handler:^(id<OS_dispatch_source_timer> _Nullable time, NSInteger count) {
            if (count != 0) {
                [self.mainView.getCodeBut setTitle:[NSString stringWithFormat:@"%lds",(long)count] forState:UIControlStateNormal];
                self.mainView.getCodeBut.userInteractionEnabled = NO;
            }else{
                [self.mainView.getCodeBut setTitle:@"重新获取" forState:UIControlStateNormal];
                self.mainView.getCodeBut.userInteractionEnabled = YES;
            }
        }];
    } :^{
        [ShowHUD hiddenHUDLoading];
    }];
}

- (void)chagneComplete {
    
    _myViewModel.oldPhone = self.oldPhone;
    _myViewModel.phone = self.mainView.phoneTF.text;
    _myViewModel.qrCode = self.mainView.verfiCodeTF.text;
    WeakSelf
    [_myViewModel setNewPhone:_myViewModel.oldPhone :_myViewModel.phone :self.mainView.verfiCodeTF.text :^{
        Strong_Self
//        [self.navigationController popViewControllerAnimated:NO];
//        if (self.completeBlock) {
//            self.completeBlock();
//        }
        [HFAlert showAlertWithMsg:@"设置成功" inController:self alertStatus:AlertStatusSuccfess];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HFUserInformation removeWithComplete:^{
                NSUserDefaults *userDef =  [NSUserDefaults standardUserDefaults];
                [userDef setBool:YES forKey:@"LoginOutTag"];
                [userDef synchronize];
                HFNewBaseNavigationController *nc = [[HFNewBaseNavigationController alloc] initWithRootViewController:[HFNewLoginViewController new]];
                nc.modalPresentationStyle = UIModalPresentationFullScreen;
                UIApplication.sharedApplication.keyWindow.rootViewController = nc;
            }];
        });
    } :^{
        Strong_Self
//        [self.navigationController popViewControllerAnimated:NO];
//        if (self.completeBlock) {
//            self.completeBlock();
//        }
    }];

//    WeakSelf
//    [_myViewModel updateNewPhone:^{
//        Strong_Self
//        [self.navigationController popViewControllerAnimated:NO];
//        if (self.completeBlock) {
//            self.completeBlock();
//        }
//    } :^{
//        Strong_Self
//        [self.navigationController popViewControllerAnimated:NO];
//        if (self.completeBlock) {
//            self.completeBlock();
//        }
//    }];
    
}


@end
