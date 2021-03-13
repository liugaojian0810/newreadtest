//
//  HomeViewController.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HomeViewController.h"
#import "UIDevice+HFDevice.h"
#import "HFHomeItemView.h"
#import "SetViewController.h"
#import "HFViewController.h"
#import "HFBabyHeaderAndName.h"
#import "HFHomeMenusItem.h"
#import "HFGemsListViewController.h"
#import "HFInteractiveStatusListViewController.h" //云家园互动营首页
#import "HFTodayTaskViewController.h"//今日任务
#import "HFPareScheduleController.h"
#import "HFCourseForeshowModel.h"
#import "HFBabyListModel.h"
#import "HFVideoController.h"
#import "HFCountDown.h"
#import "HFClassVideoURLModel.h"
#import "HFMyViewModel.h"
#import "HFCourseForeshowModel.h"
#import "HFVoiceView.h"
#import "HFChioceBabyItem.h"
#import "HFClassDetailViewController.h"
#import "SPAlertController.h"
#import "HFPayTheFeesListViewController.h"
#import "WZLBadgeImport.h"
#import "HFPayHistoryViewController.h"
#import "ColorfulFutureParent-Swift.h"
#import "HFRuleViewController.h"
#import "UIButton+HFExpandClickArea.h"

typedef void (^requestYJYStatus)(BOOL result);

#import "HFAudioPlayer.h"
@interface HomeViewController ()
@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) HFHomeItemView *setting, *task, *orders, *fiveColorGem;
@property(nonatomic, strong) UIButton *setBtn, *taskBtn, *ordersBtn, *fiveColorGemBtn, *changeBaby;
@property(nonatomic, strong) HFBabyHeaderAndName *babyIcon;
@property(nonatomic, strong) HFHomeMenusItem *babyLearnLanguage, *cloudHomeInteraction, *cloudHomeGrowUp, *energyMath;
@property(nonatomic, strong) UIView *changeBabyBGView, *todayTasks;
@property (nonatomic, strong)HFBabyListModel *babyModel;
@property(nonatomic, strong) HFMyViewModel *myViewModel;
@property(nonatomic, assign) BOOL buyYJY;
@property (nonatomic,assign) BOOL haveAlert;
@property (nonatomic, strong) UILabel *build;//测试版本号

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buyYJY = NO;
    [UIDevice setHScreen];
    [self addMySubViews];
    [self setMasonry];
    [self addTarget];
    //宝宝信息
    self.haveAlert = NO;
    _myViewModel = [[HFMyViewModel alloc]init];
    //更新登录信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNOTLoginAction:) name:@"updateLogindata" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homePageApper) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homePageApper) name:@"home_page_apper" object:nil];
    if (![self isLogin]) {
//        return;
    }else{
        [self updataBaby];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showProtocol];
    });
    [ServiceFactory changeEnvironmentType:EnvironmentTypeDevelop];

}

#pragma mark - 用户须知弹窗
- (void)showProtocol{
    BOOL isRule =  [[NSUserDefaults standardUserDefaults] boolForKey:@"isRule"];
    if (isRule == YES) {

    }else{
        HFCustomAlertController *alert = [HFCustomAlertController new];
        alert.alertType = HFCustomAlertTypeTypeFirstComeInAgree;
        alert.bottomBtnStr = @"同意并使用";
        alert.actureClosure = ^{
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setBool:YES forKey:@"isRule"];
        };
        [self presentViewController:alert animated:true completion:nil];
    }
//=======
//    if ([self isLogin]) {
//        [self updataBaby];
//
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSString *isRule =  [[NSUserDefaults standardUserDefaults] valueForKey:@"isRule"];
//        if (isRule != nil) {
//            return;
//        }
//        [ServiceFactory changeEnvironmentType:EnvironmentTypeDevelop];
//        [self presentViewController:[HFRuleViewController new] animated:NO completion:nil];
//    });
//>>>>>>> realeaseTest
}


