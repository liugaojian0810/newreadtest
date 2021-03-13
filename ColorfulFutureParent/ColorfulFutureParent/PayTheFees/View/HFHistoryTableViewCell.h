//
//  HFHistoryTableViewCell.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFPayTheFeesHistoryListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic, strong) HFPaymentInfoVOList *rowModel;
@end

NS_ASSUME_NONNULL_END
