//
//  HFOrdersCollectionViewCell.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFOrdersCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <JKCategories/JKCategories.h>

#import "UIImageView+HFUIImageView.h"

@interface HFOrdersCollectionViewCell()
@property(nonatomic, strong) UIImageView *image, *orderStatus;
@property(nonatomic, strong) UIView *bottomView;
@property(nonatomic, strong) UILabel *orderName, *price, *orderStates;
@property(nonatomic, strong) UIButton *payBtn;
@end

@implementation HFOrdersCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMySubViews];
        [self addMasonry];
    }
    return self;
}

-(void) addMySubViews {
    [self.contentView addSubview: self.bottomView];
    [self.contentView addSubview: self.image];
    [self.bottomView addSubview: self.orderName];
    [self.bottomView addSubview: self.price];
    [self.bottomView addSubview: self.orderStatus];
    [self.bottomView addSubview: self.payBtn];
}

-(void) addMasonry {
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(2.0);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(70.0);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(85.5);
        make.bottom.mas_equalTo(self).offset(-8.0);
    }];
    
    [self.orderName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8.0);
        make.top.mas_equalTo(24.0);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.orderName);
        make.top.mas_equalTo(self.orderName.mas_bottom).offset(2.0);
    }];
    
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.orderName);
        make.top.mas_equalTo(self.price.mas_bottom).offset(5.0);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8.0);
        make.centerY.mas_equalTo(self.orderStatus);
        make.width.mas_equalTo(54.0);
        make.height.mas_equalTo(24.0);
    }];
}

- (UIImageView *)image {
    if (nil == _image) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 133.5, 70)];
        _image.backgroundColor = [UIColor jk_randomColor];
        UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        [_image setBorderWithCornerRadius:5 borderWidth:0 borderColor: [UIColor redColor] type:corners];
    }
    return _image;
}

-(UIView *)bottomView {
    if (nil == _bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _bottomView.layer.shadowColor = [UIColor colorWithRed:173/255.0 green:136/255.0 blue:61/255.0 alpha:0.24].CGColor;
        _bottomView.layer.shadowOffset = CGSizeMake(1,1);
        _bottomView.layer.shadowOpacity = 1;
        _bottomView.layer.shadowRadius = 8;
        _bottomView.layer.cornerRadius = 5;
    }
    return _bottomView;
}

-(UILabel *)orderName {
    if (nil == _orderName) {
        _orderName = [UILabel new];
        _orderName.font = [UIFont systemFontOfSize: 13.0];
        _orderName.text = @"能量数学班";
        _orderName.textColor = [UIColor jk_colorWithHexString:@"#90501D"];
    }
    return _orderName;
}

-(UIImageView *)orderStatus {
    if (nil == _orderStatus) {
        _orderStatus = [UIImageView new];
        _orderStatus.image = [UIImage imageNamed:@"ic_weizhifu"];
    }
    return _orderStatus;
}

-(UILabel *)price {
    if (nil == _price) {
        _price = [UILabel new];
        _price.font = [UIFont systemFontOfSize: 12.0];
        _price.textColor = [UIColor jk_colorWithHexString:@"#FB7439"];
        _price.text = @"￥99.00";
    }
    return _price;
}

-(UIButton *)payBtn {
    if (nil == _payBtn) {
        _payBtn = [UIButton new];
        [_payBtn setBackgroundImage: [UIImage imageNamed:@"user_ baby_data_btn"] forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    }
    return _payBtn;
}

@end
