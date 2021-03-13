//
//  UITableView+HFCategory.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/16.
//  Copyright © 2020 huifan. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HFCategory)

/**
 @brief 标示符数组 NSArray<NSString>
 */
-(void)registerByIdentifiers:(NSArray *)identifiers;


/**
 @brief 标示符数组 NSArray<NSString>
 //不是xib或者storyboard情况下
 */
-(void)registerUnXibByIdentifiers:(NSArray *)identifiers;


/**
 设置代理
 */
-(void)delegateAndDatasource:(id)de;

/**
刷新分组
*/
-(void)reloadSectionsIndex:(NSInteger)index;

/**
刷新某行
*/
-(void)reloadRowAtRow:(NSInteger)row section:(NSInteger)section;


@end

NS_ASSUME_NONNULL_END
