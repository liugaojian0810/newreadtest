//
//  HFClassDetailViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/10.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFClassDetailViewController.h"
#import <JKCategories/JKCategories.h>
#import "UIView+HFDottedLine.h"
#import "HFLessonDetailModel.h"
#import "HFPosterListController.h"
#import "HFPosterController.h"
#import "HFClassTopView.h"
#import "HFPosterTrainViewNewController.h"
#import "UIDevice+HFDevice.h"
#import "HFLessonProtocolController.h"
#import "HFWebManager.h"

@interface HFClassDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *classLeftBackView;
@property (weak, nonatomic) IBOutlet UIView *classRightBackView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *lessonName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *thumImage;
/** 缩略图*/

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *lessonImageView;

@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) HFClassTopView *topView;

@property (nonatomic, strong) UILabel *lessonLab;

@property (nonatomic, strong) HFLessonDetailModel *detailModel;

@end

@implementation HFClassDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.classLeftBackView jk_shadowWithColor:[UIColor blackColor] offset:CGSizeMake(0, 2) opacity:0.2 radius:7];
    [self.classRightBackView jk_shadowWithColor:[UIColor blackColor] offset:CGSizeMake(0, 2) opacity:0.2 radius:7];
    [UIView drawLineOfDashByCAShapeLayer:self.lineView lineLength:1 lineSpacing:3 lineColor:[UIColor jk_colorWithHexString:@"#9F7350"]];
    self.titleName  = @"云家园";
//    self.lessonImageView.image = [UIImage imageNamed:@"img_yunjiayuan_detail"];
//    self.scrollView.contentSize = CGSizeMake(277, 1873);
    [self loadDataSource];
    [self addContainView];
}

#pragma mark - 请求商品详情
- (void)loadDataSource{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager] getUserInfo];

    [param setValue:SafeParamStr(userInfo.userId) forKey:@"userId"];
    [param setValue:SafeParamStr(userInfo.babyInfo.babyID) forKey:@"ownerId"];
    [param setValue:@0 forKey:@"clientType"];// 端类型:0 家长 1 教师 2 园长
    [param setValue:@1 forKey:@"goodsId"];
    [param setValue:@2 forKey:@"earningsSource"];
    [ShowHUD showHUDLoading];
    [Service postWithUrl:CloudHomeDetailAPI params:param success:^(id responseObject) {
        [ShowHUD hiddenHUDLoading];
        NSDictionary *dataDic = [responseObject objectForKey:@"model"];
        HFLessonDetailModel *detailModel = [HFLessonDetailModel mj_objectWithKeyValues:dataDic];
        [self setDataWithSource:detailModel];
    } failure:^(HFError *error) {
        [ShowHUD hiddenHUDLoading];

    }];
}

- (void)setDataWithSource:(HFLessonDetailModel *)detailModel{
    NSString *decodedURL = [detailModel.goodsThumbnailUrl stringByRemovingPercentEncoding];
    HFLog(@"=====%@",decodedURL);
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:detailModel.goodsThumbnailUrl] placeholderImage:[UIImage imageNamed:@"cloud_place"]];
    self.detailModel = detailModel;
    self.price.text = [NSString stringWithFormat:@"%.2f元",[detailModel.showPrice floatValue] * 0.01];
    self.topView.accountLab.text = [NSString stringWithFormat:@"%@人已购买",detailModel.buyNum];
    self.lessonLab.text = detailModel.goodsDetails;
    NSArray *imageNames = [detailModel.goodsDetailsH5 componentsSeparatedByString:@","];
    UIImageView *tempView = nil;
    for (NSString *imageName in imageNames) {
        UIImageView *goladView = [[UIImageView alloc] init];
        [self.containView addSubview:goladView];

        [goladView sd_setImageWithURL:[NSURL URLWithString:imageName] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (nil == tempView) {
                [goladView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(5);
                    make.right.mas_equalTo(-5);
                    make.top.mas_equalTo(self.lessonLab.mas_bottom).offset(5);
                    make.height.mas_equalTo(267).multipliedBy(image.size.width/image.size.height);
                }];
            }else{
                [goladView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(5);
                    make.right.mas_equalTo(-5);
                    make.top.mas_equalTo(tempView.mas_bottom);
                    make.height.mas_equalTo(267).multipliedBy(image.size.width/image.size.height);
                }];
            }
        }];
        
        tempView = goladView;
    }
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tempView.mas_bottom).offset(5);
    }];
    
}

- (void)addContainView {

    self.containView = [[UIView alloc] init];
    [self.scrollView addSubview:self.containView];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.width.mas_equalTo(self.scrollView);
    }];
    self.topView = [[NSBundle mainBundle] loadNibNamed:@"HFClassTopView" owner:nil options:nil].firstObject;
    [self.containView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.containView);
        make.height.mas_equalTo(35);
    }];
    WS(weakSelf);
    self.topView.shareBlock = ^{
        [weakSelf shareAction];
    };
    [self.containView addSubview:self.lessonLab];
    [self.lessonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(5);
    }];
}
- (IBAction)goBuyAction:(UIButton *)sender {
//        HFPlaceOrderViewController *orderVc = [[HFPlaceOrderViewController alloc] init];
//        orderVc.detailModel = self.detailModel;
//        HFLessonProtocolController *lessonProtoVc = [[HFLessonProtocolController alloc] init];
//         lessonProtoVc.url = [[ServiceFactory getCurrentBaseAPI] stringByAppendingString:@"/agreements/a103.html"];
//        [self presentViewController:lessonProtoVc animated:NO completion:nil];
//    [[HFWebManager sharedHFWebManager]presentWebWithId:@"103" fromVc:self bottomBlock:^{
//    }];

}

#pragma mark -- 分享
- (void)shareAction{
    HFPosterListController * poster = [[HFPosterListController alloc] init];
    poster.fromeType = FRIEND;
    poster.detailModel = self.detailModel;
    [self presentViewController:poster animated:YES completion:nil];
}


- (UILabel *)lessonLab {
    if (_lessonLab == nil) {
        _lessonLab = [[UILabel alloc] init];
        _lessonLab.numberOfLines = 0;
        _lessonLab.textColor = [UIColor jk_colorWithHexString:@"#78441B"];
        _lessonLab.font = PingFangRegular(11);
    }
    return _lessonLab;
}
@end
