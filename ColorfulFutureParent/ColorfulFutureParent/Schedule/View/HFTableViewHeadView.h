//
//  HFTableViewHeadView.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFTableViewHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIScrollView *rightScrollView;

@property (nonatomic, strong) UILabel *nameLabel;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                              parameter:(NSDictionary *)parameter;


@end

NS_ASSUME_NONNULL_END
