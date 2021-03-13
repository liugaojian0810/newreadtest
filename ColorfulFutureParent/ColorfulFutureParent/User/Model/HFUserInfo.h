//
//  HFUserInfo.h
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/25.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HFBabyInfo;
NS_ASSUME_NONNULL_BEGIN

@interface HFUserInfo : NSObject

@property (nonatomic, copy)  NSString *userId;
@property (nonatomic, copy)   NSString *token;
@property (nonatomic, copy)   NSString *username;
@property (nonatomic, copy)  NSString *babyId;
@property (nonatomic, copy)   NSString *phone;
@property (nonatomic, copy)   NSString *name;

/** 会员级别 ：1钻石 2铂金 3金卡 */
@property (nonatomic, copy)  NSString *userLevel;
/** 宝宝信息 */
@property (nonatomic, strong)  HFBabyInfo *babyInfo;
@end

@interface HFBabyInfo : NSObject

@property (nonatomic, copy)   NSString *babyID;
/** 幼儿园ID*/
@property (nonatomic, copy)   NSString *kgId;
/** 幼儿园名称*/
@property (nonatomic, copy)   NSString *kgName;

@property (nonatomic, copy)   NSString *babyName;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy)   NSString *babyPhoto;
@property (nonatomic, copy)  NSString *familyDocId;

@end
NS_ASSUME_NONNULL_END
