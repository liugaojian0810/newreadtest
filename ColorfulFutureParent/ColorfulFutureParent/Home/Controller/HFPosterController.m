//
//  HFPosterController.m
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPosterController.h"
#import "HFPosterListController.h"
#import "HFPosterView.h"
#import "HFPosterHeader.h"
#import "UIDevice+HFDevice.h"
@interface HFPosterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) HFPosterView * postView;
@property (nonatomic,strong) HFPosterHeader * header;
@end

@implementation HFPosterController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}
-(instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalPresentationCapturesStatusBarAppearance = YES;
//        [UIDevice setVScreen];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigtionStyle];
    [self addSubviews];
    [self addMasonry];
}
- (void)addSubviews{
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    WS(weakSelf);
    HFPosterHeader * header = [[NSBundle mainBundle] loadNibNamed:@"HFPosterHeader" owner:nil options:nil].firstObject;
    header.backBlock = ^{
        [UIDevice setHScreen];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    self.header = header;
    [self.view addSubview:header];
    [self loadData];
}
- (void)loadData{
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"goodsFlag"] = @"2";//商品类型：1会员卡订单2 课程订单
        params[@"portType"] = @"3";//端口类型1.园长，2教师端，3家长端
    //    params[@"kgId"] = [hfuser];
        params[@"userId"] = [HFUserManager sharedHFUserManager].getUserInfo.userId;
        params[@"ownerId"] = [HFUserManager sharedHFUserManager].getUserInfo.babyInfo.babyID;

    WS(weakSelf);
    [Service postWithUrl:ExtensionExtensionAPI params:params success:^(id responseObject) {
        NSString * url = responseObject[@"model"];//获取二维码链接
        UIImage * img = [weakSelf generateQRCode:url width:40 height:40];//生成二维码
        weakSelf.postView.qrCodeImage.image = img;
        
//                    UIImage *shareImage = [self.bgView jk_screenshot];
        //            NSURL *shareUrl = [NSURL URLWithString: url];
        //            NSArray *activityItems = @[shareTitle,
        //                                       shareImage,
        //                                       shareUrl]; // 必须要提供url 才会显示分享标签否则只显示图片
//                    NSArray *activityItems = @[shareImage];
//                    [self showShareAlertWithActivityItems:activityItems];
    } failure:^(HFError *error) {
        
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

-(void)setNavigtionStyle {
    self.title = @"生成海报";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_left_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addMasonry{
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.header.mas_bottom);
    }];
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
    __weak HFPosterView * weakheader = header;
    header.frame = CGRectMake(0, 0, MainScreenWidth, HFheight(665));
    header.btnBlock = ^(NSInteger index) {
        UIImage * img = [weakheader.shareView jk_screenshot];//生成图片
        [self shareType:index image:img];//分享
    };
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
//    [MBProgressHUD showHUD];
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
}
//  保存到相册必要实现的协议方法, 不然会崩溃
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    [MBProgressHUD hidden];
    [MBProgressHUD showMessage:@"海报已保存到相册"];
}
    // 生成二维码图片
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {

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
@end
