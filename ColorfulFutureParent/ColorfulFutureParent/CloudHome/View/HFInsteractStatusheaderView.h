//
//  HFInsteractStatusheaderView.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^insteractStatusSheaderBlock)(NSInteger tag);

@interface HFInsteractStatusheaderView : UIView
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArr;
@property (nonatomic, copy)insteractStatusSheaderBlock block;

@end

NS_ASSUME_NONNULL_END
