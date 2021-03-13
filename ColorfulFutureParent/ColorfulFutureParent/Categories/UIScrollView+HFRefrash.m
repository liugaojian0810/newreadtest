//
//  UIScrollView+HFRefrash.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UIScrollView+HFRefrash.h"
#import "HFRefrashHeader.h"
#import "HFRefrashFooter.h"
#import "HFNetworkCheck.h"


@implementation UIScrollView (HFRefrash)

//@dynamic noDataLabel;

-(void)headerRefreshingBlock:(HFRefreshRefreshingBlock)refreshing{
    WeakSelf
    HFRefrashHeader* header=[HFRefrashHeader headerWithRefreshingBlock:^{
        Strong_Self
        if ([HFNetworkCheck sharedHFNetworkCheck].available) {
            self.page = 1;
            refreshing(self.page);
        }else{
            refreshing(1);
        }
    }];
    self.mj_header=header;
    self.mj_footer.hidden=NO;
}

-(void)footerRefreshingBlock:(HFRefreshRefreshingBlock)refreshing{
    self.page = 1;
    WeakSelf
    HFRefrashFooter* footer = [HFRefrashFooter footerWithRefreshingBlock:^{
        Strong_Self
        self.page++;
        refreshing(self.page);
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    footer.hidden = NO;
    self.mj_footer = footer;
//    [self resetIsShowFooter];
}


-(void)endRefreshByIsDownRefresh:(BOOL)downRefresh isRequestSuccess:(BOOL)isRequestSuccess total:(NSInteger)total pageSize:(NSInteger)pageSize{
    [self endRefreshByIsDownRefresh:downRefresh isRequestSuccess:isRequestSuccess total:total pageSize:pageSize isShowError:YES];
}

-(void)endRefreshByIsDownRefresh:(BOOL)downRefresh isRequestSuccess:(BOOL)isRequestSuccess total:(NSInteger)total{
    [self endRefreshByIsDownRefresh:downRefresh isRequestSuccess:isRequestSuccess total:total pageSize:15];
}

-(void)hf_endRefreshIsDown:(BOOL)downRefresh isRequestSuccess:(BOOL)success total:(NSInteger)total count:(NSInteger)count{
    self.mj_footer.hidden = NO;
    if (downRefresh){
        self.totalCount = total;
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
        if (success){
            self.mj_footer.hidden = NO;
            if (total==count){
                [self.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.mj_footer endRefreshing];
            }
        }
    }else{
        //上拉刷新
        if (success){
            //重置页码
            if (self.totalCount == total){
                [self.mj_footer endRefreshingWithNoMoreData];
            }else{
                self.totalCount = total;
                if (total==count){
                    [self.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.mj_footer endRefreshing];
                }
            }
        }else{
            self.page--;
            [self.mj_footer endRefreshing];
        }
    }
    if (total==0){
        self.mj_footer.hidden = YES;
    }
    if ([self isMemberOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
    }else if ([self isMemberOfClass:[UICollectionView class]]){
        UICollectionView *colletion = (UICollectionView *)self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [colletion reloadData];
        });
    }else{
        
    }
}


-(void)endRefreshByIsDownRefresh:(BOOL)downRefresh isRequestSuccess:(BOOL)isRequestSuccess total:(NSInteger)total pageSize:(NSInteger)pageSize isShowError:(BOOL)isShowError{
    
    self.mj_footer.hidden = NO;
    //下拉刷新
    if (downRefresh){
        self.totalCount = total;
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
        if (isRequestSuccess){
            self.mj_footer.hidden = NO;
            if (total==0){

                
            }else{
                if (isShowError)
                {

                }
                if (total <= pageSize * self.page){
                    [self.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.mj_footer endRefreshing];
                }
            }
        }
    }else{
        //上拉刷新
        if (isRequestSuccess){
            //重置页码
//            if (self.totalCount == total){
//                [self.mj_footer endRefreshingWithNoMoreData];
//            }else{
                self.totalCount = total;
            if (total <= pageSize * self.page){
                [self.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.mj_footer endRefreshing];
            }
//            }
        }else{
            self.page--;
            [self.mj_footer endRefreshing];
        }
    }
    if (total==0){
        self.mj_footer.hidden=YES;
    }
    
    if ([self isMemberOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableView reloadData];
        });
    }else if ([self isMemberOfClass:[UICollectionView class]]){
        UICollectionView *colletion = (UICollectionView *)self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [colletion reloadData];
        });
    }else{
        
    }
}


-(void)setPage:(NSInteger)page{
    if (page != self.page)
    {
        // 删除旧的，添加新的
        
        // 存储新的
        [self willChangeValueForKey:@"page"]; // KVO
        objc_setAssociatedObject(self,"HFRefreshPage",
                                 [NSNumber numberWithInteger:page], OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"page"]; // KVO
    }
}

-(NSInteger)page{
    NSNumber* pageNumber= objc_getAssociatedObject(self,"HFRefreshPage");
    return [pageNumber integerValue];
}

-(void)setTotalCount:(NSInteger)totalCount{
    
    if (totalCount != self.totalCount){
        // 存储新的
        [self willChangeValueForKey:@"totalCount"]; // KVO
        objc_setAssociatedObject(self,"HFRefreshTotalCount",
                                 [NSNumber numberWithInteger:totalCount], OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"totalCount"]; // KVO
    }
}

-(NSInteger)totalCount{
    NSNumber* totalCountNumber= objc_getAssociatedObject(self,"HFRefreshTotalCount");
    return [totalCountNumber integerValue];
}

@end
