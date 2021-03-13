//
//  HFParentScheduleItemOrigin.h
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFParentScheduleItemOrigin : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *date;
@property (weak, nonatomic) IBOutlet UILabel *datePeriod;

@property (nonatomic, copy)NSString *monthStr;

@end

NS_ASSUME_NONNULL_END
