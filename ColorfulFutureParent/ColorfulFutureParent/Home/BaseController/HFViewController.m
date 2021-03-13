//
//  HFViewController.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFViewController.h"
#import <Masonry/Masonry.h>
#import <JKCategories.h>
#import "HFUIImageView.h"

@interface HFViewController ()
@property(nonatomic, strong) HFUIImageView *baseHeaderImage;
@property(nonatomic, strong) UIButton *btnClose, *backBtn;
@property(nonatomic, strong) UIImageView *baseBGView;
@property(nonatomic, strong) UILabel *titleLab;
@end

@implementation HFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenCloseBtn = NO;
    self.hiddenAllView = NO;
    [self addMySubViews];
    [self setMasonry];
    self.contentView.userInteractionEnabled = YES;
    self.baseHeaderImage.userInteractionEnabled = YES;
    self.baseBGView.userInteractionEnabled = YES;
    
    [self.view sendSubviewToBack: self.contentView];
    [self.view sendSubviewToBack: self.baseBGView];
    // Do any additional setup after loading the view.
}
-(void)addMySubViews {
    self.baseBGView = [UIImageView new];
    self.baseBGView.image = [UIImage imageNamed:@"bg_zhuomian"];
    self.baseBGView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: self.baseBGView];
    [self.baseBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    UIView *bgColor = [UIView new];
    bgColor.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.baseBGView addSubview:bgColor];
    [bgColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [self.view addSubview: self.contentView];
    [self.contentView addSubview: self.bgViewBaseColor];
    [self.view addSubview: self.baseHeaderImage];
    [self.view addSubview: self.btnClose];
    [self.view addSubview: self.backBtn];
    [self.view addSubview: self.titleLab];
}

-(void)setMasonry {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view).offset(0);
        make.centerY.mas_equalTo(self.view).offset(23);
    }];
    
    [self.bgViewBaseColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-27);
        make.top.mas_equalTo(30);
        make.bottom.mas_equalTo(-27);
    }];
    
    [self.baseHeaderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.contentView.mas_top).offset(-65);
    }];
    
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(65.0);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(-10.0);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(60);
        make.top.mas_equalTo(self.view).offset(40);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.baseHeaderImage).offset(0);
        make.top.mas_equalTo(self.baseHeaderImage).offset(51);
    }];
}

-(void)btnCloseClick:(UIButton *) sender {
    [self back];
}

-(void)setHiddenAllView:(BOOL)hiddenAllView {
    _hiddenAllView = hiddenAllView;
    [self.baseHeaderImage setHidden: _hiddenAllView];
    [self.contentView setHidden: _hiddenAllView];
}

-(void)setHiddenCloseBtn:(BOOL)hiddenCloseBtn {
    _hiddenCloseBtn = hiddenCloseBtn;
    [self.btnClose setHidden: _hiddenCloseBtn];
    [self.backBtn setHidden: !_hiddenCloseBtn];
}

-(void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

-(void)setCoverName:(NSString *)coverName {
    _coverName = coverName;
    self.baseHeaderImage.image = [UIImage imageNamed: _coverName];
}
-(void)setBgImageName:(NSString *)bgImageName {
    _bgImageName = bgImageName;
    self.baseHeaderImage.image = nil;
    [self.bgViewBaseColor setHidden:YES];
    self.contentView.image = [UIImage imageNamed: _bgImageName];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-2.0);
        make.centerY.mas_equalTo(-15);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(46);
    }];
    self.titleLab.font = [UIFont boldSystemFontOfSize:20];
    [self.btnClose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(45.0);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(60.0);
    }];
}
-(void)setTitleName:(NSString *)titleName {
    _titleName = titleName;
    self.titleLab.text = _titleName;
}
- (HFUIImageView *)baseHeaderImage {
    if (nil == _baseHeaderImage) {
        _baseHeaderImage = [HFUIImageView new];
        _baseHeaderImage.image = [UIImage imageNamed:@"base_cover_five_color"];
    }
    return _baseHeaderImage;
}

-(UIImageView *)contentView {
    if (nil == _contentView) {
        _contentView = [UIImageView new];
        _contentView.image = [UIImage imageNamed:@"base_out_border"];
    }
    return _contentView;
}

-(UIButton *)btnClose {
    if (nil == _btnClose) {
        _btnClose = [UIButton new];
        [_btnClose setBackgroundImage:[UIImage imageNamed:@"base_right_close"] forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}

-(UIButton *)backBtn {
    if (nil == _backBtn) {
        _backBtn = [UIButton new]; // base_left_back
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"base_left_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)bgViewBaseColor {
    if (nil == _bgViewBaseColor) {
        _bgViewBaseColor = [UIView new];
        _bgViewBaseColor.layer.cornerRadius = 10.0;
        _bgViewBaseColor.layer.masksToBounds = YES;
        _bgViewBaseColor.backgroundColor = [UIColor clearColor];
    }
    return _bgViewBaseColor;
}
-(UILabel *)titleLab {
    if (nil == _titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont fontWithName:@"ARYuanGB-BD" size:30];
        _titleLab.textColor = [UIColor whiteColor];
    }
    return _titleLab;
}
@end
