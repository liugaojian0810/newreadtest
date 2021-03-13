//
//  UserDataTableViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UserDataTableViewCell.h"

@implementation UserDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updataBaby:(NSDictionary *)dataDic with:(NSInteger)row with:(HFBabyModel *)model{
    self.name.text = dataDic.allKeys.firstObject;
    if ([self.name.text isEqualToString:@"所属幼儿园"] || [self.name.text isEqualToString:@"姓名"] || [self.name.text isEqualToString:@"所属班级"] ) {
        self.eidtBut.hidden = YES;
    }
//    switch (row) {
//    case 0:
//        self.body.text = model.name;
//        
//        break;
//    case 1:
//        self.body.text = model.sex > 0 ? @"女" : @"男";
//        
//        break;
//    case 2:
//        if (model.birth.length > 0 ) {
//            self.body.text = [model.birth substringWithRange:NSMakeRange(0, 10)];
//        }
//        break;
//    case 3:
//        self.body.text = model.kindergartenName;
//        
//        break;
//    case 4:
//            self.body.text = model.className;
//            break;
//    }
}
- (IBAction)btnAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}

@end
