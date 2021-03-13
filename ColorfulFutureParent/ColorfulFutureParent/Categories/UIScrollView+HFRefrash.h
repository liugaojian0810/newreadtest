//
//  UIScrollView+HFRefrash.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HFRefreshRefreshingBlock)(NSInteger page);

typedef NS_ENUM(NSInteger,RefrashError){
    RefrashErrorNoContent=0,//无内容
    RefrashErrorNoNetwork,//无网络
    RefrashErrorFail//加载失败
};

@interface UIScrollView (HFRefrash)

@property(nonatomic,assign)NSInteger page;//当前页码

@property(nonatomic,assign,readonly)NSInteger totalCount;//总数据

//@property(nonatomic,strong)UILabel *noDataLabel;//暂无更多数据

/**
 @brief 上拉刷新
 
 @param refreshing <DarrenRefreshRefreshingBlock>回调
 
 */
-(void)footerRefreshingBlock:(HFRefreshRefreshingBlock)refreshing;

/**
 @brief 下拉刷新
 
 @param refreshing <DarrenRefreshRefreshingBlock>回调
 
 */
-(void)headerRefreshingBlock:(HFRefreshRefreshingBlock)refreshing;


/**
 @brief 结束刷新
 *
 @param downRefresh 是下拉刷新吗？ YES为下拉刷新，NO为上拉刷新
 *
 @param isRequestSuccess 是否请求成功
 *
 @param total 数据总个数
 *
 @param pageSize 页码默认15，可自己设置
 *
 @param isShowError 是否显示error
 */
-(void)endRefreshByIsDownRefresh:(BOOL)downRefresh isRequestSuccess:(BOOL)isRequestSuccess total:(NSInteger)total pageSize:(NSInteger)pageSize isShowError:(BOOL)isShowError;

/*
 可以自定义页码数量
 如果不给出页码数量，默认是每页15条
 */
-(void)endRefreshByIsDownRefresh:(BOOL)downRefresh isRequestSuccess:(BOOL)isRequestSuccess total:(NSInteger)total pageSize:(NSInteger)pageSize;

-(void)endRefreshByIsDownRefresh:(BOOL)downRefresh isRequestSuccess:(BOOL)isRequestSuccess total:(NSInteger)total;

/*
 刷新 参数：downRefresh 是不是下拉  success请求成功与否  total：服务端给出的记录总条数  count：当前已经加载的记录条数
*/
-(void)hf_endRefreshIsDown:(BOOL)downRefresh isRequestSuccess:(BOOL)success total:(NSInteger)total count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
