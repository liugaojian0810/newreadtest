//
//  HFWebManager.m
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/7/6.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFWebManager.h"
#import "HFWebViewController.h"
#import "ColorfulFutureParent-Swift.h"

@implementation HFWebUrlModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}

@end

@implementation HFWebManager

HFSingletonM(HFWebManager)

-(void)presentWebWithId:(NSString *)webId fromVc:(UIViewController *)vc bottomBlock:(OptionBlock)bottomBlock{
    WeakSelf
    [self getUrlWithId:webId successBlock:^(HFWebUrlModel *urlModel) {
        Strong_Self
        HFCustomAlertController *alert = [[HFCustomAlertController alloc]init];
        alert.urlStr = [[ServiceFactory getCurrentBaseAPI] stringByAppendingString:urlModel.agreeUrl];
        alert.titleStr = urlModel.agreeName ? urlModel.agreeName:[self getWebTitleWithId:webId];
        alert.agreeNameLabel.text = alert.titleStr;
        if ([webId isEqualToString:@"103"]) {
            alert.alertType = HFCustomAlertTypeTypeWebBottomBtn;
            alert.actureClosure = ^{
                bottomBlock();
            };
        } else {
            alert.alertType = HFCustomAlertTypeTypeWebNoBottomBtn;
        }
        [vc presentViewController:alert animated:YES completion:^{
        }];
        
    } failBlock:^{
        
    }];
}


-(void )getUrlWithId:(NSString *)ID successBlock:(HFWebManagerBlock)success failBlock:(OptionBlock)failBlock{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:ID forKey:@"id"];
    [parameters setValue:@"0" forKey:@"clientType"];
    [Service postWithUrl:GetStaticPageURLAPI params:parameters success:^(id responseObject) {
        @try {
            HFWebUrlModel *model = [HFWebUrlModel mj_objectWithKeyValues:responseObject[@"model"]];
            success(model);
        } @catch (NSException *exception) {
            
        } @finally {
            
        }

    } failure:^(HFError *error) {
        [AlertTool showCenterWithText:error.errorMessage duration:2];
        failBlock();
    }];
}


-(void)getWebUrlDotJumpWithId:(NSString *)webId successBlock:(HFWebManagerBlock)success failBlock:(OptionBlock)failBlock{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:webId forKey:@"id"];
    [parameters setValue:@"0" forKey:@"clientType"];
    [Service postWithUrl:GetStaticPageURLAPI params:parameters success:^(id responseObject) {
        HFWebUrlModel *model = [HFWebUrlModel mj_objectWithKeyValues:responseObject[@"model"]];
        success(model);
    } failure:^(HFError *error) {
        [AlertTool showCenterWithText:error.errorMessage duration:2];
        failBlock();
    }];
}

-(WebType)getWebTypeWithId:(NSString *)ID{
    switch ([ID integerValue]) {
        case 111:
        {
            return WebTypeUserAgreement;//用户协议
        }
            break;
        case 112:
        {
            return WebTypePrivacyPolicy;//隐私条款
        }
            break;
            
        case 113:
        {
            return WebTypePlatinumMembService;//慧凡韶华铂金卡会员服务协议书
        }
            break;
        case 114:
        {
            return WebTypeGoldCardMembService;//慧凡韶华金卡会员服务协议书
        }
            break;
            
        case 115:
        {
            return WebTypeUpgradeSuppleAgreement;//升级补充协议
        }
            break;
        case 116:
        {
            return WebTypePurseAgreement;//《慧赢钱包协议》
        }
            break;
        case 118:
        {
            return WebTypePerraceDetalPay;//《平台交易支付协议》
        }
            break;
        case 1:
        {
            return WebTypeCertificateAuthority;//认证授权书
        }
            break;
            
        case 2:
        {
            return WebTypeGoldCardServiceIndividual;//慧凡韶华金卡会员推广服务协议书（个人）
        }
            break;
        case 3:
        {
            return WebTypeGoldCardServiceHaveCertificate;// 慧凡韶华金卡会员推广服务协议书（有证园）
        }
            break;
        case 4:
        {
            return WebTypePlatinumServiceIndividual;//慧凡韶华铂金卡会员推广服务协议书（个人）
        }
            break;
        case 5:
        {
            return WebTypePlatinumServiceHaveCertificate;//慧凡韶华铂金卡会员推广服务协议书（有证园）
        }
            break;
            
        case 101:
        {
            return WebTypeParentUserAgreement;//柒彩未来家长端用户协议
        }
            break;
        case 102:
        {
            return WebTypeParentPrivacyPolicy;//柒彩未来家长端隐私政策
        }
            break;
        case 103:
        {
            return WebTypeProductUsageAgreement;//云家园产品使用协议（家长端）
        }
            break;
        case 104:
        {
            return WebTypeQuickPaymentAgreement;//快捷支付服务协议
        }
            break;
        case 105:
        {
            return WebTypeNoticeAssignment;//耀分期应收账款转让通知书
        }
            break;
            
        case 106:
        {
            return WebTypeTeacherUserAgreement;//柒彩未来教师端用户协议
        }
            break;
        case 107:
        {
            return WebTypeTeacherPrivacyPolicy;//柒彩未来教师端隐私政策
        }
            break;
        case 108:
        {
            return WebTypeTeacherGoldCardMembService;//慧凡韶华金卡会员服务协议书
        }
            break;
        case 109:
        {
            return WebTypeSaaSUserAgreement;//柒彩未来幼教综合管理服务平台用户协议
        }
            break;
        case 110:
        {
            return WebTypeSaaSPrivacyPolicy;//柒彩未来幼教综合管理服务平台隐私政策
        }
            break;
            
        case 1991:
        {
            return WebTypeRealNameAuth;//实名认证
        }
            break;
        default:
        {
            return WebTypeDefault;//默认
        }
            break;
    }
}

