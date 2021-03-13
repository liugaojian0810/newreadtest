//
//  CNCMediaPlayerController.h
//  CNCMediaPlayer
//
//  Created by Hjf on 16/9/22.
//  Copyright © 2016年 Chinanetcenter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CNCMediaPlayerComDef.h"
NS_ASSUME_NONNULL_BEGIN

/**
 超分辨率-IV API
 超分辨率显示模式枚举
 */
typedef NS_ENUM(NSInteger, CNCMediaPlayerLibIVDisplayMode) {
    CNCMediaPlayerLibIVDisplayMode_LR,//渲染画面显示原始视频
    CNCMediaPlayerLibIVDisplayMode_LRSR,//渲染画面显示对比视频,根据percent比例调整显示比例
    CNCMediaPlayerLibIVDisplayMode_SR//渲染画面显示超分视频
};


/**
 超分辨率-IV API
 超分辨率部分参数数据回调block
 
 @param detect_fps 当前渲染实时帧率
 @param detect_value 探测当前视频渲染320*180p的分辨率所花的时间 单位ms
 @param output_w 超分处理后输出的分辨率宽
 @param output_h 超分处理后输出的分辨率高
 */
typedef void (^CNCMediaPlayerLibIVStateInfoBlock)(float detect_fps, double detect_value, int output_w, int output_h);


@interface CNCMediaPlayerController : NSObject

//播放器view，渲染数据的载体
@property (nonatomic, readonly) UIView  * _Nullable view;



#pragma mark - 属性:播放状态

//可播放缓存时长 该值取视频和音频的最小缓存
@property (nonatomic, readonly) NSTimeInterval  cacheDuration;

//可播放视频缓存时长
@property (nonatomic, readonly) NSTimeInterval  videoDuration;

//可播放音频缓存时长
@property (nonatomic, readonly) NSTimeInterval  audioDuration;

//播放状态，详见播放状态CNCMediaPlayerbackState定义
@property (nonatomic, readonly) CNCMediaPlayerbackState   playbackState;

//加载状态，详见加载状态CNCMediaLoadstate定义
@property (nonatomic, readonly) CNCMediaLoadstate       loadState;

//视频时长, 点播视频总时长，直播无该值
@property (nonatomic, readonly) NSTimeInterval  duration;

//可播放时长 该值永远小于等于duration
@property (nonatomic, readonly) NSTimeInterval  playableDuration;

//是否正在播放
@property (nonatomic, readonly) BOOL    isPlaying;

//是否停止播放
@property (nonatomic, readonly) BOOL    isStop;

//是否准备好播放
@property (nonatomic, readonly) BOOL    isPrepareToPlay;

//首屏时间
@property (nonatomic, assign, readonly) NSTimeInterval firstFrameTimeCost;

// 是否处于录制状态
@property (nonatomic, readonly) BOOL    isRecording;

#pragma mark - 属性:音/视频信息
//当前播放地址
@property (nonatomic, readonly) NSString * _Nullable currentUrl;

//视频格式
@property (nonatomic, readonly) NSString * _Nullable videoFormat;

//视频编码格式
@property (nonatomic, readonly) NSString * _Nullable vcodec;

//音频编码格式
@property (nonatomic, readonly) NSString * _Nullable acodec;

//视频宽度
@property (nonatomic, readonly) int      width;

//视频高度
@property (nonatomic, readonly) int      height;

//视频头信息中的帧率
@property (nonatomic, readonly) float    fpsInMeta;

//实时帧率
@property (nonatomic, readonly) float    fpsInOutput;

//视频平均帧率
@property (nonatomic, readonly) float    avgFpsInOutput;

//声道（当前识别Mono和stereo，其他声道输出数字）
@property (nonatomic, readonly) NSString * _Nullable channels;

//传输速度，仅限tcp协议
@property (nonatomic, readonly) NSString * _Nullable tcpTransportSpeed;

//音频采样率
@property (nonatomic, readonly) int      sampleRate;

//当前已播放平均码率
@property (nonatomic, readonly) float   total_bitrate;

//meta码率
@property (nonatomic, readonly) float   bitrate;

// prepare所花时间
@property (nonatomic, readonly) float prepareDuraion;


#pragma mark - 属性:配置参数 rw
//获取or设置 自动播放 1）YES：加载后自动开始播放 2）NO：加载后不播放，暂停状态
@property (nonatomic) BOOL  shouldAutoPlay;

