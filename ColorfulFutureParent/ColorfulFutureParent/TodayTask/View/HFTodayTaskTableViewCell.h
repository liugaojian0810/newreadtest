//
//  HFTodayTaskTableViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//
#import "HFTodayTaskListModel.h"
#import "HFOrderListModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^buttonBlock)(NSInteger classId);
@interface HFTodayTaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@property (weak, nonatomic) IBOutlet UILabel *teacher;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderCodeLeftNum;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic,strong)HFTodayTaskListModelElement * model;//成长营互动营
@property (nonatomic, strong)HFOrderList *orderRowModel;
@property (nonatomic, copy)buttonBlock block;

@end

NS_ASSUME_NONNULL_END
