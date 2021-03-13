//
//  HFBaseModel.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBaseModel : NSObject<NSCoding>

@property(nonatomic,copy)NSString* code;
@property(nonatomic,copy)NSString* name;

@property(nonatomic,copy)NSString* errorMessage;
@property(nonatomic,copy)NSString* errorCode;
@property(nonatomic,copy)NSString* success;

@property(nonatomic,strong)id model;

+ (id)create;
+ (instancetype)loadFromFile:(NSString *)path;
- (BOOL)saveToFile:(NSString *)path;

//自定义一个初始化方法
- (id)initWithContentsOfDic:(NSDictionary *)dic;

//创建映射关系
- (NSDictionary *)keyToAtt:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
