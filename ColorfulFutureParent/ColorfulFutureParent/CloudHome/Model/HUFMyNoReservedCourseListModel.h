// To parse this JSON:
//
//   NSError *error;
//   HUFMyNoReservedCourseListModel *myNoReservedCourseListModel = [HUFMyNoReservedCourseListModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HUFMyNoReservedCourseListModel;
@class HUFModel;
@class HUFList;
@class HUFTeacher;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HUFMyNoReservedCourseListModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HUFModel *> *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HUFModel : NSObject
@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSArray<HUFList *> *lists;
@end

@interface HUFList : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *courseName;
@property (nonatomic, copy)   NSString *coursePhoto;
@property (nonatomic, copy)   NSString *appointmentDate;
@property (nonatomic, copy)   NSArray<HUFTeacher *> *teachers;
@end

@interface HUFTeacher : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger courseID;
@property (nonatomic, copy)   NSString *teacherName;
@property (nonatomic, copy)   NSString *startTime;
@property (nonatomic, copy)   NSString *endTime;
@property (nonatomic, copy)   NSString *appointmentDate;
@property (nonatomic, assign) NSInteger appointmentIntervaID;
@end

NS_ASSUME_NONNULL_END
