//
//  HFInteractionViewController.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFClouldQuestionlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFInteractionViewController : UIViewController
@property(nonatomic, strong) HFRequestionList *questionList;
@property(nonatomic, copy) dispatch_block_t backBlock;
@property(nonatomic, copy) NSString *question;
@property(nonatomic, copy) NSString *courseId, *playType;
@property (nonatomic, strong) NSString *weekDetailId;
@end

NS_ASSUME_NONNULL_END
