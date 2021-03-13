//
//  HFGemsListTableViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFGemsListTableViewCell.h"
#import "UIView+HFDottedLine.h"
#import <JKCategories/JKCategories.h>

@implementation HFGemsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)layoutSubviews {
    [UIView drawLineOfDashByCAShapeLayer:self.lineView lineLength:3 lineSpacing:3 lineColor:[UIColor jk_colorWithHexString:@"#CCBFBC"]];

}

- (void)setRowModel:(HFRecordList *)rowModel {
    _rowModel = rowModel;
    self.leftBottomLabel.text = [rowModel.createDate substringWithRange:NSMakeRange(0, 10)];
    if ([rowModel.updateType isEqualToString:@"1"]) {
        self.rightLabel.text = [NSString stringWithFormat:@"+%@",rowModel.updateNum];
    } else {
        self.rightLabel.text = [NSString stringWithFormat:@"-%@",rowModel.updateNum];

    }
    switch ([rowModel.source integerValue]) {
        case 1:
            self.leftTopLabel.text = @"登录奖励";
            break;
        case 2:
            self.leftTopLabel.text = @"预约奖励";

            break;
        case 3:
            self.leftTopLabel.text = @"不迟到奖励";

            break;
        case 4:
            self.leftTopLabel.text = @"语音互动奖励";

            break;
        case 5:
            self.leftTopLabel.text = @"触屏互动奖励";

            break;
        case 6:
            self.leftTopLabel.text = @"每节课全勤奖励";

            break;
        case 7:
            self.leftTopLabel.text = @"直播奖励";

            break;
        case 8:
            self.leftTopLabel.text = @"回放奖励";

            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