//视频比例， 详见视频比例CncMpVideoScalingMode定义
@property (nonatomic) CncMpVideoScalingMode scalingMode;

//延时追赶 1）YES：当缓存大于maxCacheTime时，会清除内存临时缓存，以播放最新的数据 2）NO：关闭该功能
@property (nonatomic, assign) BOOL shouldAutoClearCache;

//低延时模式，使用变速播放进行延时追赶,仅供测试 暂不提供使用
@property (nonatomic, assign) BOOL shouldLowLatencyMode;

//直播时的延时追赶时间 本地缓存cacheDuration超过maxCacheTime后，播放最新视频信息，单位是毫秒
@property (nonatomic) NSTimeInterval    maxCacheTime;

//缓冲时长 最低播放时长，即至少加载minBufferTime可进行播放，单位是毫秒
@property (nonatomic) NSTimeInterval    minBufferTime;

//缓冲时长 最低播放大小，即至少加载minBufferByte可进行播放，单位是字节
@property (nonatomic) NSInteger    minBufferByte;


//缓存数据上限 视频本地临时缓存上限（位于内存），即加载至maxBufferSize达到饱和状态，单位是MB
@property (nonatomic) CGFloat    maxBufferSize;

//解码方式，详见CNCMediaVideoDecoderMode定义
@property (nonatomic) CNCMediaVideoDecoderMode  videoDecoderMode;

// 后台播放 1）YES允许后台播放  2）NO禁止后台播放
@property (nonatomic) BOOL  ableVideoPlayingInBackground;

//后台解码,允许后台播放下设置该变量生效，只针对软解，1）YES：程序在后台时，只进行音频解码，不进行视频解码 2）进入后台，音视频仍旧在解码
@property (nonatomic) BOOL  disableVideoDecodeInBackground;

//播放模式，详见CNCMediaPlayerMode定义
@property (nonatomic) CNCMediaPlayerMode  playMode;

//日志控制 详见CNC_MediaPlayer_Loglevel定义
@property (nonatomic) CNC_MediaPlayer_Loglevel logLevel;

//是否开启秒开 YES/NO， 需要在prepare之前设置
@property (nonatomic) BOOL  accelerateOpen;

//是否开启超级秒开 YES/NO， 需要在prepare之前设置
@property (nonatomic) BOOL  superAccelerate;

//是否开启hls码率自适应，与默认设置hls码率不冲突，但当手动设置一次后，自动适应失效
@property (nonatomic, assign) BOOL HLSAdaptation;

//设置默认播放的hls码率，需要知道多码率列表的具体码率值，设置才会生效
@property (nonatomic) int64_t defaultHLSBitrate;

//设置预加载阈值大小
@property (nonatomic) NSUInteger preloadBufferByte;

/**
 *  系统音频兼容
 *  是否兼容其他后台播放器，如其他音乐播放器等
 *  NO：其他播放器在后台时能够在启用播放器时使其他app的播放器暂停，但是此时后台播放打开时，正在后台播放的播放器可能在受到来电或者Siri干扰后，无法重启播放。
 *  YES:其他播放器在后台时能够在启用播放器时不会暂停，会同时播放，但是此时后台播放打开时，正在后台播放的播放器可能在受到来电或者Siri干扰后，能正常重启播放。
 */
@property (nonatomic) BOOL  mixOtherPlayer;

/**
 *  点播精准seek
 *  YES:seek时直接播放当前时间点的画面
 *  NO:seek时播放当前时间点所在gop的i帧
 */
@property (nonatomic) BOOL enableAccurateSeek;

/**
 *  点播循环播放次数
 *  设置为0:重复循环播放
 *  设置为大于0:循环播放设置次数
 */
@property (nonatomic) NSUInteger loop;


//当前播放视频时间点,seek 调用 setCurrentPlaybackTime prepare之后设置
@property (nonatomic) NSTimeInterval currentPlaybackTime;

//播放速率 精确到小数点后一位 范围0.5~2.0 prepare之后设置
@property (nonatomic) float playBackRate;

//设置当前播放器的音量大小。注意:不是系统音量 取值 [0.0,1.0]
@property (nonatomic) float playbackVolume;

//设置当前播放器静音与否静音
@property (nonatomic) BOOL mute;

