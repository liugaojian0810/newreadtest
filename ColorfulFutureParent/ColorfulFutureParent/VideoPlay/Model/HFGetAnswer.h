// To parse this JSON:
//
//   NSError *error;
//   HFGetAnswer *getAnswer = [HFGetAnswer fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFGetAnswer;
@class HFGetAnswerModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFGetAnswer : NSObject
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy)   NSString *errorMessage;
@property (nonatomic, strong) HFGetAnswerModel *model;
@property (nonatomic, assign) BOOL isSuccess;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFGetAnswerModel : NSObject
@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, assign) BOOL isFlag;
@property (nonatomic, assign) NSInteger total;
@end

NS_ASSUME_NONNULL_END
