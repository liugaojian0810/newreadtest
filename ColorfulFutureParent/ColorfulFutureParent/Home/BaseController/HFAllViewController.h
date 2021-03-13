//
//  HFLandscapeViewController.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^landscapeBackBlock)(void);
typedef void(^landscaperightBTBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface HFAllViewController : UIViewController

@property (nonatomic, strong)NSString *titleString;

@property (nonatomic,assign)BOOL isback;

@property (nonatomic, copy) landscapeBackBlock backBlock;

@property (nonatomic, copy)landscaperightBTBlock rightBTBlock;

/// 设置右侧按钮
/// @param sender 汉字名字
/// @param image 是否是图片
/// @param string 图片名字

-(void)initRightBT:(NSString *)sender withisImage:(BOOL)image withImageName:(NSString *)string;



/// 更新返回按钮的图片
/// @param imgName 图片名称
-(void)updateLeftBtnImgWithName:(NSString *)imgName;

@end

NS_ASSUME_NONNULL_END
