//
//  HFInteractiveViewModel.h
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFInteractiveViewModel : HFBaseModel


/**
 参数
 */
//预约和取消预约
@property (nonatomic, strong)NSString *childId;
@property (nonatomic, strong)NSString *employeeId;
@property (nonatomic, strong)NSString *isCancel;

//预约
@property (nonatomic, strong)NSString *appointmentIntervalId;


/**
 预约和取消预约命令
 */
@property (nonatomic, strong)RACCommand *cancelCommand;
@property (nonatomic, strong)RACCommand *aboutCommand;

/**
 预约和取消预约操作
*/
-(void)cancelAction;
-(void)aboutAction;

@end

NS_ASSUME_NONNULL_END
