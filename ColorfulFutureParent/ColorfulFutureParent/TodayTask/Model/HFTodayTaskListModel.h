// To parse this JSON:
//
//   NSError *error;
//   HFTodayTaskListModel *todayTaskListModel = [HFTodayTaskListModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFTodayTaskListModel;
@class HFTodayTaskListModelElement;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFTodayTaskListModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HFTodayTaskListModelElement *> *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFTodayTaskListModelElement : NSObject
@property (nonatomic, assign) NSInteger teacherID;
@property (nonatomic, assign) NSInteger courseID;
@property (nonatomic, copy)           NSString *startDate;
@property (nonatomic, copy)           NSString *endDate;
@property (nonatomic, copy)           NSString *courceName;
@property (nonatomic, copy)           NSString *courceSystem;
@property (nonatomic, copy)           NSString *teacherName;
@property (nonatomic, copy)           NSString *courseImg;
@property (nonatomic, copy)           NSString *courseUrl;
@property (nonatomic, copy)           NSString *roomNo;
@property (nonatomic, copy)           NSString *teacherPwd;
@property (nonatomic, assign) NSInteger weekDetailId;
@property (nonatomic, copy)           NSString *name;


@end

NS_ASSUME_NONNULL_END
