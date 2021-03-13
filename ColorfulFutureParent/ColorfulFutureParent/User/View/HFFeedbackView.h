//
//  HFFeedbackView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"

@protocol feedbackDelegate <NSObject>

- (void)feedbackAddImage: (NSInteger)row;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HFFeedbackView : UIView<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *feesbackCollectionView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *feedbackBtnArr;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeBut;

@property (nonatomic, weak)id<feedbackDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)summitAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
