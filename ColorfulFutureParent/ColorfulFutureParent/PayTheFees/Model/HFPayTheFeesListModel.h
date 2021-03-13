//
//  HFPayTheFeesListModel.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"
@class ProjectsListModel;
@class PayTypeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface HFPayTheFeesListModel : HFBaseModel
@property (nonatomic, copy) NSString *balanceAmount;//结余
@property (nonatomic, strong) NSArray <ProjectsListModel *> *projects;

@end

@interface ProjectsListModel : HFBaseModel
@property (nonatomic, copy) NSString *paymentProjectId;//收费项目ID
@property (nonatomic, copy) NSString *payment_type_default;//收费项目名称
@property (nonatomic, copy) NSString *paymentProjectName;//收费类型:1单次；2按月；3按学期
@property (nonatomic, strong) NSArray <PayTypeListModel *> *payTypeList;
@property (nonatomic, assign) BOOL isSelect;//项目选中
@property (nonatomic, strong) NSString *isMonth;//支付方式选中
@end

@interface PayTypeListModel : HFBaseModel
@property (nonatomic, copy) NSString *cycleEndDate;//缴费结束时间
@property (nonatomic, copy) NSString *money;//缴费金额单位：分
@property (nonatomic, copy) NSString *identifier;//id
@property (nonatomic, copy) NSString *paymentType;//收费类型:1单次；2按月；3按学期
@property (nonatomic, copy) NSString *paymentEndDate;//缴费截止时间
@property (nonatomic, copy) NSString *day;//截止时间



@end

NS_ASSUME_NONNULL_END
