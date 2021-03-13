//
//  CNCMediaPlayerSDK.h
//  CNCMediaPlayer
//
//  Created by Chen on 2016/12/5.
//  Copyright © 2016年 Chinanetcenter. All rights reserved.
//  Public

#import <AVFoundation/AVFoundation.h>
#import "CNCMediaPlayerComDef.h"

@interface CNCMediaPlayerSDK : NSObject

#pragma mark- 鉴权
/*! @brief 向CNC注册第三方应用。
 *
 * 需要在每次启动第三方应用程序时调用， 此接口为同步接口 网络情况不好时 可能会耗时较长。
 
 * @param   appid    CNC分配给客户的ID
 authKey  CNC分配给客户的key
 * @return 详见错误码CNC_MediaPlayer_ret_Code定义。
 */
+ (CNC_MediaPlayer_ret_Code)regist_app:(NSString *_Nonnull)app_id auth_key:(NSString *_Nonnull)auth_key;

/*! @brief 向CNC注册第三方应用。
 *
 * 需要在每次启动第三方应用程序时调用， 此接口为异步接口 请在调用前监听CNCMediaPlayerSDKInitDidFinishNotification 消息 将返回结果的 NSNotification中的object对象从NSNumber转化为CNC_Ret_Code 错误信息详见错误码CNC_Ret_Code定义 。
 * @param   appid    CNC分配给客户的ID
 authKey  CNC分配给客户的key
 * @return 无。
 */
+ (void)async_regist_app:(NSString *_Nonnull)app_id auth_key:(NSString *_Nonnull)auth_key;


#pragma mark- 日志系统
/*! @brief 打开or关闭日志系统。
 *
 * 打开日志系统会将某些关键步骤的日志存储在设备当中。
 * @param   open    是否开启，开启后本次运行的某些关键步骤日志会被记录到设备当中。
 * @return 详见错误码CNC_MediaPlayer_LogSystem_Err_code定义。
 */
+ (CNC_MediaPlayer_LogSystem_Err_code)log_system_open:(BOOL) open;

/*! @brief 跳转到日志系统交互界面。
 *
 * 该界面展示log列表,并支持email发送到指定邮箱。
 * @return 无。
 */
+ (void) open_log_system_ui;

#pragma mark - 点播缓存设置
/*! @brief 开启点播缓存功能
 *
 * @param   open    是否开启点播缓存功能
 * @param   folderPath  点播缓存文件存放文件夹路径 未传值则默认存放于沙盒Document下的cnc_cache_video目录
 * @return 开启成功返回YES
 */
+ (BOOL)openLocalCache:(BOOL)open withFolderPath:(NSString *_Nullable)folderPath;

/*! @brief 设置点播缓存视频个数上限
 *
 * @param   cacheVideoCount    缓存视频个数上限
 * @return  无
 * @see setLocalCacheVideoSize:
 * @remark  该方法与setLocalCacheVideoSize:若同时设置，则优先生效setLocalCacheVideoSize:
 */
+ (void)setLocalCacheVideoCount:(NSUInteger)cacheVideoCount;

/*! @brief 设置点播缓存视频大小上限
 *
 * @param   cacheVideoSize    缓存视频大小上限
 * @return  无
 * @see setLocalCacheVideoCount:
 * @remark  该方法与setLocalCacheVideoCount:若同时设置，则优先生效setLocalCacheVideoSize:
 */
+ (void)setLocalCacheVideoSize:(NSUInteger)cacheVideoSize;

#pragma mark - 通用方法


/// MD5加密
/// @param inPutText 加密前字符串
/// @return 返回加密后的字符串
+ (NSString *_Nonnull)sdkMD5:(NSString *_Nonnull)inPutText;

/*! @brief 获取SDK类型
 *
 * @return 详见状态码CNCMediaPlayerSDKType定义。
 */
+ (CNCMediaPlayerSDKType)getSDKType;

/*! @brief 设置播放器声音为静音与否
 *
 * @param   mute    <=0 为非静音 || >0 为静音
 * @return  设置成功返回YES
 */
+ (BOOL)setPlyerMute:(int) mute;


/**
 截屏
 @return 返回当前时刻的屏幕截图
 */
+ (UIImage *_Nonnull) screenShot;

/**
 添加水印
 @param image   添加水印的图片
 @param watermark 水印图片
 @param rect    水印在图片中的位置
 @return 返回添加水印后的图片
 */
+ (UIImage *_Nonnull) watermarkWithImage:(UIImage *_Nonnull)image watermark:(UIImage *_Nonnull)watermark inRect:(CGRect)rect;
/**
 设置全局参数
 
 @param value 数值
 @param key 键值
 @return 设置成功与否
 */

/*! @brief 设置全局参数
 *
 * @param value 数值
 * @param key 键值
 * @return 设置成功与否
 */
+ (BOOL)setOptionValue:(NSString *_Nullable)value forKey:(NSString *_Nullable)key;



/**
 开启MUF crash捕捉功能

 @return 是否开启成功
 */
+ (BOOL)openCrashKit;



/**
 muf版本

 @return 版本号
 */
+ (NSString *_Nonnull)mufCrashKitVersion;
/**
 测试异常情况

 @param type 异常情况列表
 */
+ (void)setThrowException:(int)type;


+ (BOOL)openMufKit;
@end
