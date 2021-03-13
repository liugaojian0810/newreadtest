//
//  CNCMediaPlayerPreloadMgr.h
//  CNCMediaPlayer
//
//  Created by Chen on 2019/4/23.
//  Copyright © 2019 Chinanetcenter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCMediaPlayerLiteCtrl.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PreloadConfigType) {
    CNC_PreloadConfigType_Normal = 0,//将断网重连管理交给SDK处理
    CNC_PreloadConfigType_Advanced = 1,//SDK仅管理预加载,网路状态变化由上层自行处理

};

@interface CNCMediaPlayerPreloadConfig : NSObject
@property (assign, atomic) NSUInteger preloadMaxCount;//最大预加载个数
@property (assign, atomic) PreloadConfigType configType;//预加载配置类型 默认为0
@end

@interface CNCMediaPlayerPreloadVideoItem : NSObject

@property (retain, atomic) NSString *urlString;//
@property (retain, atomic) CNCMediaPlayerCfg *playerCfg;//
@property (assign, atomic) NSUInteger videoPreloadByteSize;//预加载数据量1M(1024 * 1024) default value is 1M

@end


@interface CNCMediaPlayerPreloadMgr : NSObject
/**
 当前正在播放的播放器实例
 */
@property (retain, atomic) CNCMediaPlayerLiteCtrl *currentPlayer;

/**
 预加载信息，数据量等
 */
@property (retain, atomic, readonly) NSMutableDictionary *preloadInfo;

/**
 初始化预加载管理模块

 @param cfg 管理模块的配置，包括预加载数最大个数等
 @return 管理模块实例
 */
- (instancetype)initWithCfg:(CNCMediaPlayerPreloadConfig *) cfg;

/**
 预加载播放器
 预加载成功后，只请求设定的预加载数据量，处于prepared状态，可直接调用play进行播放
 @param item 播放器参数,包括url、播放器配置、预加载数据量
 @return 状态码,0为成功
 */
- (int)preload:(CNCMediaPlayerPreloadVideoItem *) item;


/**
 加载播放
 @param item 播放器参数,包括url、播放器配置、预加载数据量
 @return 状态码,
        0代表当前要加载的播放器处理队列中，相当于切换到下一个视频进行播放的操作,
        1为当前要加载的播放器不在队列中，先进行预加载，再设为当前播放器，相当于切换到不在预加载队列里的视频
 */
- (int)load:(CNCMediaPlayerPreloadVideoItem *) item;

/**
 释放播放器
 通过item的url找到预加载队列中的播放器进行shutdown，并从队列中移除
 @param item 播放器参数,包括url、播放器配置、预加载数据量
 @return 状态码
        0为成功
        -1为预加载队列中找不到与item的url匹配的播放器
 */
- (int)unload:(CNCMediaPlayerPreloadVideoItem *) item;

/**
 清空所有预加载视频
 @return 状态码 0为成功
 */
- (int)unloadAll;

/**
 关闭预加载管理模块
 释放预加载队列中所有播放器，清空预加载列表及其他参数

 @return 状态码 0为成功
 */
- (int)shutdown;



/**
 暂停播放，在预加载个数阈值之内，暂停播放当前item所指向的播放器，不释放，便于下次直接使用。
 @param item 播放器参数,包括url、播放器配置、预加载数据量
 @return 状态码 0为成功 -1为item当前指向的播放资源不存在
 */
-(int)pause:(CNCMediaPlayerPreloadVideoItem *)item;

@end

NS_ASSUME_NONNULL_END



