//
//  CNCMediaPlayerLiteCtrl.h
//  CNCMediaPlayer
//
//  Created by Chen on 2019/4/23.
//  Copyright © 2019 Chinanetcenter. All rights reserved.
//

#import "CNCMediaPlayerController.h"
#import "CNCMediaPlayerObject.h"
NS_ASSUME_NONNULL_BEGIN

/*  CNCMediaPlayerLiteCtrl 全局通知
    postNotificationName:CNCMediaPlayerLiteCtrlGlobalNotification
    userInfo:{"CLNName":"","CLNInfo":""}
    CLNName @see CNCMediaPlayerComDef.h Notification
*/
CNC_EXTERN NSString * const CNCMediaPlayerLiteCtrlGlobalNotification;


@interface CNCMediaPlayerLiteCtrl : CNCMediaPlayerController 

@property (nonatomic, strong, readonly) CNCMediaPlayerPlayStatusInfo    *playStatusInfo;
@property (nonatomic, strong, readonly) CNCMediaPlayerMediaInfo         *mediaInfo;

@property (nonatomic ) int64_t                                          tmpFileSize;
@property (nonatomic ) NSTimeInterval                                   maxPlayerPoistion;
@property (nonatomic ) BOOL                                             isCurrentPlayer;

/**
 *  初始化 只能通过此方法创建播放器对象
 *
 *  @param url 播放的视频地址
 *  @param cfg 需要初始化时配置的播放参数
 *  @param option 需要初始化时配置的额外参数，正常启用可以不需要设置
 *  @return CNCMediaPlayerController对象
 */
- (instancetype _Nonnull )initWithContentURL:(NSURL *_Nonnull)url cfg:(CNCMediaPlayerCfg *) cfg option:(NSDictionary *_Nullable) option NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
