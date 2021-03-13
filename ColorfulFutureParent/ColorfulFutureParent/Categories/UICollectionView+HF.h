//
//  UICollectionView+HF.h
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/6/29.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (HF)

/**
 @brief 标示符数组 NSArray<NSString>
 */
-(void)registerByIdentifiers:(NSArray *)identifiers;


/**
 @brief 标示符数组 NSArray<NSString>
 //不是xib或者storyboard情况下
 */
-(void)registerUnXibByIdentifiers:(NSArray *)identifiers;


-(void)registerSupplemHeadByIdentifiers:(NSArray *)identifiers;

-(void)registerSupplemFootByIdentifiers:(NSArray *)identifiers;


/**
 设置代理
 */
-(void)delegateAndDatasource:(id)de;

@end

NS_ASSUME_NONNULL_END
