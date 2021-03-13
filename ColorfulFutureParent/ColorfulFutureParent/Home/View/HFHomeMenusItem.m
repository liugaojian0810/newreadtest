//
//  HFHomeMenusItem.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFHomeMenusItem.h"
#import <Masonry/Masonry.h>
#import <JKCategories/JKUIKit.h>

#import "UILabel+HFLabel.h"
#import "HFLabel.h"

@interface HFHomeMenusItem()
@property(nonatomic, strong) UIImageView *image;
@property(nonatomic, strong) UILabel *labName;
@end

@implementation HFHomeMenusItem

-(instancetype)init {
    if (self == [super init]) {
        [self addMySubViews];
        [self addMasonry];
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void) addMySubViews {
    [self addSubview:self.image];
    [self addSubview:self.labName];
}

-(void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.image.image = [UIImage imageNamed: imageName];
}

-(void)setImageRect:(CGRect)imageRect {
    _imageRect = imageRect;
    self.image.frame = imageRect;
}

-(void)setLabContent:(NSString *)labContent {
    _labContent = labContent;
    self.labName.text = labContent;
}
-(void)setLabRect:(CGRect)labRect {
    _labRect = labRect;
    self.labName.frame = labRect;
}

-(void) addMasonry {
//    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self).offset(10.0);
//        make.centerX.mas_equalTo(self);
//        make.width.height.mas_equalTo(28.0);
//    }];
//
//    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.image);
//        make.height.mas_equalTo(20.0);
//        make.bottom.mas_equalTo(self).offset(-8.0);
//    }];
}

-(UIImageView *)image {
    if (nil == _image) {
        _image = [UIImageView new];
        _image.image = [UIImage imageNamed:@""];
    }
    return _image;
}

-(UILabel *)labName {
    if (nil == _labName) {
        _labName = [UILabel new];
        _labName.text = @"宝贝学语言";
        _labName.textColor = [UIColor whiteColor];
        _labName.font = [UIFont systemFontOfSize:16];
    }
    return _labName;
}

@end