-(NSString *)getWebTitleWithId:(NSString *)ID{
    switch ([ID integerValue]) {
        case 111:
        {
            return @"用户协议";//用户协议
        }
            break;
        case 112:
        {
            return @"隐私条款";//隐私条款
        }
            break;
            
        case 113:
        {
            return @"铂金卡会员服务协议书";//慧凡韶华铂金卡会员服务协议书
        }
            break;
        case 114:
        {
            return @"金卡会员服务协议书";//慧凡韶华金卡会员服务协议书
        }
            break;
            
        case 115:
        {
            return @"升级补充协议";//升级补充协议
        }
            break;
        case 116:
        {
            return @"《慧赢钱包协议》";//《慧赢钱包协议》
        }
            break;
        case 118:
        {
            return @"《平台交易支付协议》";//《平台交易支付协议》
        }
            break;
        case 1:
        {
            return @"《认证授权书》";//认证授权书
        }
            break;
            
        case 2:
        {
            return @"金卡会员推广服务协议书（个人）";//慧凡韶华金卡会员推广服务协议书（个人）
        }
            break;
        case 3:
        {
            return @"金卡会员推广服务协议书（有证园）";// 慧凡韶华金卡会员推广服务协议书（有证园）
        }
            break;
        case 4:
        {
            return @"铂金卡会员推广服务协议书（个人）";//慧凡韶华铂金卡会员推广服务协议书（个人）
        }
            break;
        case 5:
        {
            return @"铂金卡会员推广服务协议书（有证园）";//慧凡韶华铂金卡会员推广服务协议书（有证园）
        }
            break;
            
        case 101:
        {
            return @"用户协议";//柒彩未来家长端用户协议
        }
            break;
        case 102:
        {
            return @"隐私条款";//柒彩未来家长端隐私政策
        }
            break;
        case 103:
        {
            return @"云家园产品使用协议";//云家园产品使用协议（家长端）
        }
            break;
        case 104:
        {
            return @"快捷支付服务协议";//快捷支付服务协议
        }
            break;
        case 105:
        {
            return @"耀分期应收账款转让通知书";//耀分期应收账款转让通知书
        }
            break;
            
        case 106:
        {
            return @"用户协议";//柒彩未来教师端用户协议
        }
            break;
        case 107:
        {
            return @" 隐私条款";//柒彩未来教师端隐私政策
        }
            break;
        case 108:
        {
            return @"金卡会员服务协议书";//慧凡韶华金卡会员服务协议书
        }
            break;
        case 109:
        {
            return @"用户协议";//柒彩未来幼教综合管理服务平台用户协议
        }
            break;
        case 110:
        {
            return @"隐私条款";//柒彩未来幼教综合管理服务平台隐私政策
        }
            break;
            
        case 1991:
        {
            return @"实名认证";//实名认证
        }
            break;
        default:
        {
            return @"";//默认
        }
            break;
    }
}


///  查询有没有阅读同意过协议
/// @param webId 请求id
-(void)queryReadRecordsWithId:(NSString *)webId successBlock:(HFWebManagerReadRecordBlock)success failBlock:(OptionBlock)failBlock{
    HFUserInfo *userModel = [[HFUserManager sharedHFUserManager] getUserInfo];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:userModel.userId forKey:@"userId"];
    [parameters setValue:userModel.babyInfo.babyID forKey:@"kgId"];
    [parameters setValue:webId forKey:@"agreeId"];
    [parameters setValue:@"0" forKey:@"ownerType"];
    [parameters setValue:userModel.babyInfo.babyID forKey:@"ownerId"];
    [Service postWithUrl:VerifyIsReadedURLAPI params:parameters success:^(id responseObject) {
        NSDictionary *dict = responseObject[@"model"];
        if ([dict[@"isRead"] boolValue] == YES) {
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(HFError *error) {
        [AlertTool showCenterWithText:error.errorMessage duration:2];
        failBlock();
    }];
}

/// 阅读用户协议后生成阅读记录
/// @param webId 请求id
-(void)insertWebReadRecordsWithId:(NSString *)webId successBlock:(OptionBlock)success failBlock:(OptionBlock)failBlock{
    HFUserInfo *userModel = [[HFUserManager sharedHFUserManager] getUserInfo];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:userModel.userId forKey:@"userId"];
    [parameters setValue:userModel.babyInfo.babyID forKey:@"kgId"];
    [parameters setValue:webId forKey:@"agreeId"];
    [parameters setValue:@"0" forKey:@"ownerType"];
    [parameters setValue:userModel.babyInfo.babyID forKey:@"ownerId"];
    [Service postWithUrl:InsertReadRecordURLAPI params:parameters success:^(id responseObject) {
        success();
    } failure:^(HFError *error) {
        [AlertTool showCenterWithText:error.errorMessage duration:2];
        failBlock();
    }];
}


@end
