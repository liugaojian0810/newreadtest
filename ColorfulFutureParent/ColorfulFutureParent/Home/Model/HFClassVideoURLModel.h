// To parse this JSON:
//
//   NSError *error;//关卡预告获取视频地址
//   HFClassVideoURLModel *classVideoURLModel = [HFClassVideoURLModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFClassVideoURLModel;
@class HFData;
@class HFVideoURL;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFClassVideoURLModel : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) HFData *data;
@property (nonatomic, copy)   NSString *message;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFData : NSObject
@property (nonatomic, copy)   NSString *autoCode;
@property (nonatomic, copy)   NSString *customCode;
@property (nonatomic, assign) NSInteger encrypt;
@property (nonatomic, copy)   NSString *htmlCode;
@property (nonatomic, copy)   NSString *swfCode;
@property (nonatomic, copy)   NSString *tryWatchAutoCode;
@property (nonatomic, copy)   NSArray *tryWatchVideoURL;
@property (nonatomic, copy)   NSString *videoID;
@property (nonatomic, copy)   NSArray<HFVideoURL *> *videoURL;
@end

@interface HFVideoURL : NSObject
@property (nonatomic, copy) NSString *fluentURL;
@property (nonatomic, copy) NSString *hdPullURL;
@property (nonatomic, copy) NSString *highURL;
@property (nonatomic, copy) NSString *originURL;
@property (nonatomic, copy) NSString *sdURL;
@property (nonatomic, copy) NSString *urlType;
@end

NS_ASSUME_NONNULL_END
