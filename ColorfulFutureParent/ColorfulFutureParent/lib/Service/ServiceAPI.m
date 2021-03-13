//
//  ServiceAPI.m
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//

#import "ServiceAPI.h"

#pragma mark - 测试环境
//NSString *const DevelopBaseAPI = @"https://qcqc.huifanayb.cn";
//NSString *const DevelopBaseAPI = @"https://dev-edu-hfsaas.huifanayb.cn";
NSString *const DevelopBaseAPI = @"https://test-edu-hfsaas.huifanayb.cn";
//NSString *const DevelopBaseAPI = @"https://test-server.huifanayb.cn";


#pragma mark - 生产环境
NSString *const ReleaseBaseAPI = @"https://qcwl.huifanayb.com";
//NSString *const ReleaseBaseAPI = @"https://qcqc.huifanayb.cn";

NSString *const UserToken = @"UserToken";

NSString *const AdcertisingAPI = @"/app/patriarchInfo/adcertising";

NSString *const coutBabyAPI = @"/app/patriarchInfo/cutBoby";


NSString *const GetChildInfoAPI = @"/app/childInfo/getChildInfo";

NSString *const CancelSubscribeAPI = @"/app/homelandinteractcontroller/CancelSubscribe";

NSString *const SubscribeListAPI = @"/app/childInfo/getMyNoReservedCourse";
NSString *const SubscribeAPI = @"/app/homelandinteractcontroller/subscribe";

NSString *const GetMyReservedCourseAPI = @"/app/childInfo/getMyReservedCourse";

NSString *const GetCoursePlaybackAPI = @"/app/childInfo/getCoursePlayback";

NSString *const CurrentCourseAPI = @"/app/patriarchInfo/currentCourse";


NSString *const HfAppointmentChildenAPI = @"/app/childInfo/getCoursePlayback";
/** 成长营当前课程信息接口 */
NSString *const GetCourseMsAPI = @"/app/childInfo/getCoursePlayback";

/** 当前直播播放时间点记录*/
NSString *const GetCourseCurrentTimeAPI = @"/app/childInfo/getCoursePlayback";

/** 版本升级*/
NSString *const VersionUpdateAPI = @"/app/version/getVersion";


#pragma mark - 登录注册相关API

NSString *const SmsSubmitAPI = @"/app/user/login/sms/submit";

NSString *const SmsVcode = @"/app/user/login/sms/vcode";

/** 退出登录*/
NSString *const currentCourceDtoAPI = @"/app/patriarchInfo/alreadyCource";
NSString *const alreadyCourceAPI = @"/app/patriarchInfo/currentCourceDto";
NSString *const LetOutUpdateAPI = @"/app/user/logout"; 

/** 获取系统时间*/
NSString *const GetSystemTimeAPI = @"/app/patriarchInfo/gettingDate";

/** 获取课程表*/
NSString *const GetScheduleAPI = @"/app/curriculum/getClassScheduleCard";

/** 获取课程表(时间轴样式展示)*/
NSString *const GetScheduleTimeLineAPI = @"/app/curriculum/getParentTimetable";


/** 答题*/
NSString *const GetByIdQuestionAPI = @"/app/hfSchedule/getByIdQuestion";
NSString *const GetGoIntoRoomStuSaveAPI = @"app/growthCamp/getGoIntoRoomStuSave";

/** 提交答案*/
NSString *const GetAnswerAPI = @"/app/hfSchedule/getAnswer";
/** 课程预告获取视频地址*/
NSString *const PlayVideoAPI = @"/app/onDemand/playVideo";
/** 五彩宝石列表*/
NSString *const getMulticoloredGemstoneAPI = @"/app/multicoloredgemstone/getMulticoloredGemstoneInfo";
/** 五彩宝石详情*/
NSString *const saveMulticoloredGemstoneAPI = @"/app/multicoloredgemstone/saveMulticoloredGemstone";
/** 订单列表*/
NSString *const OrderListAPI = @"/app/parentsOrder/list";
/** 订单详情*/
NSString *const OrderDetailAPI = @"/app/order/getOrderById";
/** 课程表日期*/
NSString *const GetScheduleDatesAPI = @"/app/curriculum/getWeekDataList";

/** 获得分享二维码*/
NSString *const ExtensionExtensionAPI = @"/app/extension/extension";

/** 判断是否购买课程*/
NSString *const checkIsOrderBuyAPI = @"/app/parentsOrder/checkIsOrderBuy";

/** 课程下单接口*/
NSString *const PayGoodsCommodityAPI = @"/app/extension/v3payGoodsCommodity";

/** 云家园商品详情 */
NSString *const CloudHomeDetailAPI = @"/app/goods/get";

/** 分享url */
NSString *const ShareURLAPI = @"/app/share/url";

/** 缴费消息提示 */
NSString *const messageAlertAPI = @"/app/paymentItemsChild/messageAlert";
/** 家长端获取宝宝应缴费列表 */
NSString *const getChildDuesListAPI = @"/app/paymentChildRelation/getChildDuesList";
/** 缴费创建订单 */
NSString *const paymentOrderAPI = @"/app/payment/order";
/** 结余支付发送验证码 */
NSString *const paymentSendCodeAPI = @"/app/payment/sendCode";
/** 结余支付 */
NSString *const balancePayAPI = @"/app/payment/balancePay";
/** 查询宝宝缴费历史记录*/
NSString *const GetHistoryRecordsURLAPI = @"/app/paymentItemsChild/getHistoryRecords";

/** 园长协议、合同或者隐私权限政策等接口*/
NSString *const GetStaticPageURLAPI = @"/app/agreementTemp/getUserAgreement";

/** 阅读用户协议后生成用户阅读记录*/
NSString *const InsertReadRecordURLAPI = @"/app/agreement/insert";

/** 校验用户是否阅读协议 */
NSString *const VerifyIsReadedURLAPI = @"/app/agreement/checkIsRead";
