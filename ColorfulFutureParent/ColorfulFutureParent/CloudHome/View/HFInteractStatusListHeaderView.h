//
//  HFInteractStatusListHeaderView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/10.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^interactStatusListHeaderBlock)(NSInteger tag);

@interface HFInteractStatusListHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *statusListHeaderBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWithNum;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArr;
@property (nonatomic, copy)interactStatusListHeaderBlock block;


@end

NS_ASSUME_NONNULL_END