//开启DNS缓存超时策略 单位毫秒 设为0时清空当前dns缓存 需要在prepare之前设置
@property (nonatomic) NSUInteger cncDNSTimeout;

//设置连接超时策略 单位毫秒，当连接等待超过预设值时，返回超时错误 需要在prepare之前设置
@property (nonatomic) NSUInteger cncConnectTimeout;

#pragma mark - 方法:初始化
///**
// *  初始化 只能通过此方法创建播放器对象
// *
// *  @param url 播放的视频地址
// *  @return CNCMediaPlayerController对象
// */
//- (instancetype _Nullable )initWithContentURL:(NSURL *_Nullable)url NS_DESIGNATED_INITIALIZER;

/**
 *  初始化 只能通过此方法创建播放器对象
 *
 *  @param url 播放的视频地址
 *  @param option 需要初始化时配置的参数，正常启用可以不需要设置
 *  @return CNCMediaPlayerController对象
 */
- (instancetype _Nullable )initWithContentURL:(NSURL *_Nullable)url option:(NSDictionary *_Nullable) option NS_DESIGNATED_INITIALIZER;

#pragma mark - 方法:播放相关

/**
 *  预准备播放
 *
 *  异步操作，成功则发出CNCMediaPlayerLoadDidPrepareNotification通知，也可通过isPrepareToPlay进行判断
 */
- (void)prepareToPlay;

- (void)play;//播放
- (void)pause;//暂停
- (void)stop;//停止
- (void)shutdown;//销毁播放器
/**
 *  重新拉流
 *
 *  @param contentURL 为nil时则默认为当前播放的contentURL
 *  @param fromstart  YES从头开始播放，NO继续播放
 */
- (void)reloadWithContentURL:(NSURL *_Nullable)contentURL fromStart:(BOOL)fromstart;

/**
 *  获取硬解是否正常开启
 *  @return YES 硬解开启成功|NO硬解开启失败
 */
- (BOOL) is_vtb_open;

#pragma mark- 录制/截屏相关
/**
 开始录制视频
 @param filename    录制输出文件名称
 @param format      录制输出文件格式目前支持gif/MP4/FLV
 @param maxTime     录屏的最长时间单位(ms)是、GIF最大不超过3000ms MP4/FLV最大不超过60000ms
 @param minTime     录屏的最短时间单位(ms)是、GIF最小低于100ms MP4/FLV最大小不低于30000ms
 @return -1         开始失败 其他值表示成功
 */
- (int)startRecordingWithFilename:(NSString *)filename format:(NSString *)format minTime:(int) minTime maxTime:(int)maxTime;

/**
 开始录制视频
 @param filename    录制输出文件名称
 @param format      录制输出文件格式目前支持gif/MP4/FLV
 @param maxTime     录屏的最长时间单位(ms)是、GIF最大不超过3000ms MP4/FLV最大不超过60000ms
 @param minTime     录屏的最短时间单位(ms)是、GIF最小低于100ms MP4/FLV最大小不低于30000ms
 @param scale       format为@"gif"时有效，控制gif缩放比例 范围在270~480
 @return -1         开始失败 其他值表示成功
 */
- (int)startRecordingWithFilename:(NSString *)filename format:(NSString *)format minTime:(int) minTime maxTime:(int)maxTime gifScale:(int)scale;

/**
 结束录制视频
 @return YES 结束录制成功，也可通过通知CNCMediaPlayerStatusCodeNotification异步获取
 */
- (BOOL) stopRecording;

/**
 删除录制异常中存在的临时文件
 */
+ (void) clearTmpRecordingfiles;

/**
 显示录屏控制视图

 @param recorderCtrlView 控制录屏的视图
 @param type 录屏类型
 @return 是否显示成功
 */
- (BOOL)showRecorderView:(nonnull UIView *) recorderCtrlView type:(CNC_MediaPlayer_Screen_Record_Type) type;

/**
 显示录屏控制视图,并指定录制的范围(图层)

 @param recorderCtrlView 控制录屏的视图
 @param toRecordView 需要录制的图层
 @param type 录屏类型
 @return 是否显示成功
 */
-(BOOL)showRecorderView:(nonnull UIView *)recorderCtrlView toRecordView:(UIView *_Nullable)toRecordView type:(CNC_MediaPlayer_Screen_Record_Type)type;

