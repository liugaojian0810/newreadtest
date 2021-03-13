//
//  HFLessonDetailModel.h
//  ColorfulFutureParent
//
//  Created by 李春展 on 2020/6/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFLessonDetailModel : HFBaseModel

/**购买数量*/
@property (nonatomic, copy) NSString *buyNum;

/** 缩略图 */
@property (nonatomic, copy) NSString *goodsThumbnailUrl;

/** 缩略图 */
@property (nonatomic, copy) NSString *goodsMainPhotoUrl;

/** 商品价格 */
@property (nonatomic, copy) NSString *showPrice;

/** 课程详情*/
@property (nonatomic, copy) NSString *goodsDetailsH5;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *goodsDetails;
@end

NS_ASSUME_NONNULL_END
