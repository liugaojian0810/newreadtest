//
//  AppDelegate.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/4.
//  Copyright © 2020 huifan. All rights reserved.
//
#define UMengAppKey @"5ed472ccdbc2ec08279bd414" //友盟appkey

#import "AppDelegate.h"
#import <CNCMediaPlayerFramework/CNCMediaPlayerFramework.h>
#import <YSSDK/YSSDKManager.h>
#import <PushKit/PushKit.h>
#import <JPUSHService.h>
#import <JAnalytics/JANALYTICSService.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "HFNetworkCheck.h"
#import "ColorfulFutureParent-Swift.h"


@interface AppDelegate ()<JPUSHRegisterDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动页延时5秒
    [NSThread sleepForTimeInterval:2];
    [HFCountDown getSystemTimeWithBlock:^(HFSystemTime * _Nonnull time) {
    }];
    //直播点播集成
    [CNCMediaPlayerSDK regist_app:@"huifanedu" auth_key:@"8195E607D18C478C8E62B930D1169307"];
    [YSSDKManager sharedInstance];
    //    极光推送集成
    
    // 3.0.0及以后版本注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setValue:registrationID forKey:@"PushRegistrationID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    
    config.appKey = appKey;
    
    config.channel = channel;
    
    [JANALYTICSService setupWithConfig:config];
    
    
    [JANALYTICSService crashLogON];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    
    // U-Share 平台设置
    [self confitUShareSettings];
    [self configUSharePlatforms];
    //    极光推送集成
    
    [[HFNetworkCheck sharedHFNetworkCheck] startNetworkCheckWithStateBlock:^(NetworkState state) {
        if (state == NetworkStateNotReachable) { //网络不可达
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [AlertTool showTopWithText:@"网络异常，请检查网络设置" duration:3];
            });
        }else{ //网络可达
            
        }
    }];
    
    if (IOS_SYSTEM_VERSION < 13.0) {
        //启动页判断
        NSString *version = [[NSUserDefaults standardUserDefaults]valueForKey:@"version"];
        if (version == nil || ![version isEqualToString:[UIDevice jk_version]]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isRule"];
            self.window.rootViewController = [HFStartPhotoViewController new];
        }else{
            if (![HFUserInformation isLogin]) {
                NSUserDefaults *userDef =  [NSUserDefaults standardUserDefaults];
                [userDef setBool:YES forKey:@"LoginOutTag"];
                [userDef synchronize];
                HFNewBaseNavigationController *nc = [[HFNewBaseNavigationController alloc] initWithRootViewController:[HFNewLoginViewController new]];
                nc.modalPresentationStyle = UIModalPresentationFullScreen;
                self.window.rootViewController = nc;
            }else{
                [self.window setRootViewController:[[UIStoryboard  storyboardWithName:@"Main_Parent" bundle:nil]instantiateViewControllerWithIdentifier:@"TabBarController"]];
            }
        }
    }

    [WXApi registerApp:WeChat_Key universalLink:WeChat_Universal_Link];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    if (self.allowRotation == YES) {
        //横屏
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        //竖屏
        return UIInterfaceOrientationMaskPortrait;
    }
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    
}
#pragma mark 分享
- (void)confitUShareSettings
{
    
    [UMConfigure initWithAppkey:UMengAppKey channel:@"App Test"];//App Store  //生产环境、测试环境
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://developer.umeng.com/",
                                                        @(UMSocialPlatformType_WechatTimeLine):@"https://developer.umeng.com/"
    };
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*设置小程序回调app的回调*/
    /*
     [[UMSocialManager defaultManager] setLauchFromPlatform:(UMSocialPlatformType_WechatSession) completion:^(id userInfoResponse, NSError *error) {
     NSLog(@"setLauchFromPlatform:userInfoResponse:%@",userInfoResponse);
     }];
     */
}
// 支持所有iOS系统
/*
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
 //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
 BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
 if (!result) {
 // 其他如支付等SDK的回调
 }
 return result;
 }
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
//3、设置Universal Links系统回调
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler
{
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
    }
    return YES;
}

@end