-(void)homePageApper{
    [self getVersion];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.fiveColorGem clearBadge];
    if (![self isLogin]) {
        return;
    }else{
        [self loadYJYStatus:^(BOOL result) {
        }];
        //    [self getVersion];
        [self messageAlert];
    }
}

-(void)getVersion{
    
    [_myViewModel getVersion];
    
    [[_myViewModel.fetchGetVersionCommand execute:nil]subscribeError:^(NSError *error) {
        
    } completed:^{
        if (self.myViewModel.updateModel != nil) {
            @try {
                NSString *str = self.myViewModel.updateModel.versionCode;
                NSString *isUpdate = self.myViewModel.updateModel.isUpdate;
                NSString *updateUrl = self.myViewModel.updateModel.attach;
                NSString *attach = (self.myViewModel.updateModel.attach.length > 0)? self.myViewModel.updateModel.attach: @"";
                NSString *versionRemark = self.myViewModel.updateModel.versionRemark;
                //                NSDictionary *dict = @{@"versionCode":str, @"isUpdate":isUpdate,@"updateUrl":updateUrl,@"attach":attach};
                NSDictionary *dict = @{@"versionCode":SafeParamStr(str), @"isUpdate": SafeParamStr(isUpdate),@"updateUrl": SafeParamStr(updateUrl),@"attach":SafeParamStr(attach)};
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setValue:dict forKey:@"Update_Msg"];
                [userDefaults synchronize];
                NSString *localAppVersion = HFAppVersion;
                NSString *serverAppVersion = [str copy];
                if (![localAppVersion isEqualToString:serverAppVersion]) {
                    if ([isUpdate boolValue] == YES) {
                        WeakSelf
                        NSString *remark = [NSString stringWithFormat:@"%@",versionRemark];
                        [self showCustomAlertWithTitle:@"" message:remark firstActionMsg:@"取消" secondActionMsg:@"确定" firstBlock:^{
                            Strong_Self
                            [self exitApplication];
                        } secondBlock:^{
                            //这个时候跳转应用更新模块
                            NSString * strIdentifier = attach;
                            BOOL isExsit = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strIdentifier]];
                            if(isExsit) {
                                NSLog(@"App %@ installed", strIdentifier);
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strIdentifier]];
                            }
                        } isUpdate:YES];
                        //[MBProgressHUD showMessage:@"此时应该强制更新"];
                    }else{
                        if (self.haveAlert == NO) {
                            NSString *remark = [NSString stringWithFormat:@"%@",versionRemark];
                            WeakSelf
                            [self showCustomAlertWithTitle:@"" message:remark firstActionMsg:@"取消" secondActionMsg:@"确定" firstBlock:^{
                                Strong_Self
                                //                            [self exitApplication];
                                self.haveAlert = YES;
                            } secondBlock:^{
                                //这个时候跳转应用更新模块
                                NSString * strIdentifier = attach;
                                BOOL isExsit = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strIdentifier]];
                                if(isExsit) {
                                    NSLog(@"App %@ installed", strIdentifier);
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strIdentifier]];
                                }
                            } isUpdate:YES];
                        }else{
                            
                        }
                    }
                }
                //                if ([isUpdate boolValue] == YES) {
                //                    [MBProgressHUD showMessage:@"此时应该强制更新"];
                //                }
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
    }];
}

