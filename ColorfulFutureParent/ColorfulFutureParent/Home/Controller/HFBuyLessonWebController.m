//
//  HFBuyLessonWebController.m
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/6/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBuyLessonWebController.h"
#import "UIDevice+HFDevice.h"
#import <WebKit/WebKit.h>
#import "HomeViewController.h"
@interface HFBuyLessonWebController ()<WKNavigationDelegate,WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong)UIProgressView *progressView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL isbackView;

@end

@implementation HFBuyLessonWebController


-(instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalPresentationCapturesStatusBarAppearance = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.code = self.dataDic[@"code"];
    self.url = self.dataDic[@"cashierUrl"];
    [UIDevice setVScreen];
    [self addMySubViews];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [ShowHUD showHUDLoading];
}

- (void)addMySubViews {
    self.code = self.dataDic[@"code"];
    self.url = self.dataDic[@"cashierUrl"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HFCREEN_WIDTH, 44 + HFSTATUS_H)];
    navigationView.backgroundColor = [UIColor jk_colorWithHexString:@"#FF9120"];
    [self.view addSubview:navigationView];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setImage:[UIImage imageNamed:@"ic_fanhui_bai"] forState:UIControlStateNormal];
    [navigationView addSubview:backBut];
    [backBut addTarget:self action:@selector(gobackPage) forControlEvents:UIControlEventTouchUpInside];
    [backBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(HFSTATUS_H);
        make.bottom.mas_equalTo(navigationView);
        make.width.mas_equalTo(45);
    }];
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont fontWithName:@"ARYuanGB-BD" size:18];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"收银台";
    title.textColor = [UIColor whiteColor];
    [navigationView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(backBut);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(title.mas_bottom).offset(10);
    }];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 44 + HFSTATUS_H, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    self.view.backgroundColor = [UIColor whiteColor];
    self.progressView.progress = 0;
    self.progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self loadWebView];
    [self registerJSMethod];
}
- (void)loadWebView {
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    }

- (void)gobackPage {
    if (self.webView.canGoBack==YES) {
        //返回上级页面
        if (self.isbackView) {
            [self dissmissVcIsComplete:YES];
        } else {
            [self.webView goBack];
        }
        
    }else{
        //退出控制器
        [self dissmissVcIsComplete:NO];
    }
}
#pragma mark -  注册JS方法
- (void)registerJSMethod {
    WKUserContentController *userContenController = [self.webView configuration].userContentController;
    [userContenController addScriptMessageHandler:self name:@"getOrderInfo"];
    [userContenController addScriptMessageHandler:self name:@"goBack"];
    [userContenController addScriptMessageHandler:self name:@"paySuccess"];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    HFLog(@"%@",NSStringFromSelector(_cmd));
    HFLog(@"%@",message.body);
    if ([message.name isEqualToString:@"getOrderInfo"]) {
        [self pustOrderInfo];
    }
    if ([message.name isEqualToString:@"goBack"]) {
           [self dissmissVcIsComplete:YES];
       }
    if ([message.name isEqualToString:@"paySuccess"]) {
        self.isbackView = YES;
       }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *url = navigationAction.request.URL.absoluteString;
    HFLog(@"aaaaaaaaaa%@",url);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dissmissVcIsComplete:(BOOL)isComplete{
    [self removeAllScriptMsgHandle];
    [UIDevice setHScreen];
    if (isComplete) {
      [UIApplication sharedApplication].keyWindow.rootViewController = [HomeViewController new];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - OC 与 JS 交互方法
- (void)pustOrderInfo{
    HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager] getUserInfo];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
  
    [param setValue:SafeParamStr(userInfo.token) forKey:@"token"];
    [param setValue:SafeParamStr(self.code) forKey:@"code"];
    NSString *paramJsonStr = [param jk_JSONString];
   NSString *javaScript = [NSString stringWithFormat:@"acceptOrderInfo(%@)", paramJsonStr];
   [self.webView evaluateJavaScript:javaScript completionHandler:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        [self.progressView setProgress:newprogress animated:YES];
        HFLog(@"aaaaaaa%.2f",newprogress);
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    HFLog(@"aaaaaaa%.2f",self.webView.estimatedProgress);

    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    HFLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
    [ShowHUD hiddenHUDLoading];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    HFLog(@"%@",error)
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    HFLog(@"=====%@",message);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    HFLog(@"控制器释放掉=====");
}

#pragma mark - 移除注册的方法
-(void)removeAllScriptMsgHandle{
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller removeScriptMessageHandlerForName:@"getOrderInfo"];
    [controller removeScriptMessageHandlerForName:@"goBack"];
    [controller removeScriptMessageHandlerForName:@"paySuccess"];
}
#pragma mark - lazy load
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = WKWebViewConfiguration.alloc.init;
        configuration.preferences.javaScriptEnabled = YES;

        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
//        // 允许手势返回上一级页面
        _webView.allowsBackForwardNavigationGestures = NO;
        
    }
    return _webView;
}
@end
