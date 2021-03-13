//
//  HFVoiceView.m
//  ColorfulFutureParent
//
//  Created by huifan on 2020/6/1.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFVoiceView.h"
#import <AVFoundation/AVFoundation.h>
#import <SVGAPlayer/SVGAPlayer.h>
#import "SVGAParser.h"
#import "HFAudioPlayer.h"
#import "TBCycleView.h"

#define FENBEI 60

@interface HFVoiceView ()<SVGAPlayerDelegate>
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) UIView *bgView, *waveBGView;
@property (nonatomic, strong) NSTimer *levelTimer, *timer;
@property (nonatomic, strong) HFGetAnswer *getAnswerModel;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) SVGAPlayer *playerDH;
//@property (nonatomic, strong) SVGAParser *parser;
@property (nonatomic, strong) TBCycleView *cycleView, *cycleBGView;
@property (nonatomic, assign) CGFloat current;
@end

@implementation HFVoiceView

-(instancetype)init {
    if (self = [super init]) {
        [self addMySubViews];
        [self addMasonry];
        [self cshVoiceDevice];
        [self daoJS];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMySubViews];
        [self addMasonry];
        [self cshVoiceDevice];
        [self daoJS];
    }
    return self;
}

-(void)addMySubViews {
    [self addSubview: self.bgView];
    [self addSubview: self.cycleBGView];
    [self addSubview: self.cycleView];
    [self addSubview: self.playerDH];
}

-(void)addMasonry {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
}

-(void)daoJS {
    
}

-(void)cshVoiceDevice {
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                nil];
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (self.recorder)
    {
        [self.recorder prepareToRecord];
        self.recorder.meteringEnabled = YES;
        [self.recorder record];
        self.levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback3:) userInfo: nil repeats: YES];
    }
    else
    {
        HFLog(@"%@", [error description]);
    }
}
- (void)levelTimerCallback3:(NSTimer *)timer {
    if (self.secondNum <= 0.09) {
        [self.recorder stop];
        [self removeFromSuperview];
        [self.timer invalidate];
        self.timer = nil;
        [self.levelTimer invalidate];
        self.levelTimer = nil;
        self.bgView.alpha = 1.0;
        
        NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
        NSString *babyId = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
        [dictParams setValue: babyId forKey:@"babyId"];
        [dictParams setValue: self.courseId forKey: @"courseId"];
        [dictParams setValue: @(self.questionList.identifier) forKey:@"questionsId"];
        [dictParams setValue: self.playType forKey: @"playType"];
        [dictParams setValue: @"2" forKey: @"interactType"];
        [dictParams setValue: @(self.level) forKey:@"decibels"];
        [dictParams setValue: self.weekDetailId forKey:@"weekDetailId"];
        [ShowHUD showHUDLoading];
        [Service postWithUrl: GetAnswerAPI params: dictParams success:^(id responseObject) {
            [ShowHUD hiddenHUDLoading];
            HFLog(@"responseObject:%@",responseObject);
            [self.recorder stop];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:nil];
            NSError *error;
            self.getAnswerModel = [HFGetAnswer fromJSON:[responseObject jk_JSONString] encoding:4 error: &error];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryMultiRoute error:nil];
//            HFAudioPlayer *audio = [HFAudioPlayer new];
//            [audio playWithName:@"voice_keep_going.mp3"];
            if (self.backBlock) {
                self.backBlock();
            }
            if (self.answerBlock) {
                self.answerBlock(self.getAnswerModel);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        } failure:^(HFError *error) {
            [ShowHUD hiddenHUDLoading];
            HFLog(@"error:%@",error);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.backBlock) {
                    [self.recorder stop];
                    [self removeFromSuperview];
                    self.backBlock();
                }
                
            });
        }];
        
        
    } else {
        self.secondNum -= 0.03;
        [self.cycleView drawProgress: (self.secondNum / self.current)];
        [self.cycleBGView drawProgress: 1.0];
    }
}

-(void)setSecondNum:(CGFloat)secondNum {
    _secondNum = secondNum;
    if (self.current == 0) {
        self.current = secondNum;
    }
}

- (void)levelTimerCallback:(NSTimer *)timer {
    [self.recorder updateMeters];
 
    float   level;                // The linear 0.0 .. 1.0 value we need.
    float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    float   decibels    = [self.recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels)
    {
        level = 0.0f;
    }
    else if (decibels >= 0.0f)
    {
        level = 1.0f;
    }
    else
    {
        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * decibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger levelInt = (NSInteger)(level * 80);
        self.level = levelInt > self.level ? levelInt : self.level;
        HFLog(@"分贝值为:%ld", (long)self.level);
        HFLog(@"levelInt分贝值为:%ld", (long)levelInt);
        // 是否播放动画
        if (levelInt >= 30) {
            // 播放
            [self.playerDH startAnimation];
        } else {
            // 暂停
            [self.playerDH pauseAnimation];
        }
    });
}

-(UIView *)bgView {
    if (nil == _bgView) {
        _bgView = [UIView new];
        _bgView.alpha = 0;
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

-(UIView *)waveBGView {
    if (nil == _waveBGView) {
        _waveBGView = [UIView new];
    }
    return _waveBGView;
}

-(SVGAPlayer *)playerDH {
    if (nil == _playerDH) {
        _playerDH = [[SVGAPlayer alloc] initWithFrame: CGRectMake((self.frame.size.width - 200) * 0.5, self.frame.size.height - 200, 200, 200)];
        _playerDH.delegate = self;
        _playerDH.loops = 0;
        _playerDH.clearsAfterStop = YES;
        
        SVGAParser *parser = [SVGAParser new];
        [parser parseWithNamed:@"mic" inBundle:[NSBundle mainBundle]  completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            self->_playerDH.videoItem = videoItem;
            [self->_playerDH startAnimation];
        } failureBlock:^(NSError * _Nonnull error) {
            
        }];
    }
    return _playerDH;
}

//- (SVGAParser *)parser {
//    if (nil == _parser) {
//        _parser = [SVGAParser new];
//        [_parser parseWithNamed:@"mic" inBundle:[NSBundle mainBundle]  completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
//            self.playerDH.videoItem = videoItem;
//        } failureBlock:^(NSError * _Nonnull error) {
//
//        }];
//    }
//    return _parser;
//}

-(TBCycleView *)cycleView {
    if (nil == _cycleView) {
        _cycleView = [[TBCycleView alloc] initWithFrame:CGRectMake((self.frame.size.width - 200) * 0.5, self.frame.size.height - 200, 200, 200)];
        _cycleView.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor];
    }
    return _cycleView;
}

-(TBCycleView *)cycleBGView {
    if (nil == _cycleBGView) {
        _cycleBGView = [[TBCycleView alloc] initWithFrame:CGRectMake((self.frame.size.width - 200) * 0.5, self.frame.size.height - 200, 200, 200)];
        _cycleBGView.colors = @[(id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6].CGColor, (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6].CGColor];
    }
    return _cycleBGView;
}

@end