- (void)exitApplication {
    [UIView animateWithDuration:1.0f animations:^{
        [UIApplication sharedApplication].keyWindow.alpha = 0;
        [UIApplication sharedApplication].keyWindow.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

-(void)showCustomAlertWithTitle:(NSString *)title message:(NSString *)message firstActionMsg:(NSString *)firstMsg secondActionMsg:(NSString *)secondMsg firstBlock:(OptionBlock)firstBlock secondBlock:(OptionBlock)secondBlock isUpdate:(BOOL)update{
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:title message:message preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeNone];
    alertController.messageFont = PingFangRegular(16);
    alertController.messageColor = [UIColor jk_colorWithHexString:@"#FF4B4B4B"];
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:firstMsg style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        firstBlock();
    }];
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:secondMsg style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        secondBlock();
    }];
    action1.titleColor  = [UIColor jk_colorWithHexString:@"#ACB1BC"];
    action1.titleFont = PingFangRegular(18);
    action2.titleColor = [UIColor jk_colorWithHexString:@"#FF9120"];
    action2.titleFont = PingFangSemibold(18);
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:^{}];
}

-(void)loadYJYStatus: (requestYJYStatus) requestStatus {
    HFLog(@"viewWillAppear");
    NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
    NSString *userID = [[HFUserManager sharedHFUserManager] getUserInfo].userId;
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [dictParams setValue:userID forKey:@"userId"]; // 家长ID
    [dictParams setValue:babyID forKey:@"ownerId"]; // 宝宝ID
    [dictParams setValue:@"0" forKey:@"clientType"];
    [dictParams setValue:@"2" forKey:@"goodsFlag"];
    [Service postWithUrl:checkIsOrderBuyAPI params:dictParams success:^(id responseObject) {
        HFLog(@"responseObject:%@", responseObject);
        self.buyYJY = [responseObject[@"model"][@"isBuy"] boolValue];
        requestStatus(self.buyYJY);
    } failure:^(HFError *error) {
        HFLog(@"error:%@", error);
        requestStatus(NO);
    }];
}

- (void)updateNOTLoginAction:(NSNotification *)sender {
    self.babyIcon.dic = sender.object;
    if ([[sender.object valueForKey:@"islogin"] isEqual:@"1"]) {
        [self loginAction];
    }
}

#pragma mark - 添加子View

-(void) addMySubViews {
    [self.view addSubview: self.bgView];
    [self.view addSubview: self.babyIcon];
    [self.view addSubview: self.changeBaby];
    [self.view addSubview: self.setting];
    [self.view addSubview: self.orders];
    [self.view addSubview: self.task];
    [self.view addSubview: self.fiveColorGem];
    [self.view addSubview: self.babyLearnLanguage];
    [self.view addSubview: self.cloudHomeInteraction];
    [self.view addSubview: self.cloudHomeGrowUp];
    [self.view addSubview: self.todayTasks];
    [self.view addSubview: self.energyMath];
    [self.view addSubview: self.changeBabyBGView];
    [self.view addSubview:self.build];
    #ifdef DEBUG
    self.build.hidden = NO;
    #else
    self.build.hidden = YES;
    #endif
}

