//
//  HFBabyIconAndName.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBabyListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFBabyHeaderAndName : UIView

@property(nonatomic, copy) NSString *babyName, *babyHeaderURL;
@property(nonatomic, assign) BOOL isBoy;
@property (nonatomic,strong)HFModel * babyInfoModel;//宝宝个人信息
@property (nonatomic, strong)NSDictionary *dic;//默认宝宝信息


@end

NS_ASSUME_NONNULL_END
