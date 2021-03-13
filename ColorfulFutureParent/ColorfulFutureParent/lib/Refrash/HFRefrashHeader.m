//
//  HFRefrashHeader.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFRefrashHeader.h"

@implementation HFRefrashHeader

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:8];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:8];
    //普通状态
    [self setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}

#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"Loading_%zd.tiff",i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}


@end