#pragma mark - 设置masonry
-(void) setMasonry {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    BOOL isIphoneX = HFIsiPhoneX;
    CGFloat leftMarge = isIphoneX ? 48.0 : 26.0;
    [self.babyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftMarge);
        make.top.mas_equalTo(18.5);
        make.width.mas_equalTo(120.0);
        make.height.mas_equalTo(52.0);
    }];
    
    [self.changeBaby mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.babyIcon.mas_centerX).offset(-40);
        make.top.mas_equalTo(self.babyIcon.mas_bottom);
    }];
    
    [self.changeBabyBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.right.equalTo(self.babyIcon).offset(100);
        make.right.equalTo(self.babyIcon).offset(50);
        //        make.width.mas_equalTo(180);
        make.left.mas_equalTo(self.babyIcon).offset(10.0);
        make.top.mas_equalTo(self.changeBaby);
        make.height.mas_equalTo(0.0);
    }];
    
    CGFloat marge = 20;
    [self.setting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-46.0 + marge);
        make.top.mas_equalTo(self.view);
        make.width.mas_equalTo(80.0);
        make.height.mas_equalTo(70.0);
    }];
    
    [self.orders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-126.0  + marge);
        make.top.mas_equalTo(self.setting);
        make.width.height.mas_equalTo(self.setting);
    }];
    
    [self.task mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-206.0  + marge);
        make.top.mas_equalTo(self.setting);
        make.width.height.mas_equalTo(self.setting);
    }];
    
    [self.fiveColorGem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-286.0 + marge);
        make.top.mas_equalTo(self.setting);
        make.width.height.mas_equalTo(self.setting);
    }];
    
    [self.babyLearnLanguage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(isIphoneX ? 30 : 0);
        make.top.mas_equalTo(isIphoneX ? 100 : 80);
        make.width.mas_equalTo(isIphoneX ? 220 : 200);
        make.height.mas_equalTo(isIphoneX ? 140 : 120);
    }];
    
    [self.cloudHomeInteraction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(isIphoneX ? -10 : -18);
        make.width.mas_equalTo(isIphoneX ? 260 : 220);
        make.height.mas_equalTo(isIphoneX ? 220 : 180);
    }];
    
    [self.cloudHomeGrowUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cloudHomeInteraction.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.cloudHomeInteraction);
        make.width.mas_equalTo(isIphoneX ? 280 : 220);
        make.height.mas_equalTo(140);
    }];
    
    [self.todayTasks mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cloudHomeGrowUp.mas_bottom).offset(30);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.cloudHomeGrowUp).offset(-30);
        make.right.mas_equalTo(self.cloudHomeGrowUp.mas_centerX);
    }];
    
    [self.energyMath mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(140);
    }];
    [self.build mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.bottom.mas_equalTo(-50);
    }];
}

#pragma mark - 菜单点击事件

-(void) addTarget {
    __weak typeof(self) weakSelf = self;
    //设置
    [self.setting setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
//        SetViewController *VC = [[SetViewController alloc]init];
//        VC.block = ^{
//            weakSelf.babyIcon.dic = @{@"name":@"请登录",@"sex":@"1"};
//        };
//        [weakSelf presentViewController:VC animated:NO completion:nil];
//        HFLog(@"点击了 = %@", weakSelf.setting);
        
        
//        HFScheduleController *schdule = [[HFScheduleController alloc]init];
//        [self presentViewController:schdule animated:YES completion:nil];
        
        HFSetUpController *VC = [[HFSetUpController alloc]init];

        [weakSelf presentViewController:VC animated:NO completion:nil];
        HFLog(@"点击了 = %@", weakSelf.setting);
        
        
    }];
    //今日任务
    [self.todayTasks setTapActionWithBlock:^{
        NSDate *date = [[HFCountDown sharedHFCountDown] getServerTime];
        HFLog(@"date:%@",date);
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        
        [weakSelf loadYJYStatus:^(BOOL result) {
            if (!result) {
                [weakSelf gotoBuyYJY];
                return;
            } else {
                HFTodayTaskListViewController *VC = [[HFTodayTaskListViewController alloc]init];
                [weakSelf presentViewController:VC animated:NO completion:nil];
                HFLog(@"点击了 = %@", weakSelf.todayTasks);
            }
        }];
    }];
    //订单
    [self.orders setTapActionWithBlock:^{
        
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        HFLog(@"点击了 = %@", weakSelf.orders);
        HFClassOrdersListViewController *VC = [HFClassOrdersListViewController new];
        [weakSelf presentViewController:VC animated:NO completion:nil];
    }];
    //缴费
    [self.task setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        HFLog(@"点击了 = %@", weakSelf.orders);
        HFPayTheFeesListViewController *VC = [HFPayTheFeesListViewController new];
        VC.titleString = @"缴费";
        [weakSelf presentViewController:VC animated:NO completion:nil];
    }];
    
    //五彩宝石
    [self.fiveColorGem setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        HFLog(@"点击了 = %@", weakSelf.fiveColorGem);
//        HFFiveGemsListViewController *VC = [HFFiveGemsListViewController new];
//        [weakSelf presentViewController:VC animated:NO completion:nil];
    }];
    //    用户信息
    [self.babyIcon setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        HFLog(@"点击了 = %@", weakSelf.babyIcon);
//        UserDataViewController *vc = [[UserDataViewController alloc] init];
//        [weakSelf presentViewController:vc animated:NO completion:nil];
    }];
    
    [self.babyLearnLanguage setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        HFLog(@"点击了 = %@", weakSelf.babyLearnLanguage);
        HFHintViewController *hit = [HFHintViewController new];
        hit.massageString = @"宝贝学语言";
        [weakSelf presentViewController:hit animated:NO completion:nil];
    }];
    //云家园互动营
    [self.cloudHomeInteraction setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        [weakSelf loadYJYStatus:^(BOOL result) {
            if (!result) {
                [weakSelf gotoBuyYJY];
                return;
            } else {
                HFLog(@"点击了 = %@", weakSelf.cloudHomeInteraction);
                HFInteractiveViewController *hit = [HFInteractiveViewController new];
                [weakSelf presentViewController:hit animated:NO completion:nil];
            }
        }];
        
    }];
    //云家园成长营
    [self.cloudHomeGrowUp setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        [weakSelf loadYJYStatus:^(BOOL result) {
            if (!result) {
                [weakSelf gotoBuyYJY];
                return;
            } else {
                HFLog(@"点击了 = %@", weakSelf.cloudHomeGrowUp);
                [weakSelf requestForTodayTask];
            }
        }];
        
    }];
    [self.energyMath setTapActionWithBlock:^{
        if (![weakSelf isLogin]) {
            [weakSelf loginAction];
            return;
        }
        HFLog(@"点击了 = %@", weakSelf.energyMath);
        HFHintViewController *hit = [HFHintViewController new];
        hit.massageString = @"能量数学";
        [weakSelf presentViewController:hit animated:NO completion:nil];
    }];
}

