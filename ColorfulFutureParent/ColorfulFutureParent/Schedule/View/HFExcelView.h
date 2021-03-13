//
//  HFExcelView.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFIndexPath.h"
#import "HFExcelViewMode.h"

@class HFExcelView;
@class HFSchedulModel;

@protocol HFExcelViewDataSource<NSObject>
@required
//多少行
- (NSInteger)excelView:(HFExcelView *)excelView numberOfRowsInSection:(NSInteger)section;
//多少列
- (NSInteger)itemOfRow:(HFExcelView *)excelView;
@optional
- (void)excelView:(HFExcelView *)excelView label:(UILabel *)label textAtIndexPath:(HFIndexPath *)indexPath;
- (void)excelView:(HFExcelView *)excelView headView:(UILabel *)label textAtIndexPath:(HFIndexPath *)indexPath;
//分组
- (NSInteger)numberOfSectionsInExcelView:(HFExcelView *)excelView;


@end

@protocol HFExcelViewDelegate <NSObject>
@optional

//自定义每列的宽度/默认每列的宽度为80
- (NSArray *)widthForItemOnExcelView:(HFExcelView *)excelView;

@end


typedef void(^HFExcelViewOffsetBlock)(CGFloat offset, CGFloat contentSize,CGFloat scrollViewWidth);


@interface HFExcelView : UIView

@property (nonatomic,assign,readonly) HFExcelViewStyle style;
@property (nonatomic,           weak) id <HFExcelViewDelegate>delegate;
@property (nonatomic,           weak) id <HFExcelViewDataSource>dataSource;
@property (nonatomic, strong)HFSchedulModel *scheduleModel;
@property (nonatomic, copy)NSString *monthStr;
@property(nonatomic, copy)HFExcelViewOffsetBlock h_offset;//横向滚动偏移
@property(nonatomic, copy)HFExcelViewOffsetBlock v_offset;//纵向滚动偏移
//是否显示边框，宽度默认为1
@property (nonatomic,assign,getter=isShowBorder) BOOL showBorder;
/** 是否显示竖直方向的滚动条 */
@property (nonatomic,assign,getter=isShowsVerticalScrollIndicator) BOOL showsVerticalScrollIndicator;
/** 边框的颜色 */
@property (nonatomic,strong) UIColor *showBorderColor;
/** 内部通知的name */
@property (nonatomic, strong, readonly) NSString *NotificationID;

//新的便利构造方法（推荐使用该方法）
- (instancetype)initWithFrame:(CGRect)frame mode:(HFExcelViewMode *)mode;

/** 刷新列表 */
- (void)reloadData;

@end
