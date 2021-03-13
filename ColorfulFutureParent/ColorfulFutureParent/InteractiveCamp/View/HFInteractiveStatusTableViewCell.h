//
//  HFInteractiveStatusTableViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFAMyReservedCourseListModel.h"
#import "HFCoursePlaybackListModel.h"
#import "HUIClassPlayBackModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^InteractiveBlock)(NSInteger classId);

@interface HFInteractiveStatusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (nonatomic, strong) HFAList *ReservedCourseModel;//互动营已预约；
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) HUIList *backModel;//课程回放；
- (IBAction)cancelAction:(id)sender;
@property(nonatomic, copy)InteractiveBlock aboutBlock;
@property(nonatomic, copy)InteractiveBlock cancelBlock;

@end

NS_ASSUME_NONNULL_END
