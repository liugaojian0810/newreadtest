//
//  HFChangeCompleViewController.h
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

//#import "HFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFChangeCompleViewController : UIViewController

@property(nonatomic, strong)NSString *oldPhone;

@property(nonatomic, copy)OptionBlock completeBlock;

@end

NS_ASSUME_NONNULL_END
