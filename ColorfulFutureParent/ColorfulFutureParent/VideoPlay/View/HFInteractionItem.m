//
//  HFInteractionItem.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractionItem.h"
#import <SDWebImage/SDWebImage.h>

@interface HFInteractionItem()
@property(nonatomic, strong) UIImageView *itemBGView, *itemIMG;
@end
@implementation HFInteractionItem

-(instancetype)init {
    if (self = [super init]) {
        [self addMySubViews];
        [self setMasonry];
    }
    return self;
}

-(void)addMySubViews {
    [self addSubview: self.itemBGView];
    [self addSubview: self.itemIMG];
}

-(void)setMasonry {
    [self.itemBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.itemIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-30.0);
        make.width.height.mas_equalTo(65.0);
    }];
}

-(void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.itemBGView.image = [UIImage imageNamed:_isSelected?@"bg_xuanxiang_b":@"bg_xuanxiang_a"];
}
-(void)setItemIMGURL:(NSString *)itemIMGURL {
    _itemIMGURL = itemIMGURL;
    [self.itemIMG sd_setImageWithURL:[NSURL URLWithString:_itemIMGURL] placeholderImage:[UIImage imageNamed:@""]];
}

-(UIImageView *)itemBGView {
    if (nil == _itemBGView) {
        _itemBGView = [UIImageView new];
    }
    return _itemBGView;
}

-(UIImageView *)itemIMG {
    if (nil == _itemIMG) {
        _itemIMG = [UIImageView new];
    }
    return _itemIMG;
}
@end
