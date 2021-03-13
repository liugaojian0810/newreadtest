//
//  HFLiveBroadcastController.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/13.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFLiveBroadcastController.h"
#import <CNCMediaPlayerFramework/CNCMediaPlayerFramework.h>

@interface HFLiveBroadcastController ()
@property (nonatomic, strong) CNCMediaPlayerController *player;
@property (nonatomic, strong) UIButton *refresh;
@end

@implementation HFLiveBroadcastController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *option = [[NSMutableDictionary alloc] init];
    self.player = [[CNCMediaPlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://vod-test-play.8686c.com/SeeYouAgain_0.m3u8"] option:option];
    self.player.view.frame = self.view.bounds;
    [self.player prepareToPlay];
    [self.view addSubview:self.player.view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HFLog(@"当前播放到:%f", self.player.currentPlaybackTime);
}



@end
