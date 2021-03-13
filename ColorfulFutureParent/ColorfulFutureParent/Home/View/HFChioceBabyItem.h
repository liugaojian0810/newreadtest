//
//  HFChioceBabyItem.h
//  ColorfulFutureParent
//
//  Created by liugaojian on 2020/6/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFBabyListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFChioceBabyItem : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong)HFModel * babyInfoModel;//宝宝个人信息

@end

NS_ASSUME_NONNULL_END