/**
 隐藏录屏控制视图
 与
 - (BOOL)showRecorderView:(nonnull UIView *) recorderCtrlView type:(CNC_MediaPlayer_Screen_Record_Type) type
 对应，用于隐藏/移除录屏控制视图
 */
-(void)hideRecorderCtrlView;


/**
 显示录屏控制视图,并指定录制的范围(图层且任意区域)
 显示录屏控制视图,并指定录制的范围(图层)
 
 @param recorderCtrlView 控制录屏的视图
 @param toRecordView 需要录制的图层
 @param type 录屏类型
 @param option 额外参数，目前支持rect字段，可在指定toRecordView中裁剪相应区域进行录屏
 @return 是否显示成功
 */
-(BOOL)showRecorderView:(UIView *)recorderCtrlView toRecordView:(UIView *_Nullable)toRecordView type:(CNC_MediaPlayer_Screen_Record_Type)type option:(NSDictionary *_Nullable) option;

/**
 开始录制屏幕
 @param filename            录屏输出文件名称
 @param format              录制输出文件格式目前支持mov
 @param minTime             录屏的最长时间单位(ms)最大不超过6000ms
 @param minTime             录屏的最短时间单位(ms)最大小不低于3000ms
 @param handler             录屏开始的回调,正常开始error为nil，若为SDK自动结束录制，handle中的error会附带录制成功或录制失败的信息
 @param exceptionHandler    录屏过程中的异常回调,例如磁盘空间不足/录制时间不足/超出时限/异常中断等回调
 @return                    -1 开始失败 其他值表示成功
 */
- (int)startScreenRecordWithFilename:(NSString *_Nonnull)filename  format:(NSString *_Nonnull)format minTime:(int) minTime maxTime:(int)maxTime handler:(nullable void(^)(NSError * __nullable error))handler exceptionHandler:(nullable void(^)(NSDictionary * __nullable object,NSError * __nullable error))exceptionHandler;

/**
 结束录制屏幕
 @para handle 主动调用stopScreenRecord后，若是录制失败，handle中的error参数会附带错误信息
 @return dictionary有值 结束录制成功  dictionary为nil则结束录制失败
 */
- (NSDictionary *_Nonnull)stopScreenRecordWithHandler:(nullable void(^)(NSDictionary * __nullable object, NSError * __nullable error))handler;

/**
 取消录制屏幕
 @para handle handle中的error参数会附带错误信息
 @return YES 结束录制成功
 */
- (int)discardScreenRecordWithHandler:(nullable void(^)(NSError * __nullable error))handler;


/**
 重新录屏,取消之前录制的结果,录制文件及产生的临时文件被删除,录制界面恢复开始录制之前的界面.可重新开始录制
 @param handler 异常回调
 @return 重置成功与否返回值 大于0成功
 */
-(int)resetScreenRecordWithHandler:(void (^_Nullable)(NSError * _Nullable))handler;


/**
 获取当前录屏的时间
 @return 录屏的时间单位毫秒
 */
-(CGFloat)screenRecordTime;


/**
 当前录制的时长
 @return 返回当前录制的视频/GIF时长，单位毫秒
 */
- (int) recordingDuration;


#pragma mark- 时移功能
/**
 *  设置时移key和上限value    如果要加载其他URL或者重新设置key和maxtime，需要先调用closeTimeShift
 *  @param key  时移参数 nil为默认值
 *  @param maxtime  时移上限时间
 */
- (void)openTimeshiftWithKey:(NSString *_Nullable)key andMaxTime:(NSInteger)maxtime;

/**
 *  时移开启下调用生效，时移至time时间前
 *  @param time 要时移的时间
 */
- (void)timeshiftWithtime:(NSInteger)time;

/**
 *  关闭时移
 */
- (void)closeTimeShift;


#pragma mark - 网络代理
/**
 打开socks5代理功能，代理互斥，开启socks5则关闭socks4及HTTP/HTTPS代理

 @param     user    用户名
 @param     pwd     密码
 @param     ip      ip地址
 @param     port    端口号
 @return 返回小于0为失败
         -1:ip为空
         -2:port为空
         -3:user为空
         -4:pwd为空
 */
- (int)enableSocks5:(NSString *_Nonnull) user pwd:(NSString *_Nonnull) pwd ip:(NSString *_Nonnull) ip port:(NSString *_Nullable)port;


/**
 打开socks4代理功能 开启socks4则关闭socks5及HTTP/HTTPS代理
 @param ip ip地址
 @param port 端口号
 @return 返回小于0为失败
         -1:ip为空
         -2:port为空
 */
