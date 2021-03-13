// To parse this JSON:
//
//   NSError *error;
//   HUIClassPlayBackModel *classPlayBackModel = [HUIClassPlayBackModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HUIClassPlayBackModel;
@class HUIModel;
@class HUIList;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HUIClassPlayBackModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HUIModel *> *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HUIModel : NSObject
@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSArray<HUIList *> *lists;
@end

@interface HUIList : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *courseName;
@property (nonatomic, copy)           NSString *coursePhoto;
@property (nonatomic, copy)           NSString *courseURL;
@property (nonatomic, copy)           NSString *teacherName;
@property (nonatomic, copy)           NSString *typeName;
@property (nonatomic, nullable, copy) id intervaID;
@property (nonatomic, copy)           NSString *startTime;
@property (nonatomic, copy)           NSString *endTime;
@property (nonatomic, copy)           NSString *appointmentDate;
@property (nonatomic, nullable, copy) id number;
@property (nonatomic, nullable, copy) id numberMax;
@property (nonatomic, nullable, copy) id status;
@property (nonatomic, assign)           NSInteger weekDetailId;
@end

NS_ASSUME_NONNULL_END
