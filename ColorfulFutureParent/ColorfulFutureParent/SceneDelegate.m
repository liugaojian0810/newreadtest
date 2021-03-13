#import "SceneDelegate.h"
#import "ColorfulFutureParent-Swift.h"

@interface SceneDelegate ()<WXApiDelegate>

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
     //启动页判断
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        [self.window setWindowScene:windowScene];
    } else {
        // Fallback on earlier versions
    }
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:[HFStartPhotoViewController new]];
    [self.window makeKeyAndVisible];
    
    if (IOS_SYSTEM_VERSION >= 13.0) {
        
        NSUserDefaults *defa = [NSUserDefaults standardUserDefaults];
        NSString *str = [defa stringForKey:@"version"];
//        NSString *version = [[NSUserDefaults standardUserDefaults]valueForKey:@"version"];
        if (str == nil || ![str isEqualToString:[UIDevice jk_version]]) {
            [self.window setRootViewController:[HFStartPhotoViewController new]];
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
    
}

- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity  API_AVAILABLE(ios(13.0)){
    [WXApi handleOpenUniversalLink:userActivity delegate:self];
}
- (void)sceneDidDisconnect:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

#pragma mark---------WXApiDelegate

-(void)onReq:(BaseReq *)req{
    
}

#pragma mark 微信回调方法
- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    NSString * errStr = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *req =(SendAuthResp *)resp;
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", req.code, req.state, req.errCode];
        HFLog(@"%@",strMsg);
        //获取到code后，就可以通过code获取access_token和openid，然后通过access_token和openid就可以获取用户个人信息了，这是在服务端做处理的
        if (req.errCode == 0) { //用户同意
            NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token"];
            NSDictionary *dict = @{
                @"appid": WeChat_Key,
                @"secret": WeChat_Secrect,
                @"code":  req.code,
                @"grant_type": @"authorization_code"
            };
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer.acceptableContentTypes = nil;
            
            [manager GET:urlStr parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@", responseObject);
                NSDictionary *responDict = (NSDictionary *)responseObject;
                
                if (responDict && [responDict objectForKey:@"openid"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:LoginAuthorSuccessNotifacation object:[responDict objectForKey:@"openid"]];
                }
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"%@", error);
                        }];
            
        }else if (req.errCode == -4){//用户拒绝授权
            [AlertTool showBottomWithText:req.errStr duration:2];
        }else if (req.errCode == -2){//用户取消
            [AlertTool showBottomWithText:req.errStr duration:2];
        }
    }
}
@end
