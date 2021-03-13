//
//  HFImmediatelyOrderTableViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "HFCouldHomedidDotModel.h"
#import "HUFMyNoReservedCourseListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^reservedCourseBlock)(NSInteger ID);

@interface HFImmediatelyOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *teacherTableView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
- (void)updateSubViewswith:(NSInteger)row model:(HUFList*)model;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (nonatomic, copy)reservedCourseBlock block;

@end

NS_ASSUME_NONNULL_END
