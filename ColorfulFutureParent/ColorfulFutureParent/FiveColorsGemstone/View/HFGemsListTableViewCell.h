//
//  HFGemsListTableViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFGetMulticoloredGemstoneInfoModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFGemsListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *leftTopLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong)HFRecordList *rowModel;
@end

NS_ASSUME_NONNULL_END
