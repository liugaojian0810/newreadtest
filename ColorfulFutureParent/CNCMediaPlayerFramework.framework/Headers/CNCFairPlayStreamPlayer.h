//
//  CNCFairPlayStreamPlayer.h
//  CNCMediaPlayer
//
//  Created by Chen on 10/15/19.
//  Copyright © 2019 Chinanetcenter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNCMediaPlayerComDef.h"

#define CertUrl @"CertUrl"

NS_ASSUME_NONNULL_BEGIN

//typedef enum : NSUInteger {
//    CNCFPSWaitingToMinimizeStallsReason,
//    CNCFPSWaitingWhileEvaluatingBufferingRateReason,
//    CNCFPSPlayerWaitingWithNoItemToPlayReason,
//} CNCFairPlayStreamPlayerReasonForWaitingToPlay;

@interface CNCFairPlayStreamPlayer : NSObject


//播放器view，渲染数据的载体
@property (nonatomic, readonly) UIView  * _Nullable view;
@property(nonatomic)            NSTimeInterval currentPlaybackTime;
@property(nonatomic, readonly)  NSTimeInterval duration;
@property(nonatomic, readonly)  NSTimeInterval playableDuration;
@property(nonatomic, readonly)  NSInteger bufferingProgress;

@property(nonatomic, readonly)  BOOL isPreparedToPlay;



@property(nonatomic, readonly) int64_t numberOfBytesTransferred;

@property(nonatomic, readonly) CGSize naturalSize;

@property(nonatomic) BOOL shouldAutoplay;
@property(atomic ,readonly) BOOL isShutdown;

@property (nonatomic) BOOL allowsMediaAirPlay;
@property (nonatomic) BOOL isDanmakuMediaAirPlay;
@property (nonatomic, readonly) BOOL airPlayMediaActive;

@property (nonatomic) float playbackRate;
@property (nonatomic) float playbackVolume;
@property (nonatomic) BOOL mute;
//@property (nonatomic) NSInteger dnsTimeout;
//@property (nonatomic) NSInteger tcpTimeout;
//@property (nonatomic) NSInteger connectTimeout;


//播放状态，详见播放状态CNCMediaPlayerbackState定义
@property (nonatomic, readonly) CNCMediaPlayerbackState   playbackState;

//加载状态，详见加载状态CNCMediaLoadstate定义
@property (nonatomic, readonly) CNCMediaLoadstate       loadState;

@property (nonatomic) CncMpVideoScalingMode scalingMode;


//是否正在播放
@property (nonatomic, readonly) BOOL    isPlaying;

//是否停止播放
@property (nonatomic, readonly) BOOL    isStop;

/**
 *  初始化 FairPlayStream 播放器实例
 *  非 FairPlayStream 建议使用 CNCMediaPlayerController 进行初始化
 *
 *  @param urlString 播放的视频地址
 *  @param option 需要初始化时配置的参数，正常启用可以不需要设置
 *          要播放器加密的FPS资源，option需传入如下格式{@"certUrl":@"https://..."}
 *  @return CNCFairPlayStreamPlayer对象
 */
- (instancetype _Nonnull )initWithContentURLString:(NSString *_Nullable)urlString option:(NSDictionary *_Nullable) option NS_DESIGNATED_INITIALIZER;


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

/// 是否后台播放要暂停
/// @param pause YES 暂停，NO 不暂停
- (void)setPauseInBackground:(BOOL)pause;



@end

NS_ASSUME_NONNULL_END