- (int)enableSocks4WithIP:(NSString *_Nonnull) ip port:(NSString *_Nonnull)port;

/**
 开启HTTP/HTTPS 代理 开启HTTP/HTTPS 则关闭socks4及socks5代理

 @param user 用户名
 @param pwd 密码
 @param ip ip地址
 @param port 端口号
 @param https BOOL 是否HTTPS
 @return 返回小于0为失败
         -1:ip为空
         -2:port为空
 
 */
- (int)enableHttpProxyWithUsername:(NSString *_Nullable) user pwd:(NSString *_Nullable) pwd IP:(NSString *_Nonnull) ip port:(NSString *_Nonnull)port isHtpps:(BOOL) https;

/**
 关闭socks5功能
 @return 关闭成功与否返回小于0为失败
 */
- (int)disableSocks5;


#pragma mark - hls码率自适应

/**
 关闭hls码率自适应
 @return 关闭成功与否返回 小于0为失败
 */
- (BOOL)closeHLSAdaptation;

/**
 播放过程中手动设置hls播放码率
 @param bitrate 设置的码率
 @return 设置成功与否返回 小于0为失败
 */
- (BOOL)selectBitrate:(int64_t)bitrate;


#pragma mark - HLS & MP4解密
/**
 开启/关闭HLS解密功能
 @param isOpen 是否开启
 @param videoID 加密视频的videoID
 需要在prepare之前设置
 */
- (BOOL)openHLSEncryption:(BOOL)isOpen withVideoID:(NSString *_Nonnull)videoID;


/**
 开启/关闭HLS解密功能
 @param isOpen 是否开启
 需要在prepare之前设置
 */
- (void)openMp4DRM:(BOOL)isOpen;

#pragma mark - CNC Dash


/**
 在拉取Dash协议的流时，启播之前设置默认启播Bandwidth，用于已知流存在这一Bandwidth时生效，若指定Bandwidth不存在，则不生效。
 需要在prepare之前设置
 @param videoBandwidth 启播视频Bandwidth
 @param audioBandwidth 启播音频Bandwidth
 @return 0 为成功

 */
- (int)setDefaultDashVideoBandwidth:(int) videoBandwidth audioBandwidth:(int) audioBandwidth;


/**
 在拉取Dash协议的流时，启播之前设置Dash Bandwidth列表获取回调
 需要在prepare之后设置

 @param vBlock 视频Bandwidth列表获取回调
 @param aBlock 音频Bandwidth列表获取回调
 @return 0 为成功
 */
- (int)setDashVideoBandwidthBlock:(CNCMediaPlayerDashBandWidthListBlock) vBlock audioBandwidthBlock:(CNCMediaPlayerDashBandWidthListBlock) aBlock;



/**
 在拉取Dash协议的流时，播放过程中切换Dash Bandwidth，从列表中获取的Bandwidth列表指定适合当前网络状况的Bandwidth进行设置，可以切换Dash列表中不同的流
 需要在prepare之后设置

 @param videoBandwidth 切换视频Bandwidth ，值为0，则不切换，保持当前Bandwidth
 @param audioBandwidth 切换音频Bandwidth ，值为0，则不切换，保持当前Bandwidth
 @return 0 为成功

 */
- (int)selectedDashVideoBandwidth:(int) videoBandwidth audioBandwidth:(int) audioBandwidth;

#pragma mark - 预加载

/**
 预加载状态

 @return 1为预加载完成 0其他为非预加载，1预加载未完成
 */
- (int)preloadStatus;

#pragma mark - 字幕
/**
 cc字幕选项设置,prepared之后生效

 @param opt
    KEY:CNCMediaPlayerOptionSubtitlePath NSDictionary {@"en":@"……1.mp4.en.srt"}
    KEY:open @"0"：关闭 ，@"1"：开启
    KEY:from @"0"：使用内置字幕 @"1"：使用外挂字幕
    KEY:key  传入多字幕键值对的key值，匹配key值，存在则切换到相应字幕,中文英文

 */
- (void)cncClosedCaptionOption:(NSDictionary *) opt;

#pragma mark - 第三方支持

/**
 超分辨率-IV API
 当前是否支持超分辨率-IV
 @return 是否支持
 */
-(BOOL)cncMediaPlayerLibMngSupportIVFramework;



