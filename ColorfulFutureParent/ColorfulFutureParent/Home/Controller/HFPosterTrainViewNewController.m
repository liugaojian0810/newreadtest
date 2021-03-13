//
//  HFPosterTrainViewNewController.m
//  ColorfulFuturePrincipal
//
//  Created by huifan on 2020/6/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPosterTrainViewNewController.h"
#import "UIDevice+HFDevice.h"

@interface HFPosterTrainViewNewController ()
@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UIImageView *QRImage, *rightImage;
@property(nonatomic, strong) UIView *QRBGView;
@end

@implementation HFPosterTrainViewNewController


-(instancetype)init {
    
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalPresentationCapturesStatusBarAppearance = YES;
        [UIDevice setVScreen];
    }
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview: self.bgView];
    [self.bgView addSubview: self.QRBGView];
    [self.bgView addSubview: self.QRImage];
    [self.bgView addSubview: self.rightImage];
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setImage:[UIImage imageNamed:@"navigation_back_arrow"] forState:UIControlStateNormal];
    [self.view addSubview:backBut];
    [backBut addTarget:self action:@selector(dissmissVc) forControlEvents:UIControlEventTouchUpInside];
    [backBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(HFSTATUS_H);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont fontWithName:@"ARYuanGB-BD" size:20];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"生成海报";
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(backBut);
    }];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.top.mas_equalTo(backBut.mas_bottom).offset(20);
        make.height.mas_equalTo((HFCREEN_WIDTH - 28 * 2) * 563 / 375);
    }];
    
    [self.QRBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(73 * HFscale);
        make.left.mas_equalTo(22 * HFscale);
        make.bottom.mas_equalTo(-12 * HFscale);
    }];
    
    [self.QRImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.QRBGView);
        make.left.top.mas_equalTo(self.QRBGView).offset(9);
    }];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.QRBGView.mas_right).offset(2.5);
        make.top.mas_equalTo(self.QRBGView);
    }];
    
}

- (void)dissmissVc{
    [UIDevice setHScreen];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *kidID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [ShowHUD showHUDLoading];
    [Service postWithUrl:ShareURLAPI params:@{@"kgId": kidID} success:^(id responseObject) {
        HFLog(@"responseObjectShareURLAPI: %@", responseObject);
        NSString *url = responseObject[@"model"][@"shareUrl"];
        UIImage *image = [self generateQRCode: url width: 160 height: 160];
        [self.bgView addSubview: self.QRImage];
        self.QRImage.image = image;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ShowHUD hiddenHUDLoading];
            UIImage *shareImage = [self.bgView jk_screenshot];
//            NSURL *shareUrl = [NSURL URLWithString: url];
//            NSArray *activityItems = @[shareTitle,
//                                       shareImage,
//                                       shareUrl]; // 必须要提供url 才会显示分享标签否则只显示图片
            NSArray *activityItems = @[shareImage];
            [self showShareAlertWithActivityItems:activityItems];        });
    } failure:^(HFError *error) {
        HFLog(@"error:%@", error);
        [ShowHUD hiddenHUDLoading];
    }];
}

-(void)showShareAlertWithActivityItems:(NSArray *)activityItems{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            [MBProgressHUD showMessage:@"分享成功"];
            [self showShareAlertWithActivityItems:activityItems];
        } else {
//            [MBProgressHUD showMessage:@"分享失败"];
//            [self showShareAlertWithActivityItems:activityItems];
        }
        NSLog(@"activityType: %@,\ncompleted: %d,\nreturnedItems:%@,\nactivityError:%@",activityType,completed,returnedItems,activityError);
    };
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

-(UIImageView *)bgView {
    if (nil == _bgView) {
        _bgView = [UIImageView new];
        _bgView.image = [UIImage imageNamed:@"img_beijing"];
    }
    return _bgView;
}

-(UIImageView *)rightImage {
    if (nil == _rightImage) {
        _rightImage = [UIImageView new];
        _rightImage.image = [UIImage imageNamed:@"img_saoma"];
    }
    return _rightImage;
}

-(UIImageView *)QRImage {
    if (nil == _QRImage) {
        _QRImage = [UIImageView new];
    }
    return _QRImage;
}

-(UIView *)QRBGView {
    if (nil == _QRBGView) {
        _QRBGView = [UIView new];

        _QRBGView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _QRBGView.layer.cornerRadius = 6.2;
        _QRBGView.layer.masksToBounds = YES;
        
        UIView *temp = [UIView new];
        temp.backgroundColor = [UIColor jk_colorWithHexString:@"#D8D8D8"];
        temp.layer.cornerRadius = 3;
        temp.layer.masksToBounds = YES;
        
        [_QRBGView addSubview: temp];
        [temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_QRBGView);
            make.left.top.mas_equalTo(5.0);
        }];
    }
    return _QRBGView;
}

@end
