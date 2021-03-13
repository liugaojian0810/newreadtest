//
//  HFScheduleDateSwitch.h
//  ColorfulFutureTeacher_iOS
//
//  Created by 刘高见 on 2020/5/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ScheduleDateSwitchBlock)(NSInteger);

@interface HFScheduleDateSwitch : UITableViewCell

@property (nonatomic, strong)NSArray *names;

@property (nonatomic, copy)ScheduleDateSwitchBlock selectBlock;

@end

NS_ASSUME_NONNULL_END
