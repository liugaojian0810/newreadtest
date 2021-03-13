// To parse this JSON:
//
//   NSError *error;
//   HFAdvertisingModel *advertisingModel = [HFAdvertisingModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFAdvertisingModel;
@class HFAdvertising;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFAdvertisingModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HFAdvertising *> *advertising;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFAdvertising : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *imageURL;
@property (nonatomic, copy)           NSString *imageTitle;
@property (nonatomic, nullable, copy) id imageDesc;
@property (nonatomic, nullable, copy) id imageSort;
@property (nonatomic, assign)         NSInteger isParentDisplay;
@property (nonatomic, assign)         NSInteger isTeacherDisplay;
@property (nonatomic, assign)         NSInteger isGartenDisplay;
@property (nonatomic, assign)         NSInteger isDeleted;
@property (nonatomic, assign)         NSInteger isEnable;
@property (nonatomic, nullable, copy) id createUser;
@property (nonatomic, nullable, copy) id updateUser;
@property (nonatomic, copy)           NSString *createDate;
@property (nonatomic, copy)           NSString *updateDate;
@property (nonatomic, nullable, copy) id linkType;
@property (nonatomic, copy)           NSString *linkURL;
@end

NS_ASSUME_NONNULL_END
