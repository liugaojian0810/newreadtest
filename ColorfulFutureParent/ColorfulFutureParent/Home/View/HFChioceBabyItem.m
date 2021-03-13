//
//  HFChioceBabyItem.m
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/6/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFChioceBabyItem.h"

@implementation HFChioceBabyItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setBabyInfoModel:(HFModel *)babyInfoModel{
    _babyInfoModel = babyInfoModel;
    self.nameLabel.text = babyInfoModel.name;
    if (babyInfoModel.sex == 0) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:babyInfoModel.photo] placeholderImage:[UIImage imageNamed:@"header_boy"]];
    }else{
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:babyInfoModel.photo] placeholderImage:[UIImage imageNamed:@"header_girl"]];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