#pragma mark - 判断是否登录
- (BOOL)isLogin {
    NSString *token = [[HFUserManager sharedHFUserManager] getUserInfo].token;
    if (token.length) {
        return YES;
    }else{
        return NO;
    }
}

-(void)gotoBuyYJY {
//    HFClassDetailViewController *detailVc1 = [[HFClassDetailViewController alloc] init];
//    [self presentViewController:detailVc1 animated:NO completion:nil];
//    return;
    HFClassDetailController *detailVc = [HFClassDetailController new];
    [self presentViewController:detailVc animated:NO completion:nil];
}

- (void)loginAction {
    
//    HFLoginInController *login = [HFLoginInController new];
//    [self presentViewController:login animated:NO completion:nil];
    
}
//宝宝列表
-(void)changeBabyClick: (UIButton *) sender {
    [self addBabyList];
    [UIView animateWithDuration: 0.4 animations:^{
        [self.changeBabyBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.babyIcon).offset(50);
            make.left.mas_equalTo(self.babyIcon).offset(-10.0);
            make.top.mas_equalTo(self.changeBaby);
            make.height.mas_equalTo(self.babyModel.model.count * 52.0 + 10.0);
        }];
        self.changeBaby.alpha = 0.0;
        [self.view layoutIfNeeded];
    }];
}

