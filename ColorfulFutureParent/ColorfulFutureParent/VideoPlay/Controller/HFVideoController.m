//
//  HFVideoController.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/27.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFVideoController.h"
#import "UIDevice+HFDevice.h"

#import <SVGAPlayer/SVGAPlayer.h>
#import "SVGAParser.h"

#import <CNCMediaPlayerFramework/CNCMediaPlayerFramework.h>
#import "HFCountDown.h"
#import "HFClouldQuestionlModel.h"
#import "HFInteractionViewController.h"
#import "HFVoiceView.h"
#import "HFPublicAudioPlayProgressView.h"
#import "HFPlayBackViewController.h"
#import "HFPareScheduleController.h"
#import "HFAudioPlayer.h"
#import "HFLessonDetailModel.h"
#import "HFPosterListController.h"
#import "HFGetAnswer.h"
#import "ColorfulFutureParent-Swift.h"

@interface HFVideoController ()<HFPublicAudioPlayProgressViewDelegate, SVGAPlayerDelegate>
@property (nonatomic, strong) CNCMediaPlayerController *player;
@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) HFClouldQuestionlModel *questionlModel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) NSMutableArray<NSString *> *questIDList;
@property (nonatomic, strong) NSMutableDictionary<NSString *, HFRequestionList *> *questionDict;
@property (nonatomic, strong) HFPublicAudioPlayProgressView *progressView;
@property (nonatomic, strong) UIView *headerView, *bottomView;
@property (nonatomic, strong) UILabel *titleLab, *timeLab;
@property (nonatomic, assign) BOOL hiddenControllerView, drawBottomBar;
@property (nonatomic, strong) UIButton *bgBtn, *playBtn;
//@property (nonatomic, strong) UIButton *playbackBtn, *classCard, *shareBtn;
@property (nonatomic, strong) HFVideoPlayEnumListView *listView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) HFAnswerQuestionView *AQView;
@property (nonatomic, strong) HFGetAnswer *getAnswerModel;
@property (nonatomic, strong) NSArray<NSString *> *svgas;
@property (nonatomic, strong) SVGAPlayer *playerDH, *gemstone;
@end

@implementation HFVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.svgas = @[@"candy", @"flower", @"horse"];
    self.hiddenControllerView = NO;
    self.drawBottomBar = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hiddenControllerView = YES;
    });
    
    [UIDevice setHScreen];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.courseId forKey:@"courseId"];
    [dict setValue:self.weekDetailId forKey:@"weekDetailId"];
    
    [Service postWithUrl: GetByIdQuestionAPI params:dict success:^(id responseObject) {
        NSError *error;
        self.questionlModel = [HFClouldQuestionlModel fromJSON:[responseObject jk_JSONString] encoding:4 error: &error];
        NSMutableDictionary *option = [[NSMutableDictionary alloc] init];
        self.player = [[CNCMediaPlayerController alloc] initWithContentURL:[NSURL URLWithString: self.url] option:option];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerDidPrepare) name:CNCMediaPlayerLoadDidPrepareNotification object: self.player];
        self.player.scalingMode = 0;
        self.player.view.frame = self.view.bounds;
        [self.player prepareToPlay];
        [self.view addSubview:self.player.view];
        self.player.enableAccurateSeek = YES;
        [self.view addSubview: self.headerView];
        [self.headerView addSubview:self.btnBack];
        [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.headerView);
            make.left.mas_equalTo(36);
        }];
        for (HFRequestionList *item in self.questionlModel.model) {
            NSInteger second = [item.minute intValue] * 60 + [item.second intValue];
            if (second > 0) {
                if ([self.questionDict.allKeys containsObject: [NSString stringWithFormat:@"%ld", (long)second]]) {
                    continue;
                }
                [self.questionDict setValue: item forKey: [NSString stringWithFormat:@"%ld", (long)second]];
            }
        }
        [self.view bringSubviewToFront:self.bottomView];
        [self.view bringSubviewToFront:self.bgBtn];
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.view bringSubviewToFront:self.listView];
        [self.view bringSubviewToFront:self.bgView];
        [self.view bringSubviewToFront:self.AQView];
        [self.view bringSubviewToFront:self.playerDH];
        [self.view bringSubviewToFront:self.gemstone];
    } failure:^(HFError *error) {
        HFLog(@"error:%@",error);
    }];
    [self.view addSubview: self.bottomView];
    [self.bottomView addSubview: self.progressView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(62);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.top.bottom.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(90);
    }];
    
    [self.view addSubview:self.bgBtn];
    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(70);
        make.bottom.mas_equalTo(-70);
    }];
    self.listView = [HFVideoPlayEnumListView new];
    [self.listView rightEnumsWithIsLive: self.hiddenBottomBar];
    [self.listView callBackBlockWithBlock:^(BOOL isOpen) {
        [UIView animateWithDuration:0.4 animations:^{
            [self.listView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.view);
                make.right.mas_equalTo(isOpen ? 0: 78);
            }];
            [self.view layoutIfNeeded];
        }];
    }];
    [self.listView enumClickCallBackBlockWithBlock:^(NSInteger status) {
        [self enumClick:status];
    }];
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.right.mas_equalTo(78);
    }];
    
    self.AQView = [HFAnswerQuestionView new];
    [self.AQView setHidden:YES];
    self.AQView.layer.cornerRadius = 12;
    self.AQView.layer.masksToBounds = YES;
    self.AQView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.AQView];
    [self.AQView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(380);
        make.height.mas_equalTo(140);
    }];
    self.bgView = [[UIView alloc] initWithFrame: CGRectZero];
    self.bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    [self.view addSubview:self.bgView];
    [self.view addSubview: self.playerDH];
    [self.view addSubview: self.gemstone];
}

