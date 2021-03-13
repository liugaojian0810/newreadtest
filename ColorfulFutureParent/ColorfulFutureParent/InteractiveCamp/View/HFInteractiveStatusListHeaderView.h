//
//  HFInteractiveStatusListHeaderView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFCoursePlaybackListModel.h"
#import "HFAMyReservedCourseListModel.h"
#import "HUFMyNoReservedCourseListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFInteractiveStatusListHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (nonatomic,strong)HFCoursePlaybackListModelElement * model;//回放model
@property (nonatomic, strong)HFAModel *reservedModel;
@property (nonatomic, strong)HUFModel *noReservedModel;

@end

NS_ASSUME_NONNULL_END
