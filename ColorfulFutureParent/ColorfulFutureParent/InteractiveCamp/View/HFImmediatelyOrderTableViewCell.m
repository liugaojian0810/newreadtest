//
//  HFImmediatelyOrderTableViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFImmediatelyOrderTableViewCell.h"
#import <Masonry/Masonry.h>
#import <JKCategories/JKCategories.h>
#import "NSString+RichString.h"
@implementation HFImmediatelyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateSubViewswith:(NSInteger)row model:(nonnull HUFList *)model {
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.coursePhoto]];
    for (UIView *view in self.teacherTableView.subviews) {
        if (view.tag == 444444444) {
            [view removeFromSuperview];
        }
    }
    self.topLabel.text = model.courseName;
    for (int i = 0; i< row; i++) {
        HUFTeacher * tModel = model.teachers[i];
        
        //赋值
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i* 38, 377, 38)];
        UILabel * lab = [[UILabel alloc]init];
        view.tag = 444444444;
        NSString * str = [NSString stringWithFormat:@"%@:%@-%@",tModel.teacherName,tModel.startTime,tModel.endTime];
        lab.textColor = [UIColor jk_colorWithHexString:@"#D4A171"];
        lab.font = [UIFont fontWithName:@"ARYuanGB-BD" size:14];
        [view addSubview:lab];
        //设置富文本
        lab.attributedText = [str stringwith:[UIColor jk_colorWithHexString:@"#8A695E"] whith:[UIFont fontWithName:@"ARyuanGB-MD" size:14] with:NSMakeRange(0, tModel.teacherName.length +1)];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view.mas_centerY);
            make.left.mas_equalTo(view.mas_left);
        }];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont fontWithName:@"ARYuanGB-BD" size:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"预约" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-order"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        btn.tag = tModel.appointmentIntervaID;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view.mas_centerY);
            make.right.mas_equalTo(view.mas_right).offset(-85);
        }];
        [self.teacherTableView addSubview: view];
    }
}

- (void)btnAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}

@end
