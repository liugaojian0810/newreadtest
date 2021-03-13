//
//  HFUpdateModel.h
//  ColorfulFutureTeacher_iOS
//
//  Created by 刘高见 on 2020/5/24.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFUpdateModel : HFBaseModel


@property(nonatomic, copy)NSString *updateDate;//更新时间
@property(nonatomic, copy)NSString *updateUser;//修改人
@property(nonatomic, copy)NSString *createDate;//创建时间
@property(nonatomic, copy)NSString *createUser;//创建人
@property(nonatomic, copy)NSString *isDeleted;//是否删除(0否1是)
@property(nonatomic, copy)NSString *isEnable;//是否启用(0否1是)
@property(nonatomic, copy)NSString *isUpdate;//是否强制更新
@property(nonatomic, copy)NSString *productPlatform;//产品平台(1家长端APP2园长端APP3教师pad端)
@property(nonatomic, copy)NSString *terminalPlatform;//终端平台(1Android 2ios)
@property(nonatomic, copy)NSString *versionRemark;//版本说明
@property(nonatomic, copy)NSString *attachSize;//附件大小
@property(nonatomic, copy)NSString *attach;//附件
@property(nonatomic, copy)NSString *versionSn;//版本序号
@property(nonatomic, copy)NSString *versionCode;//版本号
@property(nonatomic, copy)NSString *ID;//主键
@property(nonatomic, copy)NSString *updateUrl;//版本更新连接



@end

NS_ASSUME_NONNULL_END
