//
//  HFLessonProtocolController.m
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/7/1.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFLessonProtocolController.h"
#import "UIView+HFCornerRadius.h"
#import <WebKit/WebKit.h>
#import "HFBuyLessonWebController.h"

@interface HFLessonProtocolController ()

@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UIButton *agreeBut;
@property (strong, nonatomic) UIButton *closeBtn;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HFLessonProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rootView setCornerRadius:10];
    self.titleName = @"云家园产品使用协议";
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    self.rootView.layer.shadowColor = [UIColor colorWithRed:208/255.0 green:191/255.0 blue:159/255.0 alpha:1.0].CGColor;
    self.rootView.layer.shadowOffset = CGSizeMake(0,1.5);
    self.rootView.layer.shadowOpacity = 1;
    self.rootView.layer.shadowRadius = 3;
    [self loadWebView];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.rootView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.rootView.mas_top);
        make.bottom.mas_equalTo(self.agreeBut.mas_top).offset(-5);
    }];
    [self.view addSubview: self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rootView.mas_right);
        make.centerY.equalTo(self.rootView.mas_top);
    }];
}

- (IBAction)agreeAction:(UIButton *)sender {
        HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager] getUserInfo];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:SafeParamStr(userInfo.babyInfo.babyID) forKey:@"childrenId"];//购买宝宝ID
    [param setValue:SafeParamStr(userInfo.babyInfo.babyID) forKey:@"ownerId"];
    [param setValue:@1 forKey:@"goodsId"];//商品ID（暂时写死）
    [param setValue:SafeParamStr(userInfo.babyInfo.kgId) forKey:@"kgId"];//幼儿园ID
    [param setValue:@1 forKey:@"payChannel"];//支付渠道 1:app 2:h5
    [param setValue:@3 forKey:@"portType"];//端口类型 1.园长，2教师端，3家长端
    [param setValue:SafeParamStr(userInfo.phone) forKey:@"thisUserTele"];//userName
    [param setValue:@2 forKey:@"type"];//订单类型  1会员，2课程
        [param setValue:SafeParamStr(userInfo.userId) forKey:@"userId"];
        [ShowHUD showHUDLoading];
        [Service postWithUrl:PayGoodsCommodityAPI params:param success:^(id responseObject) {
            [ShowHUD hiddenHUDLoading];
            NSDictionary *dataDic = [responseObject objectForKey:@"model"];
            [self payAtTheCashier:dataDic];
        } failure:^(HFError *error) {
            [ShowHUD hiddenHUDLoading];
            [MBProgressHUD showMessage:error.errorMessage];
        }];
}

- (void)payAtTheCashier:(NSDictionary *)code {
    HFBuyLessonWebController *lessonVc = [[HFBuyLessonWebController alloc] init];
    lessonVc.dataDic = code;
//    lessonVc.url = [NSString stringWithFormat:@"%@/pay/checkoutCounter.html?%u",[ServiceFactory getCurrentBaseAPI],HFRandNum(10000)];
    [self presentViewController:lessonVc animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
- (void)loadWebView {
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - lazy load
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = WKWebViewConfiguration.alloc.init;
        configuration.preferences.javaScriptEnabled = YES;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
//        // 允许手势返回上一级页面
        _webView.allowsBackForwardNavigationGestures = NO;
        
    }
    return _webView;
}

-(UIButton *)closeBtn {
    if (nil == _closeBtn) {
        _closeBtn = [UIButton new];
        WS(weakSelf);
        [_closeBtn jk_touchUpInside:^{
            [weakSelf dismissViewControllerAnimated:NO completion:nil];
        }];
        [_closeBtn setBackgroundImage: [UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}
@end