-(void)updataBaby {
    HFBabyInfo *babyInfo = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo;
    if ([HFUserManager getUserInfo].userId.length != 0 && babyInfo.babyName.length!=0) {
        HFLog(@"===== 姓名：%@,教职工ID：%@",babyInfo.babyName,babyInfo.sex);
        self.babyIcon.dic = @{@"name":babyInfo.babyName, @"sex":babyInfo.sex};
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.familyDocId;
        params[@"id"] = babyID;
        [Service postWithUrl:coutBabyAPI params:params success:^(id responseObject) {
            NSError * error = nil;
            HFBabyListModel *babyListModel = [HFBabyListModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
            self.babyModel = babyListModel;
            self.changeBaby.hidden = self.babyModel.model.count < 2;
        } failure:^(HFError *error) {
            [MBProgressHUD showMessage:@"获取宝宝列表失败"];
        }];
    }
}
- (void)addBabyList {
    __weak HomeViewController *weakSelf = self;
    for (UIView *sub in self.changeBabyBGView.subviews) {
        [sub removeFromSuperview];
    }
    for (int i = 0; i < self.babyModel.model.count; i++) {
        
        HFChioceBabyItem *item = [[[NSBundle mainBundle]loadNibNamed:@"HFChioceBabyItem" owner:nil options:nil]lastObject];
        item.babyInfoModel = self.babyModel.model[i];
        item.frame = CGRectMake(0, i * 52.0 + 10.0, 130, 52.0);
        [self.changeBabyBGView addSubview:item];
        [item setTapActionWithBlock:^{
            HFLog(@"选中了第%d个宝宝", i + 1);
            HFModel *model = self.babyModel.model[i];
            weakSelf.babyIcon.dic = @{@"name":model.name,@"sex":@(model.sex)};
            HFUserInfo *info = [[HFUserManager sharedHFUserManager] getUserInfo];
            HFBabyInfo *babyInfo = info.babyInfo;
            babyInfo.babyID = [NSString stringWithFormat:@"%ld",(long)model.identifier];
            babyInfo.kgId = [NSString stringWithFormat:@"%ld",(long)model.kgId];
            babyInfo.kgName = model.kgName;
            info.babyInfo = babyInfo;
            info.babyInfo.babyName = model.name;
            info.babyInfo.sex = [NSString stringWithFormat:@"%ld",(long)model.sex];
            [[HFUserManager sharedHFUserManager] saveUserInfo:info];
            HFLog(@"===== 姓名：%@,教职工ID：%@",babyInfo.babyName,babyInfo.sex);
            [self messageAlert];
            [UIView animateWithDuration:0.4 animations:^{
                [weakSelf.changeBabyBGView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    //                    make.right.mas_equalTo(self.babyIcon);
                    make.right.equalTo(self.babyIcon).offset(50);
                    make.left.mas_equalTo(self.babyIcon).offset(-10.0);
                    make.top.mas_equalTo(self.changeBaby);
                    make.height.mas_equalTo(0.0);
                }];
                weakSelf.changeBaby.alpha = 1.0;
                [weakSelf.view layoutIfNeeded];
            }];
        }];
    }
}

#pragma mark - 懒加载属性

-(UIImageView *)bgView {
    if (nil == _bgView) {
        _bgView = [UIImageView new];
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgView.image = [UIImage imageNamed:@"bg_zhuomian"];
    }
    return _bgView;
}
//设置
-(HFHomeItemView *)setting {
    if (nil == _setting) {
        _setting = [[HFHomeItemView alloc] init];
        _setting.iconName = @"home-icon-sz";
        
    }
    return _setting;
}
//缴费
-(HFHomeItemView *)task {
    if (nil == _task) {
        _task = [[HFHomeItemView alloc] init];
        _task.iconName = @"home-icon-jf";
        _task.name = @"任务";
    }
    return _task;
}
//订单列表
- (HFHomeItemView *)orders {
    if (nil == _orders) {
        _orders = [[HFHomeItemView alloc] init];
        _orders.iconName = @"home-icon-dd";
    }
    return _orders;
}
//五彩宝石
-(HFHomeItemView *)fiveColorGem {
    if (nil == _fiveColorGem) {
        _fiveColorGem = [[HFHomeItemView alloc] init];
        _fiveColorGem.iconName = @"home-icon-wcbs";
    }
    return _fiveColorGem;
}


-(HFBabyHeaderAndName *)babyIcon {
    if (nil == _babyIcon) {
        _babyIcon = [HFBabyHeaderAndName new];
        _babyIcon.isBoy = YES;
    }
    return _babyIcon;
}

