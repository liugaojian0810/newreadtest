//
//  HFHomeItemView.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFHomeItemView.h"
#import <Masonry/Masonry.h>
#import <JKCategories/JKUIKit.h>

#import "UILabel+HFLabel.h"
#import "HFLabel.h"

@interface HFHomeItemView()
@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) HFLabel *labName;
@end

@implementation HFHomeItemView

-(instancetype)init {
    if (self == [super init]) {
        [self addMySubViews];
        [self addMasonry];
    }
    return self;
}

-(void) addMySubViews {
    [self addSubview:self.icon];
    [self addSubview:self.labName];
}

-(void) addMasonry {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10.0);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(50);
    }];
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.icon);
        make.height.mas_equalTo(20.0);
        make.bottom.mas_equalTo(self).offset(-8.0);
    }];
}

-(UIImageView *)icon {
    if (_icon == nil) {
        _icon = [UIImageView new];
//        _icon.image = [UIImage imageNamed:@"1"];
    }
    return _icon;
}

-(void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    self.icon.image = [UIImage imageNamed: _iconName];
}

-(void)setName:(NSString *)name {
    _name = name;
    self.labName.text = name;
}

-(HFLabel *)labName {
    if (nil == _labName) {
        _labName = [HFLabel new];
        _labName.alpha = 0.0;
        _labName.edgeInsets = UIEdgeInsetsMake(4, 10, 4, 10);
        _labName.text = @"测试";
        _labName.textAlignment = NSTextAlignmentCenter;
        _labName.font = [UIFont boldSystemFontOfSize: 11.0];
        _labName.backgroundColor = [UIColor whiteColor];
        _labName.textColor = [UIColor colorWithRed:43/255.0 green:57/255.0 blue:91/255.0 alpha:1.0];
        _labName.layer.cornerRadius = 10.0;
        _labName.layer.masksToBounds = YES;
    }
    return _labName;
}

@end
