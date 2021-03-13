//
//  HFScheduleViewModel.h
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseViewModel.h"
#import "HFSchedulModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFScheduleViewModel : HFBaseViewModel

@property(nonatomic,copy)NSString *tab;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)NSInteger week;
@property(nonatomic,copy)NSString *teamType;
@property(nonatomic,copy)NSString *date;

@property (nonatomic,strong)RACCommand* fetchGetScheduleCommand;
@property (nonatomic,strong)RACCommand* fetchGetDatesCommand;

-(void)requestScheduleMessage;
-(void)requestScheduleDates;

@property (nonatomic, strong)HFSchedulModel *scheModel;
@property (nonatomic, strong)NSMutableArray *dates;
@property (nonatomic, strong)NSMutableArray *dateKeys;
@property (nonatomic, strong)NSMutableArray *va_lue;

@end

NS_ASSUME_NONNULL_END
