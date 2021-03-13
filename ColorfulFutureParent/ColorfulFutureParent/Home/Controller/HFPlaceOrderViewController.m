//
//  HFPlaceOrderViewController.m
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/6/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPlaceOrderViewController.h"
#import "UIView+HFDottedLine.h"
#import "HFBuyLessonWebController.h"
#import "HFLessonDetailModel.h"
#import "HFLessonProtocolController.h"

@interface HFPlaceOrderViewController ()

@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UILabel *lessonname;
@property (weak, nonatomic) IBOutlet UILabel *lessonDetailLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIImageView *lessonImage;
@property (weak, nonatomic) IBOutlet UIButton *payBut;
/** 快捷支付imageView*/
@property (weak, nonatomic) IBOutlet UIImageView *quickPayImage;

/** 分期支付imageView*/
@property (weak, nonatomic) IBOutlet UIImageView *InstallmentImage;
/** 同意按钮*/
@property (weak, nonatomic) IBOutlet UIButton *agreeBut;

/** 分割线*/
@property (weak, nonatomic) IBOutlet UIView *dashLine;

/** 支付方式，默认为快捷支付*/
@property (nonatomic, assign) BOOL isQuickPay;

@end

@implementation HFPlaceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"确认购买";
    [self.agreeBut setImage:[UIImage imageNamed:@"lesson_unagree_icon"] forState:UIControlStateNormal];
    [self.agreeBut setImage:[UIImage imageNamed:@"lesson_agree_icon"] forState:UIControlStateSelected];
    self.agreeBut.selected = YES;
    self.isQuickPay = YES;
    [self setUpBgView];
}

- (void)setUpBgView {
    
   [UIView drawLineOfDashByCAShapeLayer:self.dashLine lineLength:3 lineSpacing:2 lineColor:[UIColor jk_colorWithHexString:@"#CCBFBC"]];    self.rootView.layer.cornerRadius = 10;
    self.rootView.layer.shadowColor = [UIColor colorWithRed:208/255.0 green:191/255.0 blue:159/255.0 alpha:1.0].CGColor;
    self.rootView.layer.shadowOffset = CGSizeMake(0,1.5);
    self.rootView.layer.shadowOpacity = 1;
    self.rootView.layer.shadowRadius = 3;
    self.lessonname.text = self.detailModel.goodsName;
    self.lessonDetailLab.text = self.detailModel.goodsDetails;
    self.priceLab.text = [NSString stringWithFormat:@"%.2f",[self.detailModel.showPrice floatValue] *0.01];
}

#pragma mark - 下单
- (IBAction)placeTheOrder:(UIButton *)sender {
    if (!self.agreeBut.selected) {
        [ShowHUD showHUDWithInfo:@"请先同意课程协议"];
        return;
    }
    NSString *orderType = self.isQuickPay ? @"1":@"2";
    HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager] getUserInfo];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@1 forKey:@"goodsId"];//商品ID
    [param setValue:SafeParamStr(userInfo.username) forKey:@"thisUserTele"];//userName
    [param setValue:SafeParamStr(userInfo.babyInfo.babyID) forKey:@"childrenId"];//购买宝宝ID
    [param setValue:@2 forKey:@"type"];//订单类型  1会员，2课程
    [param setValue:orderType forKey:@"orderType"];//支付方式 1：联动 2：分期
    [param setValue:@1 forKey:@"payChannel"];//支付渠道 1:app 2:h5
    [param setValue:@3 forKey:@"portType"];//端口类型 1.园长，2教师端，3家长端
//    [param setValue: forKey:@"kgId"];//幼儿园ID(家长端暂不传)
    [param setValue:SafeParamStr(userInfo.userId) forKey:@"userId"];
    [ShowHUD showHUDLoading];
    [Service postWithUrl:PayGoodsCommodityAPI params:param success:^(id responseObject) {
        [ShowHUD hiddenHUDLoading];
        HFLog(@"%@",responseObject);
        NSDictionary *dataDic = [responseObject objectForKey:@"model"];
        [self goPaymentWithData:dataDic];
    } failure:^(HFError *error) {
        [ShowHUD hiddenHUDLoading];
        [ShowHUD showHUDWithInfo:error.errorMessage];
    }];
}

- (void)goPaymentWithData:(NSDictionary *)dataDic{
    if (self.isQuickPay) {//快捷支付，跳转公司内部的H5页面
        HFBuyLessonWebController *buyVc = [[HFBuyLessonWebController alloc] init];
        buyVc.dataDic = dataDic;
//        buyVc.url = @"https://fixbug.huifanayb.cn/pay/fastPayment.html";

//        buyVc.url = [NSString stringWithFormat:@"%@/pay/fastPayment.html?%u",[ServiceFactory getCurrentBaseAPI],HFRandNum(10000)];
        [self presentViewController:buyVc animated:YES completion:nil];
    }else {//分期支付，跳转第三方web页面
        NSString *webUrl = [dataDic objectForKey:@"payUrl"];
        HFBuyLessonWebController *buyVc = [[HFBuyLessonWebController alloc] init];
        if (webUrl.length == 0) {
            [ShowHUD showHUDWithInfo:@"下单失败，请重新确认购买"];
            return;
        }
        buyVc.dataDic = dataDic;
        [self presentViewController:buyVc animated:YES completion:nil];
    }
}
#pragma mark - 选择支付方式
- (IBAction)selectPayChannle:(UIButton *)sender {
    UIImage *selectImage = [UIImage imageNamed:@"pay_selected_icon"];
       UIImage *unSelectImage = [UIImage imageNamed:@"pay_unselect_icon"];
       switch (sender.tag) {
           case 14:{
               self.isQuickPay = YES;
               [self.quickPayImage setImage:selectImage];
               [self.InstallmentImage setImage:unSelectImage];
           }
               break;
               
           default:{
               self.isQuickPay = NO;
               [self.quickPayImage setImage:unSelectImage];
               [self.InstallmentImage setImage:selectImage];
           }
               break;
       }
}

#pragma mark - 点击同意按钮

- (IBAction)clickAgreeBut:(UIButton *)sender {
    sender.selected = !sender.selected;
}
#pragma mark - 查看课程协议
- (IBAction)reviewProtoco:(UIButton *)sender {
    
    HFLessonProtocolController *lessonVc = [[HFLessonProtocolController alloc] init];
    lessonVc.url = [ReleaseBaseAPI stringByAppendingString:@"/mh5/patriarchPrivacyPolicy.html"];
    [self presentViewController:lessonVc animated:YES completion:nil];

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
