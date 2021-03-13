//
//  HFCancelWaringView.h
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFAttributeTapLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFCancelWaringView : UIView

@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBut;
@property (weak, nonatomic) IBOutlet HFAttributeTapLabel *agreementAttLab;

/** 提现 */
@property (nonatomic, copy) dispatch_block_t  withdrawBlock;

/** 点击同意*/
@property (nonatomic, copy) dispatch_block_t  agreeBlock;

/** 下一步 */
@property (nonatomic, copy) dispatch_block_t  nextStepBlock;



@end

NS_ASSUME_NONNULL_END
