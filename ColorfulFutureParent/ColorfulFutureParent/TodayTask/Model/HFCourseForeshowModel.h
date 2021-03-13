//
//  HFCourseForeshowModel.h
//  ColorfulFutureParent
//
//  Created by ql on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface HFCourseForeshowModel : NSObject<YYModel>
@property (nonatomic,strong)NSString * teacherName;
@property (nonatomic,strong)NSString * teacherImg;
@property (nonatomic,strong)NSString * courseName;
@property (nonatomic,strong)NSString * teachingDate;
@property (nonatomic,strong)NSString * courseId;
@property (nonatomic,strong)NSString * courseUrl;
@property (nonatomic,strong)NSString * courseLabel;
@property (nonatomic,strong)NSString * startDate;
@property (nonatomic,strong)NSString * weekDetailId;


@property (nonatomic,strong)NSString * flag;//0.预告1.播放

@end

NS_ASSUME_NONNULL_END
