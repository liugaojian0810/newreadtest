//
//  HFVisionUpdateView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^VisionUpdateBlock)();

@interface HFVisionUpdateView : UIView

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property(nonatomic, copy)VisionUpdateBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