/**
 暂停超分辨率渲染

 @return 是否暂停成功
 */
-(BOOL)cncMediaPlayerLibMngPauseIVFramework;


/**
 恢复超分辨率渲染

 @return 是否恢复成功
 */
-(BOOL)cncMediaPlayerLibMngResumeIVFramework;
/**
 超分辨率-IV API
 设置比对显示百分比,对比原视频与超分效果,percent为0.0~1.0
 @param percent 显示百分比
 @return 是否调用成功
 */
-(BOOL)cncMediaPlayerLibMngSetIVShowPercent:(CGFloat) percent;

/**
 超分辨率-IV API
 获取支持超分辨率的模型列表
 @return 支持的模型列表
 */
- (NSArray *_Nullable)cncMediaPlayerLibMngGetSupportIVModels;


/**
 超分辨率-IV API
 设置超分辨率显示模式 详见枚举:CNCMediaPlayerLibIVDisplayMode
 @param mode 参考CNCMediaPlayerLibIVDisplayMode
 @return 是否调用成功
 */
- (BOOL)cncMediaPlayerLibMngSetDisplayMode:(CNCMediaPlayerLibIVDisplayMode)mode;


/**
 超分辨率-IV API

 @param block 设置超分辨率附加信息回调,传入相应block可以获取超分辨率附加信息回调 详见CNCMediaPlayerLibIVStateInfoBlock
 @return 是否调用成功
 */
- (BOOL)cncMediaPlayerLibMngSetExtraBlock:(CNCMediaPlayerLibIVStateInfoBlock _Nullable )block;


/**
 超分辨率-IV API
 设置超分模型

 @param modelName 设置模型名称
 @param error 错误信息
 */
- (BOOL)cncMediaPlayerLibMngLoadIVModelName:(NSString *_Nonnull)modelName error:(NSError * _Nullable * _Nullable)error;


#pragma mark - 接口调整:请更新调用
/**
 *  是否开启秒开
 *
 *  @param  isopen      YES/NO， 需要在prepare之前设置
 */
- (void)accelerateOpen:(BOOL)isopen __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) BOOL  accelerateOpen")));

/**
 *  是否开启超级秒开
 *
 *  @param  isopen      YES/NO， 需要在prepare之前设置
 */
- (void)superAccelerate:(BOOL)isopen __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) BOOL  superAccelerate")));



/**
 *  日志控制
 *
 *  @param loglevel 详见CNC_MediaPlayer_Loglevel定义
 */
//- (void)setLogLevel:(CNC_MediaPlayer_Loglevel)loglevel  __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) CNC_MediaPlayer_Loglevel logLevel")));

/**
 设置当前播放器静音与否静音
 
 @param mute YES:静音，NO:不静音
 */
- (void)cncSetPlyerMute:(BOOL)mute __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) BOOL mute; setter")));


/**
 获取当前播放器静音状态
 
 @return 是否静音，YES:静音，NO:不静音
 */
-(BOOL)cncGetPlayerMute __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) BOOL mute; getter")));


/**
 设置当前播放器的音量大小
 注意:不是系统音量
 
 @param volume 音量大小 [0.0,1.0]
 */
- (void)cncSetPlaybackVolume:(float)volume __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) float playbackVolume; setter")));;


/**
 获取当前播放器的音量大小
 
 @return 音量大小 [0.0,1.0]
 */
- (float)cncPlaybackVolume __attribute__((deprecated("此方法已弃用,请使用 @property (nonatomic) float playbackVolume; getter")));;

/**
 截屏
 @return 返回当前时刻的屏幕截图
 */
- (UIImage *_Nonnull) screenShot __attribute__((deprecated("此方法已弃用,请使用 [CNCMediaPlayerSDK screenShot]")));


/**
 添加水印
 @param image   添加水印的图片
 @param watermark 水印图片
 @param rect    水印在图片中的位置
 @return 返回添加水印后的图片
 */
- (UIImage *_Nonnull) watermarkWithImage:(UIImage *_Nonnull)image watermark:(UIImage *_Nonnull)watermark inRect:(CGRect)rect __attribute__((deprecated("此方法已弃用,请使用 [CNCMediaPlayerSDK watermarkWithImage:image watermark:watermark inRect:rect]")));

/**
 *  参数设置
 *
 *  暂不生效
 */
- (void)setOptionIntValue:(int64_t)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
