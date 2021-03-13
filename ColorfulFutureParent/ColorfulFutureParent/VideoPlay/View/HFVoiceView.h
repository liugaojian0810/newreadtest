//
//  HFVoiceView.h
//  ColorfulFutureParent
//
//  Created by huifan on 2020/6/1.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFClouldQuestionlModel.h"
#import "HFGetAnswer.h"
typedef void (^AudioQuestionBlock)(HFGetAnswer * _Nullable answerModel);
NS_ASSUME_NONNULL_BEGIN

@interface HFVoiceView : UIView
@property(nonatomic, strong) HFRequestionList *questionList;
@property(nonatomic, assign) CGFloat questionsId, secondNum;
@property(nonatomic, copy) dispatch_block_t backBlock;
@property(nonatomic, copy) AudioQuestionBlock answerBlock;
@property(nonatomic, copy) NSString *courseId, *playType;
@property (nonatomic, strong) NSString *weekDetailId;

@end

NS_ASSUME_NONNULL_END
