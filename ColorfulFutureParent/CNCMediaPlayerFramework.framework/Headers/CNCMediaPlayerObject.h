//
//  CNCMediaPlayerObject.h
//  CNCMediaPlayerFramework
//
//  Created by Chen on 2019/4/25.
//  Copyright © 2019 Chinanetcenter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCMediaPlayerComDef.h"
NS_ASSUME_NONNULL_BEGIN

@interface CNCMediaPlayerObject : NSObject

@end

#pragma mark - CNCMediaPlayerCfg  播放器启播配置参数类
@interface CNCMediaPlayerCfg : NSObject
@property (nonatomic) BOOL isAutoPlay;
@property (nonatomic) BOOL isLive;
@property (nonatomic) BOOL isHardware;
@property (nonatomic) BOOL isAutoClearCache;
@property (nonatomic) BOOL isDisableDecodeBackground;
@property (nonatomic) BOOL isPlayBackground;
@property (nonatomic) BOOL isAccelerateOpen;
@property (nonatomic) BOOL isMixOtherPlayer;
@property (nonatomic) BOOL isSuperAccelerate;
@property (nonatomic) BOOL isLowLatencyMode;
@property (nonatomic) BOOL isHLSAdaptation;
@property (nonatomic) BOOL isLocalCache;
@property (nonatomic) BOOL isAccurateSeek;
@property (nonatomic) BOOL isOpenIV;
@property (nonatomic) BOOL isOpenHLSEncryption;
@property (nonatomic) int isMutliOpen;

@property (nonatomic) NSInteger minBufferTime;
@property (nonatomic) NSInteger maxCacheTime;
@property (nonatomic) double maxBufferSize;
@property (nonatomic) int gifScale;
@property (nonatomic) int64_t HLSDefaultBitrate;

@property (nonatomic) NSInteger cacheVideoCount;
@property (nonatomic) NSInteger cacheVideoSize;

@property (nonatomic) NSUInteger loopCount;
@property (nonatomic) BOOL loopOn;

@property (nonatomic) BOOL isProxy;
@property (nonatomic) BOOL isHTTPS;
@property (nonatomic, assign) NSUInteger    type;
@property (nonatomic, strong) NSString      *socksUser;
@property (nonatomic, strong) NSString      *socksPwd;
@property (nonatomic, strong) NSString      *socksIP;
@property (nonatomic, strong) NSString      *socksPort;
@property (nonatomic, strong) NSString      *hlsDecryptionVideoId;

@property (nonatomic, strong) NSString      *urlString;


@property (nonatomic) NSUInteger dnsTimeout;

+ (instancetype)defaultSetting;

@end


#pragma mark - CNCMediaPlayerPlayStatusInfo 播放器参数配置信息

@interface CNCMediaPlayerSettingInfo : NSObject
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

//缓存数据上限 视频本地临时缓存上限（位于内存），即加载至maxBufferSize达到饱和状态，单位是MB
@property (nonatomic) NSTimeInterval    maxBufferSize;

//解码方式，详见CNCMediaVideoDecoderMode定义
@property (nonatomic) CNCMediaVideoDecoderMode  videoDecoderMode;

// 后台播放 1）YES允许后台播放  2）NO禁止后台播放
@property (nonatomic) BOOL  ableVideoPlayingInBackground;

//后台解码,允许后台播放下设置该变量生效，只针对软解，1）YES：程序在后台时，只进行音频解码，不进行视频解码 2）进入后台，音视频仍旧在解码

@property (nonatomic) BOOL  disableVideoDecodeInBackground;

//播放模式，详见CNCMediaVideoDecoderMode定义
@property (nonatomic) CNCMediaPlayerMode  playerMode;

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
@property (nonatomic) float playbackRate;

//设置当前播放器的音量大小。注意:不是系统音量 取值 [0.0,1.0]
@property (nonatomic) float playbackVolume;

//设置当前播放器静音与否静音
@property (nonatomic) BOOL mute;
@end

#pragma mark - CNCMediaPlayerPlayStatusInfo 播放器播放器状态信息
@interface CNCMediaPlayerPlayStatusInfo : NSObject
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

/**
 *  是否处于录制状态
 */
@property (nonatomic, readonly) BOOL    isRecording;
@end


#pragma mark - CNCMediaPlayerMediaInfo 播放器音视频信息
@interface CNCMediaPlayerMediaInfo : NSObject
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

// prepare所花时间
@property (nonatomic, readonly) float      prepareDuraion;

// 点播的文件长度
@property (nonatomic, readonly) int64_t      fileSize;

//数据读取大小
@property (nonatomic, readonly) int64_t      bufferSizeRead;

//当前播放URL
@property (nonatomic, readonly) NSURL       *currentUrl;


@end
NS_ASSUME_NONNULL_END
