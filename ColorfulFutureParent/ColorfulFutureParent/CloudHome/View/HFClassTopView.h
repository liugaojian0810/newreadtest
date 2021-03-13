//
//  HFClassTopView.h
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/6/21.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFClassTopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *accountLab;

@property (nonatomic, copy) dispatch_block_t shareBlock;
@end

NS_ASSUME_NONNULL_END
