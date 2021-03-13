//
//  HFWebViewController.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    
    WebTypeDefault,//默认
    
    WebTypeUserAgreement = 1,//用户协议
    WebTypePrivacyPolicy,//隐私条款
    WebTypeCertificateAuthority,//认证授权
    WebTypePurseAgreement,//《慧赢钱包协议》
    WebTypeRealNameAuth,//实名认证
    WebTypePlatinumMembService,//慧凡韶华铂金卡会员服务协议书
    WebTypeGoldCardMembService,//慧凡韶华金卡会员服务协议书
    WebTypeUpgradeSuppleAgreement,//升级补充协议
    WebTypeGoldCardServiceIndividual,//慧凡韶华金卡会员推广服务协议书（个人）
    WebTypeGoldCardServiceHaveCertificate,//慧凡韶华金卡会员推广服务协议书（有证园）
    WebTypePlatinumServiceIndividual,//慧凡韶华铂金卡会员推广服务协议书（个人）
    WebTypePlatinumServiceHaveCertificate,//慧凡韶华铂金卡会员推广服务协议书（有证园）
    
    //家长端
    WebTypeParentUserAgreement,//柒彩未来家长端用户协议
    WebTypeParentPrivacyPolicy,//柒彩未来家长端隐私政策
    WebTypeProductUsageAgreement,//云家园产品使用协议（家长端）
    WebTypeQuickPaymentAgreement,//快捷支付服务协议
    WebTypeNoticeAssignment,// 耀分期应收账款转让通知书
    WebTypePerraceDetalPay,// 平台交易支付协议

    //教师端
    WebTypeTeacherUserAgreement,//柒彩未来教师端用户协议
    WebTypeTeacherPrivacyPolicy,//柒彩未来教师端隐私政策
    WebTypeTeacherGoldCardMembService,// 慧凡韶华金卡会员服务协议书
    
    //saas
    WebTypeSaaSUserAgreement,//柒彩未来幼教综合管理服务平台用户协议
    WebTypeSaaSPrivacyPolicy,//柒彩未来幼教综合管理服务平台隐私政策
    
} WebType;


@interface HFWebViewController : HFViewController

@property(nonatomic, assign)WebType type;

@property(nonatomic, copy)NSString *url;

@property(nonatomic, copy)NSString *webTitle;

@end

NS_ASSUME_NONNULL_END
