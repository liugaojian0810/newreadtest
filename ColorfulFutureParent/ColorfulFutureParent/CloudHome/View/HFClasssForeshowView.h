//
//  HFClasssForeshowView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCourseForeshowModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface HFClasssForeshowView : UIView
@property (weak, nonatomic) IBOutlet UILabel *className;//课程名称
@property (weak, nonatomic) IBOutlet UILabel *date;//授课时间
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIView *nullView;
@property (nonatomic,strong)HFCourseForeshowModel * model;

@end

NS_ASSUME_NONNULL_END
