//
//  HFAlert.h
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//  公共弹窗

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HFAlertCompletionBlock)(void);

typedef enum : NSUInteger {
    AlertStatusSuccfess, //成功
    AlertStatusWarning,//失败
    AlertStatusError,//警告
} AlertStatus;

@interface HFAlert : NSObject<UIPopoverPresentationControllerDelegate>


+(void)showAlertWithMsg:(NSString *)mes inController:(UIViewController *)vc alertStatus:(AlertStatus)status completeBlock:(HFAlertCompletionBlock)completeBlock;

+(void)showAlertWithMsg:(NSString *)mes inController:(UIViewController *)vc alertStatus:(AlertStatus)status;


-(void)showPopAlertWithBtn:(UIButton *)barBtn popSize:(CGSize)size text:(NSString *)text inController:(UIViewController *)vc;


@end

NS_ASSUME_NONNULL_END
