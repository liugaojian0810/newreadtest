//
//  HFBabyIconAndName.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBabyHeaderAndName.h"
#import <Masonry/Masonry.h>
#import <JKCategories/JKCategories.h>

@interface HFBabyHeaderAndName()
@property(nonatomic, strong) UIView *headerBGView;
@property(nonatomic, strong) UIImageView *header, *bgImage;
@property(nonatomic, strong) UILabel *name;

@end

@implementation HFBabyHeaderAndName

-(instancetype)init {
    if (self == [super init]) {
        [self addMySubViews];
        [self addMasonry];
    }
    return self;
}

-(void) addMySubViews {
    [self addSubview: self.bgImage];
//    [self addSubview:self.headerBGView];
//    [self addSubview:self.header];
    [self addSubview:self.name];
}

-(void)setIsBoy:(BOOL)isBoy {
    _isBoy = isBoy;
    self.bgImage.image = [UIImage imageNamed: _isBoy ? @"home-touxiang-boy" : @"home-touxiang-girl"];

}

-(void) addMasonry {
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
//    [self.headerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(self);
//        make.width.height.mas_equalTo(38.0);
//    }];
//    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.headerBGView);
//        make.width.height.mas_equalTo(34.0);
//    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(42);
        make.height.mas_equalTo(14.0);
        make.centerY.mas_equalTo(self);
    }];
}

-(UIImageView *)header {
    if (nil == _header) {
        _header = [UIImageView new];
        _header.backgroundColor = [UIColor systemPinkColor];
        _header.layer.cornerRadius = 17.0;
        _header.layer.masksToBounds = YES;
    }
    return _header;
}

-(UILabel *)name {
    if (nil == _name) {
        _name = [UILabel new];
        _name.text = @"请登录";
        _name.textColor = [UIColor jk_colorWithHexString:@"#7B4A1D"];
        _name.font = [UIFont systemFontOfSize: 12.0];
    }
    return _name;
}

-(UIView *)headerBGView {
    if (nil == _headerBGView) {
        _headerBGView = [UIView new];
        _headerBGView.backgroundColor = [UIColor jk_colorWithHexString:@"#D2D359"];
        _headerBGView.layer.cornerRadius = 19.0;
        _headerBGView.layer.masksToBounds = YES;
    }
    return _headerBGView;
}

-(UIImageView *)bgImage {
    if (nil == _bgImage) {
        _bgImage = [UIImageView new];
        _bgImage.image = [UIImage imageNamed:@"home-touxiang-boy"];
    }
    return _bgImage;
}
-(void)setBabyInfoModel:(HFModel *)babyInfoModel{
    _babyInfoModel = babyInfoModel;
    self.name.text = babyInfoModel.name;
    [self.header sd_setImageWithURL:[NSURL URLWithString:babyInfoModel.photo]];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.name.text = [dic valueForKey:@"name"];
    self.isBoy = [[dic valueForKey:@"sex"] integerValue] == 0;
}

@end
