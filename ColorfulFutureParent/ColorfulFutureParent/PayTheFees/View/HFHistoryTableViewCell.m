//
//  HFHistoryTableViewCell.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFHistoryTableViewCell.h"
#import "UIView+Extension.h"
@implementation HFHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRowModel:(HFPaymentInfoVOList *)rowModel {
    _rowModel = rowModel;
    self.name.text = rowModel.paymentProjectName;
    self.time.text = rowModel.paymentCycle;
    NSString *color = @"#6880FF";
    switch (rowModel.paymentType) {
        case 1:
            self.type.text = @"  一次性缴费  ";
            color = @"#6880FF";
            break;
        case 2:
            self.type.text = @"  按月缴  ";
            color = @"#68B6FF";
            break;
        case 3:
            self.type.text = @"  按学期缴  ";
            color = @"#FA9030";
    }
    self.type.textColor = [UIColor jk_colorWithHexString:color];
    self.type.layer.cornerRadius = 2.5;
    self.type.layer.borderWidth = 0.5;
    self.type.layer.borderColor = [UIColor jk_colorWithHexString:color].CGColor;
    NSString *price = [NSString stringWithFormat:@"¥%.2f",(long)rowModel.money *0.01];
    self.price.attributedText = [price stringwith:[UIColor jk_colorWithHexString:@""] whith:ARYuanbold(13) with:NSMakeRange(0, 1)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
