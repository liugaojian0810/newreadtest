//
//  HFAudioPlayer.m
//  ColorfulFutureParent
//
//  Created by huifan on 2020/6/10.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation HFAudioPlayer

-(instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
-(void)playWithName:(NSString *)audioName {
     SystemSoundID soundID=0;
     // 获取资源文件
     NSURL *url = [[NSBundle mainBundle] URLForResource:audioName  withExtension:nil];
     if (url == nil) return;
     // 获取音频的soundID
     AudioServicesCreateSystemSoundID(CFBridgingRetain(url), &soundID);
     AudioServicesPlaySystemSound(soundID);
}
@end
