//
//  HFWebManager.h
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/7/6.
//  Copyright © 2020 huifan. All rights reserved.
//  公共网页管理类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFWebUrlModel: HFBaseModel

@property(nonatomic, copy)NSString *agreeName;
@property(nonatomic, copy)NSString *agreeUrl;
@property(nonatomic, copy)NSString *agreeVersion;
@property(nonatomic, copy)NSString *clientType;
@property(nonatomic, copy)NSString *gmtCreate;
@property(nonatomic, copy)NSString *gmtModified;
@property(nonatomic, copy)NSString *isDelete;
@property(nonatomic, copy)NSString *ID;


@end

typedef void(^HFWebManagerBlock)(HFWebUrlModel *urlModel);

typedef void(^HFWebManagerReadRecordBlock)(BOOL haveRead);

@interface HFWebManager : NSObject

HFSingletonH(HFWebManager)

/// 请求协议地址 模态进入一个网页控制器
/// @param webId 请求id
/// @param vc 请求源控制器
/// @param bottomBlock 底部按钮回调
-(void)presentWebWithId:(NSString *)webId fromVc:(UIViewController *)vc bottomBlock:(OptionBlock)bottomBlock;


/// 请求协议地址  不尽兴页面之间的跳转
/// @param webId 请求id
-(void)getWebUrlDotJumpWithId:(NSString *)webId successBlock:(HFWebManagerBlock)success failBlock:(OptionBlock)failBlock;


///  查询协议有没有阅读记录
/// @param webId 请求id
-(void)insertWebReadRecordsWithId:(NSString *)webId successBlock:(OptionBlock)success failBlock:(OptionBlock)failBlock;

/// 阅读用户协议后生成阅读记录
/// @param webId 请求id
-(void)queryReadRecordsWithId:(NSString *)webId successBlock:(HFWebManagerReadRecordBlock)success failBlock:(OptionBlock)failBlock;

/// 返回协议模型
/// @param ID 协议ID
/// @param success 成功回调
/// @param failBlock 失败回调
-(void )getUrlWithId:(NSString *)ID successBlock:(HFWebManagerBlock)success failBlock:(OptionBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