-(void)dealloc{
    
    HFLog(@"HFVideoController dealloc");
    
}

-(void)bgBtnClick {
    self.hiddenControllerView = !self.hiddenControllerView;
}

-(void)enumClick:(NSInteger) index {
    [self.player pause];
    switch (index) {
        case 0:
        {
            HFPlayBackVideoViewController * pbv = [HFPlayBackVideoViewController new];
            [self presentViewController:pbv animated:NO completion:nil];
        }
            break;
        case 1:
        {
            HFPareScheduleController *schedule = [HFPareScheduleController new];
            [self presentViewController:schedule animated:NO completion:nil];
        }
            break;
        case 2:
        {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            
            HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager] getUserInfo];
            
            [param setValue:SafeParamStr(userInfo.userId) forKey:@"userId"];
            [param setValue:SafeParamStr(userInfo.babyInfo.babyID) forKey:@"ownerId"];
            [param setValue:@0 forKey:@"clientType"];// 端类型:0 家长 1 教师 2 园长
            [param setValue:@1 forKey:@"goodsId"];
            [param setValue:@2 forKey:@"earningsSource"];
            [ShowHUD showHUDLoading];
            [Service postWithUrl:CloudHomeDetailAPI params:param success:^(id responseObject) {
                [ShowHUD hiddenHUDLoading];
                NSDictionary *dataDic = [responseObject objectForKey:@"model"];
                HFLessonDetailModel *detailModel = [HFLessonDetailModel mj_objectWithKeyValues:dataDic];
                HFPosterListController * poster = [[HFPosterListController alloc] init];
                poster.fromeType = FRIEND;
                poster.detailModel = detailModel;
                [self presentViewController:poster animated:YES completion:nil];    } failure:^(HFError *error) {
                    [ShowHUD hiddenHUDLoading];
                    
                }];
        }
            break;
            
        default:
            break;
    }
}

-(void)setHiddenControllerView:(BOOL)hiddenControllerView {
    _hiddenControllerView = hiddenControllerView;
    [self.headerView setHidden: hiddenControllerView];
    [self.bottomView setHidden: (hiddenControllerView | self.hiddenBottomBar)];
}

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.titleLab.text = _titleText;
}

-(void)cncPlayerDidPrepare {
    self.player.currentPlaybackTime = self.second;
}

-(void)changePlayTimeByPublicAudioPlayProgressView:(int)playCount {
    // 拖动进度条
    HFLog(@"拖动进度条:%d", playCount);
    int total = (int)self.player.duration;
    self.timeLab.text = [NSString stringWithFormat:@"%02d:%02d/%02d:%02d",playCount / 60,playCount % 60,total / 60,total % 60];
    if (self.drawBottomBar) {
        return;
    }
    if (self.player.playbackState != CNC_PLAYER_STATE_ON_MEDIA_START) {
        [self.player play];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.player.currentPlaybackTime = playCount;
        });
    }
    self.player.currentPlaybackTime = playCount;
}