// *babyLearnLanguage, *cloudHomeInteraction, *cloudHomeGrowUp, *energyMath

/// 宝贝学语言
-(HFHomeMenusItem *)babyLearnLanguage {
    if (nil == _babyLearnLanguage) {
        _babyLearnLanguage = [HFHomeMenusItem new];
        _babyLearnLanguage.alpha = 0.0;
        _babyLearnLanguage.imageName = @"";
        _babyLearnLanguage.labContent = @"";
        _babyLearnLanguage.imageRect = CGRectMake(50, 36, 160, 73);
        _babyLearnLanguage.labRect = CGRectMake(96, 66, 100, 20);
    }
    return _babyLearnLanguage;
}

/// 云家园互动营
- (HFHomeMenusItem *)cloudHomeInteraction {
    if (nil == _cloudHomeInteraction) {
        BOOL isIphoneX = HFIsiPhoneX;
        _cloudHomeInteraction = [HFHomeMenusItem new];
        _cloudHomeInteraction.imageName = @"";
        _cloudHomeInteraction.labContent = @"";
        _cloudHomeInteraction.imageRect = CGRectMake(isIphoneX ? 70 : 44, isIphoneX ? 96 : 76, 134, 53);
        _cloudHomeInteraction.labRect = CGRectMake(isIphoneX ? 84 : 58, isIphoneX ? 110 : 90, 100, 20);
    }
    return _cloudHomeInteraction;
}

/// 云家园成长营
- (HFHomeMenusItem *)cloudHomeGrowUp {
    if (nil == _cloudHomeGrowUp) {
        BOOL isIphoneX = HFIsiPhoneX;
        _cloudHomeGrowUp = [HFHomeMenusItem new];
        _cloudHomeGrowUp.imageName = @"";
        _cloudHomeGrowUp.labContent = @"";
        _cloudHomeGrowUp.imageRect = CGRectMake(isIphoneX ? 80 : 70, isIphoneX ? 50 : 40, 176, 55);
        _cloudHomeGrowUp.labRect = CGRectMake(isIphoneX ? 130 : 120, isIphoneX ? 64 : 54, 100, 20);
    }
    return _cloudHomeGrowUp;
}

- (HFHomeMenusItem *)energyMath {
    if (nil == _energyMath) {
        BOOL isIphoneX = HFIsiPhoneX;
        _energyMath = [HFHomeMenusItem new];
        _energyMath.alpha = 0.0;
        _energyMath.imageName = @"";
        _energyMath.labContent = @"能量数学";
        _energyMath.imageRect = CGRectMake(isIphoneX ? 0 : 40, isIphoneX ? 30 : 38, 171, 57);
        _energyMath.labRect = CGRectMake(isIphoneX ? 40 : 80, isIphoneX ? 48 : 56, 100, 20);
    }
    return _energyMath;
}

-(UIButton *)changeBaby {
    if (nil == _changeBaby) {
        _changeBaby = [UIButton new];
        _changeBaby.hidden = YES;
        [_changeBaby setBackgroundImage:[UIImage imageNamed:@"ic_xiala"] forState:UIControlStateNormal];
        [_changeBaby addTarget: self action:@selector(changeBabyClick:) forControlEvents:UIControlEventTouchUpInside];
        [_changeBaby setEnlargeEdgeWithTop:5 right:5 bottom:5 left:5];
    }
    return _changeBaby;
}
- (UIView *)changeBabyBGView {
    if (nil == _changeBabyBGView) {
        _changeBabyBGView = [UIView new];
        _changeBabyBGView.layer.cornerRadius = 5.0;
        _changeBabyBGView.layer.masksToBounds = YES;
        _changeBabyBGView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        
    }
    return _changeBabyBGView;
}

-(UIView *)todayTasks {
    if (nil == _todayTasks) {
        _todayTasks = [UIView new];
    }
    return _todayTasks;
}

