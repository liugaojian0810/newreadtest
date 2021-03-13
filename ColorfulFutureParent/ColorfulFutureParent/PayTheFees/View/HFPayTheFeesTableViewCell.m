//
//  HFPayTheFeesTableViewCell.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPayTheFeesTableViewCell.h"

@implementation HFPayTheFeesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updataColorView:YES];
}

- (void)setDataModel:(ProjectsListModel *)dataModel {
    _dataModel = dataModel;
    self.selectBtn.selected = dataModel.isSelect;
    self.titleLabel.text = dataModel.paymentProjectName;

    //逾期设置
    NSString *day = @"";
    NSString *dayString1 = dataModel.payTypeList.firstObject.day;
    NSString *dayString2 =dataModel.payTypeList.lastObject.day;
    day = [dataModel.isMonth boolValue] ? dayString1 : dayString2;
    self.day.attributedText = [day stringwith:[UIColor jk_colorWithHexString:@"#666666"] whith:ARYuanMedium(13) with:NSMakeRange(day.length - 1, 1)];
    self.rightView.hidden = [day hasPrefix:@"-"] || [day hasPrefix:@"0"];
    //月缴学期交
    [self updataColorView:[dataModel.isMonth boolValue]];
    NSString *price1 = dataModel.payTypeList.firstObject.money;
    NSString *price2 = dataModel.payTypeList.lastObject.money;
    self.leftTime.text = dataModel.payTypeList.firstObject.cycleEndDate;
    self.middleTime.text = dataModel.payTypeList.lastObject.cycleEndDate;
    if (dataModel.payTypeList.count == 1) {
        if ([dataModel.payTypeList.firstObject.paymentType isEqualToString:@"1"]) {
            self.leftPrice.text = [NSString stringWithFormat:@"一次性缴费：%.2lf元", [price1 doubleValue] * 0.01];
        } else {
            if ([dataModel.payTypeList.firstObject.paymentType isEqualToString:@"2"]) {
                self.leftPrice.text = [NSString stringWithFormat:@"月缴：%.2lf元", [price1 doubleValue] * 0.01];
            } else {
                self.leftPrice.text = [NSString stringWithFormat:@"学期缴：%.2lf元", [price1 doubleValue] * 0.01];
            }
        }
        self.middleView.hidden = YES;
    } else {
        self.middleView.hidden = NO;
        self.leftPrice.text = [NSString stringWithFormat:@"月缴：%.2lf元", [price1 doubleValue] * 0.01];
        self.middlePrice.text = [NSString stringWithFormat:@"学期缴费：%.2lf元", [price2 doubleValue] * 0.01];
    }
}

- (void)updataColorView:(BOOL)isLeftView {
    //左边view
    self.leftView.backgroundColor = isLeftView ? [UIColor jk_colorWithHexString:@"#FEF8F0"]:[UIColor jk_colorWithHexString:@"#F5F6F8"];
    self.leftPrice.textColor = isLeftView ? [UIColor jk_colorWithHexString:@"#FA9030"] : [UIColor jk_colorWithHexString:@"#666666"];
    self.leftTime.textColor = isLeftView ? [UIColor jk_colorWithHexString:@"#FA9030"] : [UIColor jk_colorWithHexString:@"#666666"];
    self.leftView.layer.borderColor = isLeftView ? [UIColor jk_colorWithHexString:@"#FA9030"].CGColor:[UIColor jk_colorWithHexString:@"#F5F6F8"].CGColor;
    self.leftView.layer.borderWidth = 1;
    //右边view
    self.middleView.backgroundColor = !isLeftView ? [UIColor jk_colorWithHexString:@"#FEF8F0"]:[UIColor jk_colorWithHexString:@"#F5F6F8"];
    self.middlePrice.textColor = !isLeftView ? [UIColor jk_colorWithHexString:@"#FA9030"] : [UIColor jk_colorWithHexString:@"#666666"];
    self.middleTime.textColor = !isLeftView ? [UIColor jk_colorWithHexString:@"#FA9030"] : [UIColor jk_colorWithHexString:@"#666666"];
    self.middleView.layer.borderColor = !isLeftView ? [UIColor jk_colorWithHexString:@"#FA9030"].CGColor:[UIColor jk_colorWithHexString:@"#F5F6F8"].CGColor;
    self.middleView.layer.borderWidth = 1;
}

- (IBAction)leftAction:(UIButton *)sender {
    if (self.isMonthBlock) {
        self.isMonthBlock([NSString stringWithFormat:@"%ld-%ld",(long)sender.tag,(long)self.tag]);
    }
}

- (IBAction)selectAction:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock(self.tag);
    }
}

@end
