//
//  HFExcelViewMode.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, HFExcelViewStyle) {
    HFExcelViewStyleDefalut = 0,//整体表格滑动，上下、左右均可滑动（除第一列不能左右滑动以及头部View不能上下滑动外）
    HFExcelViewStylePlain,//整体表格滑动，上下、左右均可滑动（除第一行不能上下滑动以及头部View不能上下滑动外）
    HFExcelViewStyleheadPlain,//整体表格(包括头部View)滑动，上下、左右均可滑动（除第一列不能左右滑动外）
    HFExcelViewStyleheadScrollView,//整体表格(包括头部View)滑动，上下、左右均可滑动
};
@interface HFExcelViewMode : NSObject
//模式
@property (nonatomic,assign) HFExcelViewStyle style;
//默认头部的高度
@property (nonatomic,assign) float defalutHeight;
//头部view的text集合
@property (nonatomic,  copy) NSArray *headTexts;

@property(nonatomic,assign)BOOL isParentSchedule;

@end
