//
//  HFFeedbackCollectionViewCell.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface HFFeedbackCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (nonatomic, copy) OptionBlock deleteBlock;


@end

NS_ASSUME_NONNULL_END
