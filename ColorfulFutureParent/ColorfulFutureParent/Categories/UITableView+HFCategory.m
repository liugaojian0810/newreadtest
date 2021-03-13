//
//  UITableView+HFCategory.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/16.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UITableView+HFCategory.h"

@implementation UITableView (HFCategory)

-(void)registerByIdentifiers:(NSArray *)identifiers
{
    for (NSString* identifier in identifiers)
    {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }
   
}

/**
 @brief 标示符数组 NSArray<NSString>
 */
-(void)registerUnXibByIdentifiers:(NSArray *)identifiers{
    for (NSString* identifier in identifiers)
    {
        [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }
}


/**
 设置代理
 */
-(void)delegateAndDatasource:(id)de{
    self.delegate = de;
    self.dataSource = de;
}

/**
刷新分组
*/
-(void)reloadSectionsIndex:(NSInteger)index{
    
    [self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];

}

/**
刷新某行
*/
-(void)reloadRowAtRow:(NSInteger)row section:(NSInteger)section{
    
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationNone];

}

@end
