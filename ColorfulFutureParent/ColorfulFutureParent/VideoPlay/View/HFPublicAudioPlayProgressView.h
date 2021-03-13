//
//  PublicAudioPlayProgressView.h
//  ProjectFramework
//
//  Created by Mac on 2019/4/24.
//  Copyright © 2019 hsrd-hq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HFPublicAudioPlayProgressViewDelegate <NSObject>

- (void) changePlayTimeByPublicAudioPlayProgressView : (int) playCount;

@end

@interface HFPublicAudioPlayProgressView : UIView

+ (instancetype) HFpublicAudioPlayProgressView : (CGRect) frame;

@property (nonatomic, weak) id<HFPublicAudioPlayProgressViewDelegate> delegate;

- (void)changeCanPlayAbleProgress:(int)progressFloat totalLength:(int)totalCount;

- (void) changePlayProgress : (int) progressFloat totalLength : (int) totalCount;

@property(nonatomic, copy) dispatch_block_t stop, start;

@end

NS_ASSUME_NONNULL_END