-(void)setClassStartTime:(NSString *)classStartTime {
    NSArray *time = [classStartTime componentsSeparatedByString:@":"];
    if (time.count == 2) {
        NSDate *dateNow = [HFCountDown getServerTime];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"HH:mm:ss"];//yyyy年MM月dd日
        NSArray *dateString = [[formatter stringFromDate: dateNow] componentsSeparatedByString:@":"];
        NSInteger hours = [dateString[0] integerValue];
        NSInteger minutes = [dateString[1] integerValue];
        NSInteger second = [dateString[2] integerValue];
        NSInteger serverSecond = hours * 60 * 60 + minutes * 60 + second;
        NSInteger seconds = [time[0] integerValue] * 60 * 60 + [time[1] integerValue] * 60;
        self.second = (serverSecond - seconds);
    }
}

-(void)timeChange {
    NSString *second = [NSString stringWithFormat:@"%ld", lround(self.player.currentPlaybackTime)];
    int currentTime = (int)lround(self.player.currentPlaybackTime);
    int total = (int)self.player.duration;
    if (currentTime == total) {
        [self.playBtn setSelected: currentTime == total];
    }
    self.timeLab.text = [NSString stringWithFormat:@"%02d:%02d/%02d:%02d",currentTime / 60,currentTime % 60,total / 60,total % 60];
    if (self.drawBottomBar) {
        return;
    }
    [self.progressView changePlayProgress: currentTime totalLength: self.player.duration];
    HFLog(@"当前播放到:%@", second);
    HFRequestionList *questList = [self.questionDict valueForKey: second];
    if ((questList != nil) & ![self.questIDList containsObject:second]) {
        HFLog(@"当前播放到:我抓到你了，啊哈哈哈哈");
        self.bgView.frame = self.view.bounds;
        [self.questIDList addObject: second];
        WS(weakSelf);
        if (questList.interactType == 0) {
            [self.player pause];
            // 开麦互动
            HFVoiceView *voiceView = [[HFVoiceView alloc] initWithFrame:self.view.bounds];
            voiceView.secondNum = questList.waitingTime;
            voiceView.courseId = self.courseId;
            voiceView.questionList = questList;
            voiceView.playType = self.hiddenBottomBar ? @"1": @"2";
            voiceView.weekDetailId = self.weekDetailId;
            [self.view addSubview:voiceView];
            voiceView.backBlock = ^{
                
            };
            voiceView.answerBlock = ^(HFGetAnswer * _Nullable answerModel) {
                [weakSelf playDH: answerModel callback:^{
                    
                }];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.questIDList removeAllObjects];
                    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:nil];
                });
            };
        } else if(questList.interactType == 1) {
            // 触屏互动
            [self.player pause];
            [self.AQView setHidden: NO];
            self.AQView.questionList = questList;
            [self.AQView enumClickCallBackBlockWithBlock:^(NSInteger index) {
                
                [self checkAnswer:questList choiceIndex:index];
            }];
        }
    }
}

-(void)checkAnswer:(HFRequestionList *) questionList choiceIndex:(NSUInteger) index  {
    NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
    NSString *babyId = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [dictParams setValue: babyId forKey:@"babyId"];
    [dictParams setValue: self.courseId forKey: @"courseId"];
    [dictParams setValue: @(questionList.identifier) forKey:@"questionsId"];
    [dictParams setValue: @(questionList.list[index].identifier) forKey: @"isRealanswerId"];
    [dictParams setValue: self.hiddenBottomBar ? @"1": @"2" forKey: @"playType"];
    [dictParams setValue: @"1" forKey: @"interactType"];
    [dictParams setValue: @"0" forKey:@"decibels"];
    [dictParams setValue: self.weekDetailId forKey:@"weekDetailId"];
    [ShowHUD showHUDLoading];
    [Service postWithUrl:GetAnswerAPI params:dictParams success:^(id responseObject) {
        [ShowHUD hiddenHUDLoading];
        HFLog(@"responseObject:%@",responseObject);
        // 触屏互动结果
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSError *error;
            self.getAnswerModel = [HFGetAnswer fromJSON:[responseObject jk_JSONString] encoding:4 error: &error];
            // 播放动画
            [self playDH:self.getAnswerModel callback:^{
                [self.AQView setHidden:YES];
            }];
            //            [self.player play];
        });
    } failure:^(HFError *error) {
        HFLog(@"error:%@",error);
        [ShowHUD hiddenHUDLoading];
//        [MBProgressHUD showMessage:error.errorMessage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.bgView.frame = CGRectZero;
            [self.player play];
            [self.AQView setHidden:YES];
        });
    }];
}

