//
//  HFTodayTaskTableViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFTodayTaskTableViewCell.h"
#import "UIView+HFDottedLine.h"
#import "NSString+RichString.h"
#import <JKCategories/JKCategories.h>
@implementation HFTodayTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.shadowColor = [UIColor colorWithRed:208/255.0 green:191/255.0 blue:159/255.0 alpha:1.0].CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(0,1.5);
    self.backView.layer.shadowOpacity = 1;
    self.backView.layer.shadowRadius = 3;

    [UIView drawLineOfDashByCAShapeLayer:self.lineView lineLength:1 lineSpacing:3 lineColor:[UIColor jk_colorWithHexString:@"#9F7350"]];
}
-(void)setModel:(HFTodayTaskListModelElement *)model{
    _model = model;
    self.title.text = [NSString stringWithFormat:@"%@",model.courceName];
    self.teacher.text = [NSString stringWithFormat:@"%@",model.teacherName];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.courseImg]];
    self.subtitle.text = model.courceSystem;
    self.button.tag = model.teacherID;
}

- (void)setOrderRowModel:(HFOrderList *)orderRowModel {
    _orderRowModel = orderRowModel;
    self.button.alpha = 0;
    self.orderCodeLeftNum.constant = 10;
    self.iconImage.hidden = YES;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:orderRowModel.goodsThumbnailUrl]];
    NSString *orderCode = [NSString stringWithFormat:@"订单编号:%@",orderRowModel.orderNo];
    self.date.attributedText = [orderCode stringwith:[UIColor jk_colorWithHexString:@"#D4A171"] whith:[UIFont fontWithName:@"ARYuan-MD" size:11] with:NSMakeRange(5, orderCode.length - 5)];
    self.title.text = orderRowModel.goodsName;
    self.subtitle.text = orderRowModel.sourceUserName;
    self.time.text = [NSString stringWithFormat:@"下单时间：%@",orderRowModel.gmtCreate];
    self.time.hidden = NO;
    NSString *price = [NSString stringWithFormat:@"价格：%.2f元", [orderRowModel.totalAmount integerValue] *0.01];
    self.teacher.attributedText = [price stringwith:[UIColor jk_colorWithHexString:@"#FB7439"] whith:[UIFont fontWithName:@"ARYuan-BD" size:15] with:NSMakeRange(0, orderRowModel.totalAmount.length -1 )];

}

- (IBAction)buttonAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
