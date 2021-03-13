//
//  UICollectionView+HF.m
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/6/29.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UICollectionView+HF.h"

@implementation UICollectionView (HF)

-(void)registerByIdentifiers:(NSArray *)identifiers
{
    for (NSString* identifier in identifiers)
    {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    }
   
}

/**
 @brief 标示符数组 NSArray<NSString>
 */
-(void)registerUnXibByIdentifiers:(NSArray *)identifiers{
    for (NSString* identifier in identifiers)
    {
        [self registerClass:NSClassFromString(identifier) forCellWithReuseIdentifier:identifier];
    }
}


-(void)registerSupplemHeadByIdentifiers:(NSArray *)identifiers{
    for (NSString* identifier in identifiers)
    {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];        
    }
}

-(void)registerSupplemFootByIdentifiers:(NSArray *)identifiers{
    for (NSString* identifier in identifiers)
    {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
    }
}





/**
 设置代理
 */
-(void)delegateAndDatasource:(id)de{
    self.delegate = de;
    self.dataSource = de;
}


@end
