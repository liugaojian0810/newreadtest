//
//  HFChangePhoneNumController.m
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFChangePhoneNumController.h"
#import "HFChangeInfoView.h"
#import "HFChangeCompleViewController.h"

#import <ColorfulFutureParent-Swift.h>

@interface HFChangePhoneNumController ()

@property (nonatomic, strong) HFChangeInfoView *mainView;
@property (nonatomic, strong) HFSetupViewModel *myViewModel;

@end

@implementation HFChangePhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaviga];
}

- (void)setupNaviga {
    self.title = @"更换手机号";
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#F6F6F6"];
    [self config];
}

-(void)config {
    
    _myViewModel = [[HFSetupViewModel alloc]init];
    self.mainView = [[NSBundle mainBundle] loadNibNamed:@"HFChangeInfoView" owner:nil options:nil].firstObject;
    [self.view addSubview:self.mainView];
    self.mainView.frame = CGRectMake(0, HFNavHeight, HFCREEN_WIDTH, HFCREEN_HEIGHT);
    self.mainView.passWordView.hidden = YES;
    self.mainView.passRuleLab.hidden = YES;
    self.mainView.getCodeView.hidden = YES;
    self.mainView.phoneTF.placeholder = @"请输入当前账户使用手机号";
    [self.mainView.completeBut addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.completeBut setTitle:@"下一步" forState:UIControlStateNormal];
    [self.mainView.phoneTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    self.mainView.completeBut.alpha = 0.5;
    self.mainView.completeBut.userInteractionEnabled = NO;
}


-(void)textChanged:(UITextField *)tf {
    [tf limitInoutWord:11];
    if (tf.text.length  == 11) {
        self.mainView.completeBut.alpha = 1;
        self.mainView.completeBut.userInteractionEnabled = YES;
    }else{
        self.mainView.completeBut.alpha = 0.5;
        self.mainView.completeBut.userInteractionEnabled = NO;
    }
}

#pragma mark - 下一步
- (void)nextStep {
    NSString* usrPhone = HFUserInformation.userInfo.usrPhone;
    _myViewModel.oldPhone = self.mainView.phoneTF.text;
    if (![usrPhone isEqualToString:self.mainView.phoneTF.text]) {
        [ShowHUD showHUDWithInfo:@"您输入的手机号有误，请重新输入"];
        return;
    }
    
    NSInteger ucdes = HFUserInformation.userInfo.usrAuthStatus;
    if (ucdes == 1) {
        [ShowHUD showHUDLoading];
        [HFFaceManager.shared startFaceDetectWithCurrentVC:self :^(UIImage * _Nullable img) {
            HFIdentityAuthViewModel *model = [[HFIdentityAuthViewModel alloc] init];
            
            [model faceVerifyCancelWithVerifyType:0 image:img :^{
                [ShowHUD hiddenHUDLoading];
                HFChangeCompleViewController *comVC = [[HFChangeCompleViewController alloc] init];
                comVC.oldPhone = self.mainView.phoneTF.text;
                comVC.completeBlock = ^{
                    [self.navigationController popViewControllerAnimated:NO];
                };
                [self.navigationController pushViewController:comVC animated:YES];
            } :^(NSError * _Nullable error) {
                [ShowHUD hiddenHUDLoading];
            }];
        } :^(NSError * _Nullable error) {
            [ShowHUD hiddenHUDLoading];
        }];
    }
}

- (void)submit {
    
    //    HFChangeCompleViewController *comVC = [[HFChangeCompleViewController alloc] init];
    //    [self.navigationController pushViewController:comVC animated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
