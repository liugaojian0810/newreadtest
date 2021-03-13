//
//  HFSelectTimeViewController.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^selectTimeBlock)(NSString *string);

@interface HFSelectTimeViewController : UIViewController
@property (nonatomic, copy)selectTimeBlock block;
@property (nonatomic, strong)NSArray *gemsTimeArr;
@property (nonatomic, assign)NSInteger statusNum;//1为日期
@end

NS_ASSUME_NONNULL_END
