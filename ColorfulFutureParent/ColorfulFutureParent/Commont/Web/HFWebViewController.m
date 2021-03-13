//
//  HFWebViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFWebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
@interface HFWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong)WKWebView *webView;

@end

@implementation HFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.webTitle.length > 0) {
        self.titleName = self.webTitle;
    }

    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.centerY.equalTo(self.view).offset(30);
        make.size.mas_offset(CGSizeMake(395, 180));
    }];
    self.webView.layer.masksToBounds = YES;
    self.webView.layer.cornerRadius = 8;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [ShowHUD showHUDLoading];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc]init];
        _webView.navigationDelegate = self;
    }
    return _webView;;
}

#pragma mark---------WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [ShowHUD hiddenHUDLoading];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [ShowHUD hiddenHUDLoading];
}


@end
