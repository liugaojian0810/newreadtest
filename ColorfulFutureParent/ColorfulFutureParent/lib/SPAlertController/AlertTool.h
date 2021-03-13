//
//  AlertTool.h
//  TeacherEdu2016
//
//  Created by ADIQueen on 16/12/7.
//  Copyright © 2016年 teacher of china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface AlertTool : NSObject

@property(nonatomic, strong)UIWindow *testWindow;


HFSingletonH(AlertTool);

/*
 *
 计算字符串宽度
 */
- (CGRect)getStringRect:(NSString*)aString withFont :(CGFloat)font;

/*过滤html标签*/
+ (NSString *)flattenHTML:(NSString *)html ;

#pragma mark-中间显示
/**
 *  中间显示
 *
 *  @param text 内容
 */
+ (void)showCenterWithText:(NSString *)text;
/**
 *  中间显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;

#pragma mark-上方显示
/**
 *  上方显示
 *
 *  @param text 内容
 */
+ (void)showTopWithText:(NSString *)text;
/**
 *  上方显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;
/**
 *  上方显示+自定义距顶端距离
 *
 *  @param text      内容
 *  @param topOffset 到顶端距离
 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;
/**
 *  上方显示+自定义距顶端距离+自定义停留时间
 *
 *  @param text      内容
 *  @param topOffset 到顶端距离
 *  @param duration  停留时间
 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

#pragma mark-下方显示
/**
 *  下方显示
 *
 *  @param text 内容
 */
+ (void)showBottomWithText:(NSString *)text;
/**
 *  下方显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration;
/**
 *  下方显示+自定义距底端距离
 *
 *  @param text         内容
 *  @param bottomOffset 距底端距离
 */
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;
/**
 *  下方显示+自定义距底端距离+自定义停留时间
 *
 *  @param text         内容
 *  @param bottomOffset 距底端距离
 *  @param duration     停留时间
 */
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;



//====================使用实例===============
/**
 *  中间显示
 */
//[XHToast showCenterWithText:text];

/**
 *  中间显示+自定义停留时间
 */
//[XHToast showCenterWithText:text duration:3.0];

/**
 *  顶端显示
 */
//[XHToast showTopWithText:text];

/**
 *  顶端显示+自定义停留时间
 */
//[XHToast showTopWithText:text duration:3.0];

/**
 *  顶端显示+自定义距顶端距离
 */
//[XHToast showTopWithText:text topOffset:120.0];

/**
 *  顶端显示+自定义距顶端距离+自定义停留时间
 */
//[XHToast showTopWithText:text topOffset:120.0 duration:3.0];

/**
 *  底部显示
 */
//[XHToast showBottomWithText:text];

/**
 *  底部显示+自定义停留时间
 */
//[XHToast showBottomWithText:text duration:3.0];

/**
 *  底部显示+自定义距顶端距离
 */
//[XHToast showBottomWithText:text bottomOffset:120.0];

/**
 *  底部显示+自定义距顶端距离+自定义停留时间
 */
//[XHToast showBottomWithText:text bottomOffset:120.0 duration:3.0];

//==========================================

/**
 *  提示
 */
- (void)initMBProgressHUD:(NSString *)str inView:(UIView *)view;


//-------------------------------类型修正------------------------------
/** 修复dic arr 中为Null 的情况*/
+ (void)amendDicValueIsNSString:(NSMutableDictionary *)dic;
+ (void)amendArrValueIsNSString:(NSMutableArray *)arr;
//-------------------------------类型检测------------------------------
/** 检测dic中类型是否为NSString*/
+ (void)checkDicValueIsNSString:(NSDictionary *)dic;
/** 检测arr中类型是否为NSString*/
+ (void)checkArrValueIsNSString:(NSArray *)arr;

@end
