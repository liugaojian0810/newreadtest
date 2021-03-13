//
//  HFCreatePosterBottomView.h
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/6/15.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HFCreatePosterBottomBlock)(NSInteger index);

@interface HFCreatePosterBottomView : UITableViewCell

@property(nonatomic, copy)HFCreatePosterBottomBlock clickBlock;


@end

NS_ASSUME_NONNULL_END
