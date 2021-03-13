// To parse this JSON:
//云家园互动营-未预约模型
//   NSError *error;
//   HFCouldHomedidDotModel *couldHomedidDotModel = HFCouldHomedidDotModelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class HFCouldHomedidDotModelElement;
@class HFCouldHomedidDotModelList;
@class HFTeacher;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<HFCouldHomedidDotModelElement *> HFCouldHomedidDotModel;

#pragma mark - Top-level marshaling functions

HFCouldHomedidDotModel *_Nullable HFCouldHomedidDotModelFromData(NSData *data, NSError **error);
HFCouldHomedidDotModel *_Nullable HFCouldHomedidDotModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData                 *_Nullable HFCouldHomedidDotModelToData(HFCouldHomedidDotModel *couldHomedidDotModel, NSError **error);
NSString               *_Nullable HFCouldHomedidDotModelToJSON(HFCouldHomedidDotModel *couldHomedidDotModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface HFCouldHomedidDotModelElement : NSObject
@property (nonatomic, copy) NSString *appointmentDate;
@property (nonatomic, copy) NSArray<HFCouldHomedidDotModelList *> *couldHomedidDotModelLists;
@end

@interface HFCouldHomedidDotModelList : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *courseName;
@property (nonatomic, copy)   NSString *appointmentDate;
@property (nonatomic, copy)   NSString *coursePhoto;
@property (nonatomic, copy)   NSArray<HFTeacher *> *teachers;
@end

@interface HFTeacher : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *teacherName;
@property (nonatomic, copy)   NSString *startTime;
@property (nonatomic, copy)   NSString *endTime;
@end

NS_ASSUME_NONNULL_END
