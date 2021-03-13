// To parse this JSON:
//
//   NSError *error;
//   HFBabyDataModel *babyDataModel = [HFBabyDataModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFBabyDataModel;
@class HFBabyModel;
@class HFParentsInfoVO;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFBabyDataModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, strong)         HFBabyModel *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

//@interface HFBabyModel : NSObject
//@property (nonatomic, assign) NSInteger identifier;
//@property (nonatomic, copy)   NSString *name;
//@property (nonatomic, copy)   NSString *photo;
//@property (nonatomic, copy)   NSString *birth;
//@property (nonatomic, assign) NSInteger sex;
//@property (nonatomic, assign) NSInteger classID;
//@property (nonatomic, copy)   NSString *className;
//@property (nonatomic, copy)   NSArray<HFParentsInfoVO *> *parentsInfoVOS;
//@property (nonatomic, assign) NSInteger kindergartenID;
//@property (nonatomic, copy)   NSString *kindergartenName;
//@end

@interface HFParentsInfoVO : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger parentsType;
@property (nonatomic, copy)   NSString *phone;
@end

NS_ASSUME_NONNULL_END
