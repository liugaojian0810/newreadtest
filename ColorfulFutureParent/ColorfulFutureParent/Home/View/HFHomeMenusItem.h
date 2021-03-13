//
//  HFHomeMenusItem.h
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFHomeMenusItem : UIView
@property(nonatomic, assign) CGRect imageRect, labRect;
@property(nonatomic, copy) NSString *labContent, *imageName;
@end

NS_ASSUME_NONNULL_END
