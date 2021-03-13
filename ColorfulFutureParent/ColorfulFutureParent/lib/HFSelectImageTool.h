//
//  HFSelectImageTool.h
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHPhotoLibrary.h>
NS_ASSUME_NONNULL_BEGIN

@interface HFSelectImageTool : NSObject

typedef void (^SelectSinglePhotoBlock)(UIImage *image);
@property (nonatomic, strong) UIViewController * fromController;

@property (nonatomic, copy) SelectSinglePhotoBlock selectSignlePhoto;
// 从系统选择单一照片
- (void)selectSinglePhotoFromController:(UIViewController *)currentController complete:(SelectSinglePhotoBlock)selectSinglePhotoBlock;

@end

NS_ASSUME_NONNULL_END
