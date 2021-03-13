//
//  HFInteractiveStatusTableViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractiveStatusTableViewCell.h"
#import "NSString+RichString.h"
#import <JKCategories/JKCategories.h>
@implementation HFInteractiveStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setReservedCourseModel:(HFAList *)ReservedCourseModel {
        _ReservedCourseModel = ReservedCourseModel;
    self.topLabel.text = ReservedCourseModel.courseName;
    NSString *middleLabel = [NSString stringWithFormat:@"%@ %@~%@",ReservedCourseModel.teacherName,ReservedCourseModel.startTime,ReservedCourseModel.endTime];
    self.middleLabel.attributedText = [middleLabel stringwith:[UIColor jk_colorWithHexString:@"#8A695E"] whith:[UIFont fontWithName:@"ARyuanGB-MD" size:14] with:NSMakeRange(0, ReservedCourseModel.teacherName.length +1)];
    NSString *bottomLabel = [NSString stringWithFormat:@"预约情况：%ld/%ld",(long)ReservedCourseModel.number,(long)ReservedCourseModel.numberMax];
    self.bottomLabel.attributedText = [bottomLabel stringwith:[UIColor jk_colorWithHexString:@"#6D4F46"] whith:[UIFont fontWithName:@"ARyuanGB-MD" size:14] with:NSMakeRange(5, 1)];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:ReservedCourseModel.coursePhoto]];
    self.backBtn.tag = ReservedCourseModel.hfAppointmentChildenId;
}

- (void)setBackModel:(HUIList *)backModel {
    self.topLabel.text = backModel.courseName;
    NSString *middleLabel = [NSString stringWithFormat:@"%@~%@",backModel.startTime,backModel.endTime];
    self.middleLabel.text = middleLabel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:backModel.coursePhoto]];
    [self.backBtn setTitle:@"回放" forState:UIControlStateNormal];
    self.backBtn.tag = backModel.identifier;
    self.bottomLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelAction:(id)sender {
//    if (self.btnBlock) {
//        self.btnBlock(_model);
//    }
    if (self.cancelBlock) {
        self.cancelBlock(self.backBtn.tag);
    }
}
@end
