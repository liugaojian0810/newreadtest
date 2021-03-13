//
//  HFParentScheduleColumnTitle.h
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HFSchedulDetailMessage;

NS_ASSUME_NONNULL_BEGIN

@interface HFParentScheduleColumnTitle : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *week;

@property (nonatomic, strong)HFSchedulDetailMessage *msg;
@end

NS_ASSUME_NONNULL_END
