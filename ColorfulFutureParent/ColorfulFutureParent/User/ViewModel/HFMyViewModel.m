//
//  HFMyViewModel.m
//  ColorfulFutureTeacher_iOS
//
//  Created by 刘高见 on 2020/5/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFMyViewModel.h"

@implementation HFMyViewModel

/**
 版本更新
 */
-(void)getVersion{

    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    [parameters setValue:@"2" forKey:@"terminalPlatform"];
    [parameters setValue:@"1" forKey:@"productPlatform"];
    WeakSelf
    _fetchGetVersionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [Service postWithUrl:VersionUpdateAPI params:parameters success:^(id responseObject) {
                Strong_Self
                self.updateModel = [HFUpdateModel mj_objectWithKeyValues:responseObject[@"model"]];
                //                NSDictionary *res = (NSDictionary *)responseObject;
                //                NSString *version = res[@"version"];
                //                //获取本地软件的版本号
                //                NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                //                if ([version isEqualToString:localVersion]) {
                //                    self.needUpdate = NO;
                //                }else{
                //                    self.needUpdate = YES;
                //                }
                [subscriber sendCompleted];
            } failure:^(HFError *error) {
                [subscriber sendError:(id)error.errorMessage];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}


-(void)letout{
    NSString *phone = [[HFUserManager sharedHFUserManager] getUserInfo].phone;
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    
    [parameters setValue:@"0" forKey:@"clientType"];
    [parameters setValue:phone forKey:@"phone"];

    WeakSelf
    _fetchLetoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [Service postWithUrl:LetOutUpdateAPI params:parameters success:^(NSDictionary *responseObject) {
                Strong_Self
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
