// To parse this JSON:
//
//   NSError *error;
//   HFBabyListModel *babyListModel = [HFBabyListModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFBabyListModel;
@class HFModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFBabyListModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HFModel *> *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFModel : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *photo;
@property (nonatomic, copy)           NSString *birth;
@property (nonatomic, assign)         NSInteger sex;
@property (nonatomic, copy)           NSString *nationality;
@property (nonatomic, copy)           NSString *nation;
@property (nonatomic, nullable, copy) id isAllergy;
@property (nonatomic, assign)         NSInteger province;
@property (nonatomic, assign)         NSInteger city;
@property (nonatomic, assign)         NSInteger county;
@property (nonatomic, copy)           NSString *address;
@property (nonatomic, copy)           NSString *registeredResidence;
@property (nonatomic, copy)           NSString *kgName;
@property (nonatomic, assign)         NSInteger isDeleted;
@property (nonatomic, nullable, copy) id createUser;
@property (nonatomic, nullable, copy) id updateUser;
@property (nonatomic, copy)           NSString *createDate;
@property (nonatomic, copy)           NSString *updateDate;
@property (nonatomic, assign)         NSInteger status;
@property (nonatomic, assign)         NSInteger kgId;
@property (nonatomic, nullable, copy) id remarks;
@end

NS_ASSUME_NONNULL_END