-(void)playDH:(HFGetAnswer *) getAnswerModel callback:(OptionBlock)block{
    if (getAnswerModel.model.isFlag) {
        // 正确
        [self playSuccessWithGemstoneCount: getAnswerModel.model.currentNum];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            HFAudioPlayer *audio = [HFAudioPlayer new];
            [audio playWithName:@"voice_good.mp3"];
            block();
        });
    } else {
        // 错误
        [self playFailWithGemstoneCount: getAnswerModel.model.currentNum];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            HFAudioPlayer *audio = [HFAudioPlayer new];
            [audio playWithName:@"voice_keep_going.mp3"];
            block();
        });
    }
}

-(void)playSuccessWithGemstoneCount:(NSInteger) count {
    if (count > 0) {
        // 回答正确，并且宝石数量大于0
        [self playAnimationWithGemstoneCount:count];
    } else {
        // 回答正确，但是宝石数量等于0
        [self successPlayAnimationWithGemstoneCount];
    }
}

-(void)playFailWithGemstoneCount:(NSInteger) count {
    if (count > 0) {
        // 回答错误，并且宝石数量大于0
        [self failPlayAnimationWithStoneCount:count];
    } else {
        // 回答错误，但是宝石数量等于0
        [self failPlayAnimationWithGemstoneCount];
    }
}

/// 正确，有宝石
/// @param count 宝石数量
-(void)playAnimationWithGemstoneCount:(NSInteger) count {
    [self playSvga:@"good_stone" part:[NSString stringWithFormat:@"%ld",(long)count]];
}


/// 正确，没有宝石
-(void)successPlayAnimationWithGemstoneCount {
    // 成功，没有宝石
    [self playSvga:@"good_nostone" part:self.svgas[rand() % 3]];
}

/// 错误，有宝石
-(void)failPlayAnimationWithStoneCount:(NSInteger) count {
    [self playSvga:@"keep_stone" part:[NSString stringWithFormat:@"%ld",(long)count]];
}

/// 错误，没有宝石
-(void)failPlayAnimationWithGemstoneCount {
    // 成功，没有宝石
    [self playSvga:@"keep_nostone" part:self.svgas[rand() % 3]];
}

-(void)playSvga:(NSString *) status part:(NSString *) part{
    dispatch_group_t group = dispatch_group_create();
    
    self.playerDH = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    self.playerDH.delegate = self;
    [self.view addSubview: self.playerDH];
    self.playerDH.center = self.view.center;
    self.playerDH.loops = 1;
    self.playerDH.clearsAfterStop = YES;
    
    self.gemstone = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    self.gemstone.delegate = self;
    [self.view addSubview: self.gemstone];
    self.gemstone.center = self.view.center;
    self.gemstone.loops = 1;
    self.gemstone.clearsAfterStop = YES;
    [self setAnimation:group andPlayer:self.playerDH animationName:status];
    [self setAnimation:group andPlayer:self.gemstone animationName: part];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.playerDH startAnimation];
        [self.gemstone startAnimation];
    });
}

