//
//  HFPrincipalScheduleIDetailItem.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPrincipalScheduleIDetailItem : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *letter;
@property (weak, nonatomic) IBOutlet UILabel *period;
@end

NS_ASSUME_NONNULL_END
