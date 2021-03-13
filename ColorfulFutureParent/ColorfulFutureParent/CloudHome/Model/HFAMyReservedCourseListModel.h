// To parse this JSON:
//
//   NSError *error;
//   HFAMyReservedCourseListModel *myReservedCourseListModel = [HFAMyReservedCourseListModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFAMyReservedCourseListModel;
@class HFAModel;
@class HFAList;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFAMyReservedCourseListModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HFAModel *> *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFAModel : NSObject
@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSArray<HFAList *> *lists;
@end

@interface HFAList : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *courseName;
@property (nonatomic, copy)           NSString *coursePhoto;
@property (nonatomic, nullable, copy) id courseURL;
@property (nonatomic, assign)         NSInteger teacherID;
@property (nonatomic, copy)           NSString *teacherName;
@property (nonatomic, nullable, copy) id courseType;
@property (nonatomic, copy)           NSString *startTime;
@property (nonatomic, copy)           NSString *endTime;
@property (nonatomic, copy)           NSString *appointmentDate;
@property (nonatomic, assign)         NSInteger number;
@property (nonatomic, assign)         NSInteger numberMax;
@property (nonatomic, assign)         NSInteger hfAppointmentChildenId;
@property (nonatomic, copy)           NSString *roomNo;

@end

NS_ASSUME_NONNULL_END
