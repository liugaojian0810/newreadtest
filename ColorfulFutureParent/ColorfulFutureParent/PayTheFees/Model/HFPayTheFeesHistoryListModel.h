// To parse this JSON:
//
//   NSError *error;
//   HFPayTheFeesHistoryListModel *payTheFeesHistoryListModel = [HFPayTheFeesHistoryListModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFPayTheFeesHistoryListModel;
@class HFPayTheFeesHistoryModel;
@class HFPaymentInfoVOList;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFPayTheFeesHistoryListModel : NSObject
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy)   NSString *errorMessage;
@property (nonatomic, copy)   NSArray<HFPayTheFeesHistoryModel *> *model;
@property (nonatomic, assign) BOOL isSuccess;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFPayTheFeesHistoryModel : NSObject
@property (nonatomic, assign) NSInteger couponAmount;
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, assign) NSInteger payAmount;
@property (nonatomic, copy)   NSString *paymentCycle;
@property (nonatomic, copy)   NSArray<HFPaymentInfoVOList *> *paymentInfoVOList;
@property (nonatomic, copy)   NSString *paymentProjectName;
@property (nonatomic, copy)   NSString *paymentTime;
@property (nonatomic, assign) NSInteger paymentType;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isSelect;
@end

@interface HFPaymentInfoVOList : NSObject
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, copy)   NSString *paymentCycle;
@property (nonatomic, copy)   NSString *paymentProjectName;
@property (nonatomic, assign) NSInteger paymentType;
@end

NS_ASSUME_NONNULL_END
