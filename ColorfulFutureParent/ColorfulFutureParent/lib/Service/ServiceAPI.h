//
//  ServiceAPI.h
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - hostAPI
/** 测试环境API */
UIKIT_EXTERN NSString *const DevelopBaseAPI;

/** 生成环境API */
UIKIT_EXTERN NSString *const ReleaseBaseAPI;

/** 存储token的Key */
UIKIT_EXTERN NSString *const UserToken;
/** 广告页查询 */
UIKIT_EXTERN NSString *const AdcertisingAPI;
/** 宝宝列表 */
UIKIT_EXTERN NSString *const coutBabyAPI;
/** 宝宝信息查询 */
UIKIT_EXTERN NSString *const GetChildInfoAPI;

/** 家园互动营--取消预约 */
UIKIT_EXTERN NSString *const CancelSubscribeAPI;

/** 家园互动营--预约 */
UIKIT_EXTERN NSString *const SubscribeAPI;
/** 家园互动营--预约列表 */
UIKIT_EXTERN NSString *const SubscribeListAPI;
/** 互动营获取宝宝已预约课程信息 */
UIKIT_EXTERN NSString *const GetMyReservedCourseAPI;

/** 首页关卡预告-预约课程信息查询 */
UIKIT_EXTERN NSString *const HfAppointmentChildenAPI;


/** 家长端 成长营回放列表 */
UIKIT_EXTERN NSString *const GetCoursePlaybackAPI;


/** 家长端 成长营关卡预告+课程直播信息 */
UIKIT_EXTERN NSString *const CurrentCourseAPI;

/** 成长营当前课程信息接口 */
UIKIT_EXTERN NSString *const GetCourseMsAPI;

/** 当前直播播放时间点记录*/
UIKIT_EXTERN NSString *const GetCourseCurrentTimeAPI;

/** 版本升级*/
UIKIT_EXTERN NSString *const VersionUpdateAPI;

#pragma mark - 登录注册相关API
/** 登录 */
UIKIT_EXTERN NSString *const SmsSubmitAPI;

/** 获取验证码 */
UIKIT_EXTERN NSString *const SmsVcode;

/** 退出登录*/
UIKIT_EXTERN NSString *const LetOutUpdateAPI;
/**今日任务互动营*/
UIKIT_EXTERN NSString *const currentCourceDtoAPI;
/**今日任务成长营*/
UIKIT_EXTERN NSString *const alreadyCourceAPI;

/** 获取系统时间*/
UIKIT_EXTERN NSString *const GetSystemTimeAPI;

/** 获取课程表*/
UIKIT_EXTERN NSString *const GetScheduleAPI;

/** 获取课程表(时间轴样式展示)*/
UIKIT_EXTERN NSString *const GetScheduleTimeLineAPI;

/** 答题列表*/
UIKIT_EXTERN NSString *const GetByIdQuestionAPI;
UIKIT_EXTERN NSString *const GetGoIntoRoomStuSaveAPI;

/** 提交答案*/
UIKIT_EXTERN NSString *const GetAnswerAPI;

/** 关卡预告获取视频地址*/
UIKIT_EXTERN NSString *const PlayVideoAPI;
/** 五彩宝石列表*/
UIKIT_EXTERN NSString *const getMulticoloredGemstoneAPI;
/** 五彩宝石详情*/
UIKIT_EXTERN NSString *const saveMulticoloredGemstoneAPI;
/** 订单列表*/
UIKIT_EXTERN NSString *const OrderListAPI;
/** 订单详情*/
UIKIT_EXTERN NSString *const OrderDetailAPI;
/** 课程表时间*/
UIKIT_EXTERN NSString *const GetScheduleDatesAPI;

/** 获得分享二维码 */
UIKIT_EXTERN NSString *const ExtensionExtensionAPI;

/** 判断是否购买课程 */
UIKIT_EXTERN NSString *const checkIsOrderBuyAPI;

/** 课程下单接口 */
UIKIT_EXTERN NSString *const PayGoodsCommodityAPI;

/** 云家园商品详情 */
UIKIT_EXTERN NSString *const CloudHomeDetailAPI;

/** 分享url */
UIKIT_EXTERN NSString *const ShareURLAPI;

/** 缴费消息提示 */
UIKIT_EXTERN NSString *const messageAlertAPI;

/** 家长端获取宝宝应缴费列表 */
UIKIT_EXTERN NSString *const getChildDuesListAPI;
/** 缴费创建订单 */
UIKIT_EXTERN NSString *const paymentOrderAPI;
/** 结余支付发送验证码 */
UIKIT_EXTERN NSString *const paymentSendCodeAPI;
/** 结余支付 */
UIKIT_EXTERN NSString *const balancePayAPI;
/** 查询宝宝缴费历史记录*/
UIKIT_EXTERN NSString *const GetHistoryRecordsURLAPI;

/** 园长协议、合同或者隐私权限政策等接口*/
UIKIT_EXTERN NSString *const GetStaticPageURLAPI;

/** 阅读用户协议后生成用户阅读记录*/
UIKIT_EXTERN NSString *const InsertReadRecordURLAPI;

/** 校验用户是否阅读协议 */
UIKIT_EXTERN NSString *const VerifyIsReadedURLAPI;
