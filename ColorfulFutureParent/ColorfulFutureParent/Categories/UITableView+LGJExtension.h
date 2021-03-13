//
//  UITableView+LGJExtension.h
//  WeiGe
//
//  Created by ADIQueen on 2018/8/16.
//  Copyright © 2018年 teacher of china. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HFNoContentType) {
    HFNoContentTypeNoNetwork,
    HFNoContentTypeNoContent,
    HFNoContentTypeNoOrder,
    HFNoContentTypeNone,
    HFNoContentTypeShoppingCart,
    HFNoContentTypeNotInteractive
};

@interface UITableView (LGJExtension)

/**
 默认的无数据提示 View 的点击回调
 @note 用这个 block 的时候注意在 block “内部”使用weak，不然会导致循环引用
 */
@property (nonatomic, copy) void(^noDataViewDidClickBlock)(UIView *view);
@property (nonatomic, copy) void(^noDataBtnDidClickBlock)(UIButton *btn);

/// 设置默认的提示文字
@property (nonatomic, copy) NSString *defaultNoDataText;

/// 设置默认的提示图片
@property (nonatomic, strong) UIImage *defaultNoDataImage;

/// 设置默认的操作按钮
//@property (nonatomic, strong) UIButton *defaultOperationBtn;

/// 设置默认的操作按钮提示文字
@property (nonatomic, copy) NSString *defaultOperationBtnText;


/// 自定义无数据提示View
@property (nonatomic, strong) UIView *customNoDataView;

// 是否显示
@property (nonatomic, assign) BOOL showNoDataNotice;

//暂无内容类型
@property (nonatomic, assign) HFNoContentType noContentType;


@end