-(void)setAnimation:(dispatch_group_t) group andPlayer:(SVGAPlayer *) player animationName:(NSString *) animationName {
    
    dispatch_group_enter(group);
    self.gemstone.center = self.view.center;
    SVGAParser *parser = [SVGAParser new];
    [parser parseWithNamed:animationName inBundle:[NSBundle mainBundle] completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        // 动画加载成功成功
        if (nil != videoItem) {
            [self.AQView setHidden: YES];
            player.videoItem = videoItem;
            dispatch_group_leave(group);
        }
    } failureBlock:^(NSError * _Nonnull error) {
        // 失败
        HFLog(@"error:%@", error);
        dispatch_group_leave(group);
    }];
}
-(void)playAnimation:(NSString *) animationName{
    self.playerDH = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    self.playerDH.delegate = self;
    [self.view addSubview: self.playerDH];
    self.playerDH.center = self.view.center;
    self.playerDH.loops = 1;
    self.playerDH.clearsAfterStop = YES;
    
    SVGAParser *parser = [SVGAParser new];
    [parser parseWithNamed:animationName inBundle:[NSBundle mainBundle] completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        // 动画加载成功成功
        if (nil != videoItem) {
            [self.AQView setHidden: YES];
            self.playerDH.videoItem = videoItem;
            [self.playerDH startAnimation];
        }
    } failureBlock:^(NSError * _Nonnull error) {
        // 失败
        
    }];
}

-(void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player {
    [player removeFromSuperview];
    self.bgView.frame = CGRectZero;
    // 继续播放
    [self.player play];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.questIDList removeAllObjects];
    });
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:nil];
}


-(void)btnBackClick {
    [self.player pause];
    [self.player shutdown];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.timer invalidate];
    self.timer = nil;
    
}

-(void)playBtnClick:(UIButton *) sender {
    [sender setSelected: !sender.isSelected];
    if (sender.isSelected) {
        [self.player pause];
    } else {
        [self.player play];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player pause];
}

-(UIButton *)btnBack {
    if (nil == _btnBack) {
        _btnBack = [UIButton new];
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"icon-fanhui"] forState:UIControlStateNormal];
        _btnBack.jk_touchAreaInsets = UIEdgeInsetsMake(-60, -60, -60, -60);
        [_btnBack addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}

-(NSMutableDictionary *)questionDict {
    if (nil == _questionDict) {
        _questionDict = [NSMutableDictionary new];
    }
    return _questionDict;
}

-(NSMutableArray<NSString *> *)questIDList {
    if (nil == _questIDList) {
        _questIDList = [NSMutableArray array];
    }
    return _questIDList;
}

-(HFPublicAudioPlayProgressView *)progressView {
    if (nil == _progressView) {
        _progressView = [HFPublicAudioPlayProgressView HFpublicAudioPlayProgressView: CGRectMake(90, 0, HFCREEN_WIDTH - 90 * 2, 62)];
        WS(weakSelf);
        _progressView.stop = ^{
            weakSelf.drawBottomBar = YES;
        };
        
        _progressView.start = ^{
            weakSelf.drawBottomBar = NO;
        };
        _progressView.delegate = self;
    }
    return _progressView;
}

-(UIView *)headerView {
    if (nil == _headerView) {
        _headerView = [UIView new];
        _headerView.frame = CGRectMake(0, 0, HFCREEN_WIDTH, 60);
        _headerView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.6];
        [_headerView addSubview: self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_headerView);
        }];
    }
    return _headerView;
}

-(UIView *)bottomView {
    if (nil == _bottomView) {
        _bottomView = [UIView new];
        _bottomView.frame = CGRectMake(0, HFCREEN_HEIGHT - 62, HFCREEN_WIDTH, 62);
        _bottomView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.6];
        [_bottomView addSubview: self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomView);
            make.width.height.mas_equalTo(38);
            make.left.mas_equalTo(24);
        }];
        
        [_bottomView addSubview: self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomView);
            make.right.mas_equalTo(-4);
        }];
    }
    return _bottomView;
}

-(UILabel *)titleLab {
    if (nil == _titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLab;
}

-(UIButton *)bgBtn {
    if (nil == _bgBtn) {
        _bgBtn = [UIButton new];
        [_bgBtn setBackgroundColor:[UIColor clearColor]];
        [_bgBtn addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

-(UIButton *)playBtn {
    if (nil == _playBtn) {
        _playBtn = [UIButton new];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"btn-zanting"] forState:UIControlStateNormal];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"btn-bofang"] forState:UIControlStateSelected];
        [_playBtn addTarget: self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

-(UILabel *)timeLab {
    if (nil == _timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = [UIFont boldSystemFontOfSize:14];
        _timeLab.textColor = [UIColor whiteColor];
    }
    return _timeLab;
}

@end
