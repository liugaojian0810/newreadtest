//
//  HFGrowUpCampViewModel.m
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFGrowUpCampViewModel.h"
#import "HFCourseMessage.h"

@implementation HFGrowUpCampViewModel

-(void)getPlayTime{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setValue:@"1" forKey:@"id"];
//    [parameters setValue:self.type forKey:@"type"];
    WeakSelf
    _getPlayTimeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service requestWithUrl:GetCourseCurrentTimeAPI params:parameters method:HTTPRequestMethodGET success:^(id responseObject) {
                Strong_Self
                HFCourseMessage *msg = [HFCourseMessage mj_objectWithKeyValues:responseObject];
                self.timeMsg = msg;
                [subscriber sendCompleted];
            } failure:^(HFError *error) {
                [subscriber sendError:(id)error.errorMessage];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

-(void)getCourseMsg{
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
//    [parameters setValue:@"1" forKey:@"id"];
//    [parameters setValue:self.type forKey:@"type"];
    WeakSelf
    _getCourseMsgCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service requestWithUrl:GetCourseMsAPI params:parameters method:HTTPRequestMethodGET success:^(id responseObject) {
                Strong_Self
                HFCourseMessage *msg = [HFCourseMessage mj_objectWithKeyValues:responseObject];
                self.msg = msg;
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
