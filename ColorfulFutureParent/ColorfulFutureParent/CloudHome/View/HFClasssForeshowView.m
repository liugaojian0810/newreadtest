//
//  HFClasssForeshowView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFClasssForeshowView.h"
#import "NSString+RichString.h"
#import <JKCategories/JKCategories.h>
@implementation HFClasssForeshowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setModel:(HFCourseForeshowModel *)model{
    _model = model;
    self.className.text = self.model.courseName;
    self.des.text = self.model.courseLabel;
    NSString *date = [NSString stringWithFormat:@"授课时间:%@-%@",self.model.teachingDate,self.model.startDate];
    self.date.attributedText = [date stringwith:[UIColor jk_colorWithHexString:@"#90501D"] whith:[UIFont fontWithName:@"ARYuanGB-BD" size:12] with:NSMakeRange(0, 5)];
}
@end
