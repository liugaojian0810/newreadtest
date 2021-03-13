//
//  HFUserFamilyEditTableViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/11.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBabyDataModel.h"
#import <UIKit/UIKit.h>

typedef void(^addPresentBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface HFUserFamilyEditTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(nonatomic, strong)addPresentBlock block;
- (void)updatePresentWith:(HFBabyModel *)model;

@end

NS_ASSUME_NONNULL_END
