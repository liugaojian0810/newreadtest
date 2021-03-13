//
//  HFUserFamilyEditTableViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/11.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFUserFamilyEditTableViewCell.h"
#import <Masonry/Masonry.h>
#import <JKCategories/JKCategories.h>
@implementation HFUserFamilyEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updatePresentWith:(HFBabyModel *)model {
//    for (int i = 0; i < model.parentsInfoVOS.count; i++) {
//        HFParentsInfoVO *present = model.parentsInfoVOS[i];
//        if (i == 0) {
//            self.name.text = [NSString stringWithFormat:@"%@ %@",present.name,present.phone];
//        } else {
//            UILabel *name = [[UILabel alloc]init];
//            name.font = [UIFont fontWithName:@"ARyuanGB-BD" size:14];
//            name.textColor = [UIColor jk_colorWithHexString:@"#915322"];
//            name.text = [NSString stringWithFormat:@"%@ %@",present.name,present.phone];
//            [self.contentView addSubview:name];
//            [name mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.name.mas_left);
//                make.top.equalTo(self.name).offset(20 + 14*i);
//            }];
//        }
//    }
}
- (IBAction)addPresentAction:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

@end
