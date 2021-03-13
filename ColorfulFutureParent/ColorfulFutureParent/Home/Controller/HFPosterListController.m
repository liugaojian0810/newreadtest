//
//  HFPosterListController.m
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPosterListController.h"
#import "HFPosterView.h"
//#import "HFHomeViewModel.h"
#import <UShareUI/UShareUI.h>
#import "UIDevice+HFDevice.h"
#import "HFCreatePosterBottomView.h"
#import "HFLessonDetailModel.h"

@interface HFPosterListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
//@property (nonatomic,strong) HFHomeViewModel * vvModel;
@property (nonatomic,strong) HFPosterView * postView;
@property (nonatomic,strong) HFCreatePosterBottomView *bottomSelectView;

@end

@implementation HFPosterListController


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, HFSTATUS_H + 20, HFCREEN_WIDTH, HFCREEN_HEIGHT - 50 - HFNavHeight-20);
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(instancetype)init {
    
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalPresentationCapturesStatusBarAppearance = YES;
        [UIDevice setVScreen];
    }
    return self;
}

-(HFCreatePosterBottomView *)bottomSelectView{
    if (!_bottomSelectView) {
        _bottomSelectView = [[[NSBundle mainBundle]loadNibNamed:@"HFCreatePosterBottomView" owner:nil options:nil]lastObject];
        _bottomSelectView.frame = CGRectMake(0, HFCREEN_HEIGHT - 50 - HFBOTTOM_H, HFCREEN_WIDTH, 50);
    }
    return _bottomSelectView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self addSubViews];
}

- (void)loadData{
    HFUserInfo * userInfo = [HFUserManager sharedHFUserManager].getUserInfo;
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"earningsSource"] = @"2";//商品类型：1会员卡2 课程
        params[@"portType"] = @"3";//端口类型1.园长，2教师端，3家长端
        params[@"goodsId"] = @"1";
        params[@"parentId"] = userInfo.userId;
        params[@"userId"] = userInfo.babyInfo.babyID;
        params[@"kgId"] = userInfo.babyInfo.kgId;
    WS(weakSelf);
    [ShowHUD showHUDLoading];
    [Service postWithUrl:ExtensionExtensionAPI params:params success:^(id responseObject) {
        [ShowHUD hiddenHUDLoading];
        NSString * url = responseObject[@"model"];//获取二维码链接
        UIImage * img = [weakSelf generateQRCode:url width:100 height:100];//生成二维码
        weakSelf.postView.qrCodeImage.image = img;
    } failure:^(HFError *error) {
        [ShowHUD hiddenHUDLoading];
        [MBProgressHUD showMessage:error.errorMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf dissmissVc];
        });
    }];
}

- (void)shareCode{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *shareImage = [self.postView jk_screenshot];
        //            NSURL *shareUrl = [NSURL URLWithString: url];
        //            NSArray *activityItems = @[shareTitle,
        //                                       shareImage,
        //                                       shareUrl]; // 必须要提供url 才会显示分享标签否则只显示图片
        NSArray *activityItems = @[shareImage];
        [self showShareAlertWithActivityItems:activityItems];
        
    });
}
-(void)showShareAlertWithActivityItems:(NSArray *)activityItems{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            [MBProgressHUD showMessage:@"分享成功"];
        } else {
//            [MBProgressHUD showMessage:@"分享失败"];
        }
        NSLog(@"activityType: %@,\ncompleted: %d,\nreturnedItems:%@,\nactivityError:%@",activityType,completed,returnedItems,activityError);
    };
    [self presentViewController:activityVC animated:YES completion:nil];
}
-(void)addSubViews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomSelectView];

    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    WeakSelf
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
    
    self.bottomSelectView.clickBlock = ^(NSInteger index) {
        Strong_Self
        UIImage * img = [self.postView jk_screenshot];//生成图片
        [self shareType:index image:img];//分享
    };
}

- (void)dissmissVc{
    [UIDevice setHScreen];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"(nonnull NSString *)"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"xibName "owner:nil options:nil].firstObject;
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.0001;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HFPosterView * header = [[NSBundle mainBundle] loadNibNamed:@"HFPosterView" owner:nil options:nil].firstObject;
    header.type = self.fromeType;
    __weak HFPosterView * weakheader = header;
    header.frame = CGRectMake(0, 0, MainScreenWidth, HFheight(665));
    header.btnBlock = ^(NSInteger index) {
        UIImage * img = [weakheader.shareView jk_screenshot];//生成图片
        [self shareType:index image:img];//分享
    };
    [header.lessonImage sd_setImageWithURL:[NSURL URLWithString:self.detailModel.goodsThumbnailUrl] placeholderImage:[UIImage imageNamed:@"cloud_place"]];
    header.presenter.text = [NSString stringWithFormat:@"”%@“",[HFUserManager sharedHFUserManager].getUserInfo.babyInfo.kgName];
    header.priceLab.text = [NSString stringWithFormat:@"%.2f",[self.detailModel.showPrice floatValue] * 0.01];
    self.postView = header;
    return header;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HFheight(665);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
/**
 保存到相册
 */
-(void)saveImageToAlbum:(UIImage*)img{
    [ShowHUD showHUDLoading];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

/// 分享
/// @param type 分享的类型
/// @param img 分享的图片
- (void)shareType:(NSInteger)type image:(UIImage*)img{
        UMSocialPlatformType platform = UMSocialPlatformType_WechatSession;//微信
    if (type==1) {//生成海报
        [self saveImageToAlbum:img];
        return;
    }
    /*
    platform = type==0?UMSocialPlatformType_WechatTimeLine:UMSocialPlatformType_WechatSession;

        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //设置文本
        messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platform messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
     */
    [self shareCode];
}
//  保存到相册必要实现的协议方法, 不然会崩溃
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [ShowHUD hiddenHUDLoading];
    [MBProgressHUD showMessage:@"海报已保存到相册"];
}

@end
