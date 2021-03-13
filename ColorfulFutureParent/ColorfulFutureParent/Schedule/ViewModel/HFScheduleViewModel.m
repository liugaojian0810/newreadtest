//
//  HFScheduleViewModel.m
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFScheduleViewModel.h"
#import "HFSchedulModel.h"
#import "Service.h"
#import "HFUserManager.h"
#import "HFSchedulDateModel.h"

@implementation HFScheduleViewModel

/**
 请求课表日期
 */

HFArray(dateKeys)
HFArray(dates)
HFArray(va_lue)

-(void)requestScheduleDates{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    WeakSelf
    _fetchGetDatesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service getWithUrl:GetScheduleDatesAPI params:parameters success:^(id responseObject) {
                Strong_Self
                [self.dateKeys removeAllObjects];
                [self.dates removeAllObjects];
                [self.va_lue removeAllObjects];
                NSDictionary *dates =(NSDictionary *)responseObject;
                HFSchedulDateModel *schedule = [HFSchedulDateModel mj_objectWithKeyValues:dates];
                for (NSInteger index = 0; index < schedule.model.count; index++) {
                    HFSchedulDate *date = schedule.model[index];
                    [self.dateKeys addObject:date.week];
                    [self.dates addObject:date.date];
                    [self.va_lue addObject:date.val];
                }
                [subscriber sendCompleted];
            } failure:^(HFError *error) {
                [subscriber sendError:(id)error.errorMessage];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}




-(void)requestScheduleMessage{
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager]getUserInfo];
    [parameters setValue:userInfo.babyInfo.babyID forKey:@"id"];
    [parameters setValue:self.type forKey:@"type"];//1.园长端 2.教师端 3.家长端
    [parameters setValue:@(self.week) forKey:@"week"];//第几周
    [parameters setValue:self.date forKey:@"dataStr"];//第几周
    WeakSelf
    _fetchGetScheduleCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service requestWithUrl:GetScheduleAPI params:parameters method:HTTPRequestMethodGET success:^(id responseObject) {
                Strong_Self
                HFSchedulModel *model = [HFSchedulModel mj_objectWithKeyValues:responseObject[@"model"]];
                self.scheModel = model;
                [subscriber sendCompleted];
            } failure:^(HFError *error) {
                [subscriber sendError:(id)error.errorMessage];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

@end
