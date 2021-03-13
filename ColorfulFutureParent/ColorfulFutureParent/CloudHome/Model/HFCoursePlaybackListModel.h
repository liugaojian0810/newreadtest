// To parse this JSON:
//家长端-成长营课程回放
//   NSError *error;
//   HFCoursePlaybackListModel *coursePlaybackListModel = HFCoursePlaybackListModelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class HFCoursePlaybackListModelElement;
@class HFList;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<HFCoursePlaybackListModelElement *> HFCoursePlaybackListModel;

#pragma mark - Top-level marshaling functions

HFCoursePlaybackListModel *_Nullable HFCoursePlaybackListModelFromData(NSData *data, NSError **error);
HFCoursePlaybackListModel *_Nullable HFCoursePlaybackListModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData                    *_Nullable HFCoursePlaybackListModelToData(HFCoursePlaybackListModel *coursePlaybackListModel, NSError **error);
NSString                  *_Nullable HFCoursePlaybackListModelToJSON(HFCoursePlaybackListModel *coursePlaybackListModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface HFCoursePlaybackListModelElement : NSObject
@property (nonatomic, nullable, copy) NSString *appointmentDate;
@property (nonatomic, nullable, copy) NSArray<HFList *> *lists;
@end

@interface HFList : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *courseName;
@property (nonatomic, nullable, copy)   NSString *coursePhoto;
@property (nonatomic, nullable, strong) NSNumber *teacherID;
@property (nonatomic, nullable, copy)   NSString *teacherName;
@property (nonatomic, nullable, copy)   NSString *startTime;
@property (nonatomic, nullable, copy)   NSString *endTime;
@property (nonatomic, nullable, copy)   NSString *appointmentDate;
@property (nonatomic, nullable, strong) NSNumber *childCourseID;
@end

NS_ASSUME_NONNULL_END