- (UILabel *)build {
    if (_build == nil) {
        _build = [[UILabel alloc]init];
        _build.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 20];
        _build.textColor = [UIColor whiteColor];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        _build.text = [NSString stringWithFormat:@"版本：iM-%@", app_build];
    }
    return _build;
}

#pragma mark 网络请求
//关卡预告or直播判断
- (void)requestForTodayTask{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    params[@"babyId"] = babyID;
    [Service postWithUrl:CurrentCourseAPI params:params success:^(NSDictionary *responseObject) {
        HFCourseForeshowModel *model = [HFCourseForeshowModel yy_modelWithDictionary:responseObject[@"model"]];
        if ([model.flag isEqualToString:@"1"]) {//flag为0是预告，为1是播放
            //播放
//            [self requestForClassVideoUrlWith:model];
            HFClassPreViewController *classPreView = [HFClassPreViewController new];
            [self presentViewController:classPreView animated:NO completion:nil];
//            HFLog(@"error:%@", error);
        }else{
            //预告
            HFClassPreViewController *classPreView = [HFClassPreViewController new];
            classPreView.model = model;
            classPreView.callBackPlay = ^{
                [self requestForClassVideoUrlWith:model];
            };
            [self presentViewController:classPreView animated:NO completion:nil];
        }
    } failure:^(HFError *error) {
        HFClassPreViewController *classPreView = [HFClassPreViewController new];
        [self presentViewController:classPreView animated:NO completion:nil];
        HFLog(@"error:%@", error);
    }];
}
//缴费红点
- (void)messageAlert {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [params setValue:[HFUserManager sharedHFUserManager].getUserInfo.babyInfo.kgId forKey:@"kgId"];
    [params setValue:babyID forKey:@"childId"];
    [params setValue:[HFUserManager sharedHFUserManager].getUserInfo.userId forKey:@"parentId"];
    [params setValue:@"1" forKey:@"appType"];
    [Service postWithUrl:messageAlertAPI params:params success:^(id responseObject) {
        int payMessage = [[[responseObject valueForKey:@"model"] valueForKey:@"payMessage"] intValue];
        if (payMessage > 0) {
            self.fiveColorGem.badgeBgColor = [UIColor redColor];
            self.fiveColorGem.badgeCenterOffset = CGPointMake(52, 13);
            [self.fiveColorGem showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
        } else {
            [self.fiveColorGem clearBadge];
        }
    } failure:^(HFError *error) {
        [MBProgressHUD showMessage:error.errorMessage];
    }];
}

//查找视频地址
- (void)requestForClassVideoUrlWith:(HFCourseForeshowModel *) model {
    NSString *babyId = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [ShowHUD showHUDLoading];
    [Service postWithUrl:PlayVideoAPI params:@{@"videoId": model.courseUrl, @"babyId": babyId} success:^(id responseObject) {
        
        [Service postWithUrl:GetGoIntoRoomStuSaveAPI params:@{@"babyId": babyId, @"courseId": model.courseId} success:nil failure:nil];
        [ShowHUD hiddenHUDLoading];
        HFVideoController *video = [HFVideoController new];
        NSError *error;
        HFClassVideoURLModel *modelTemp = [HFClassVideoURLModel fromJSON:[responseObject valueForKey:@"model"] encoding:4 error:&error];
        video.url = modelTemp.data.videoURL.lastObject.originURL;
        video.courseId = model.courseId;
        video.hiddenBottomBar = YES;
        video.titleText = model.courseName;
        video.classStartTime = model.startDate;
        video.weekDetailId = model.weekDetailId;
        [self presentViewController:video animated:NO completion:nil];
    } failure:^(HFError *error) {
        [ShowHUD hiddenHUDLoading];
        [MBProgressHUD showMessage:@"获取视频路径失败"];
    }];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:@"updateLogindata"];
}

@end
