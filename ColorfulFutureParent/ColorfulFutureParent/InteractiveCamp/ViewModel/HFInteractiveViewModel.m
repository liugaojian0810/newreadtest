//
//  HFInteractiveViewModel.m
//  ColorfulFutureParent
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractiveViewModel.h"

@implementation HFInteractiveViewModel

-(void)aboutAction{
    
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    [parameters setValue:self.childId forKey:@"childId"];
    [parameters setValue:self.employeeId forKey:@"employeeId"];
    [parameters setValue:@"0" forKey:@"isCancel"];
    [parameters setValue:self.appointmentIntervalId forKey:@"appointmentIntervalId"];

//    WeakSelf
    _aboutCommand= [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service getWithUrl:SubscribeAPI params:parameters success:^(id responseObject) {
//                Strong_Self
                [subscriber sendCompleted];
            } failure:^(HFError *error) {
                [subscriber sendError:(id)error.errorMessage];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

-(void)cancelAction{
    
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    [parameters setValue:self.childId forKey:@"childId"];
    [parameters setValue:self.employeeId forKey:@"employeeId"];
    [parameters setValue:@"1" forKey:@"isCancel"];
//    WeakSelf
    _cancelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service getWithUrl:CancelSubscribeAPI params:parameters success:^(id responseObject) {
//                Strong_Self
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
