//
//  UserDataTableViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBabyDataModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^userBabyBlock)(NSInteger row);

@interface UserDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *eidtBut;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (nonatomic, copy) userBabyBlock block;

- (void)updataBaby:(NSDictionary *)dict with:(NSInteger)row with:(HFBabyModel *)model;

@end

NS_ASSUME_NONNULL_END
