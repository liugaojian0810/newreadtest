// To parse this JSON:
// 成长营课程信息接口-互动题库查询
//   NSError *error;
//   HFQuestionsItnListModel *questionsItnListModel = HFQuestionsItnListModelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class HFQuestionsItnListModelElement;
@class HFList;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<HFQuestionsItnListModelElement *> HFQuestionsItnListModel;

#pragma mark - Top-level marshaling functions

HFQuestionsItnListModel *_Nullable HFQuestionsItnListModelFromData(NSData *data, NSError **error);
HFQuestionsItnListModel *_Nullable HFQuestionsItnListModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData                  *_Nullable HFQuestionsItnListModelToData(HFQuestionsItnListModel *questionsItnListModel, NSError **error);
NSString                *_Nullable HFQuestionsItnListModelToJSON(HFQuestionsItnListModel *questionsItnListModel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface HFQuestionsItnListModelElement : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, strong) NSNumber *categoryID;
@property (nonatomic, nullable, strong) NSNumber *stage;
@property (nonatomic, nullable, copy)   id types;
@property (nonatomic, nullable, copy)   id isDelete;
@property (nonatomic, nullable, copy)   id interactType;
@property (nonatomic, nullable, copy)   id answerCorrect;
@property (nonatomic, nullable, copy)   id answerError;
@property (nonatomic, nullable, copy)   NSString *creatDate;
@property (nonatomic, nullable, copy)   id creatUser;
@property (nonatomic, nullable, copy)   id coucreCategoryNameList;
@property (nonatomic, nullable, copy)   id numberOf;
@property (nonatomic, nullable, strong) NSNumber *minute;
@property (nonatomic, nullable, strong) NSNumber *second;
@property (nonatomic, nullable, strong) NSNumber *waitingTime;
@property (nonatomic, nullable, copy)   NSArray<HFList *> *list;
@end

@interface HFList : NSObject
@property (nonatomic, nullable, strong) NSNumber *identifier;
@property (nonatomic, nullable, strong) NSNumber *questionsID;
@property (nonatomic, nullable, copy)   NSString *title;
@property (nonatomic, nullable, copy)   id types;
@property (nonatomic, nullable, strong) NSNumber *isRealanswer;
@property (nonatomic, nullable, copy)   NSString *createDate;
@property (nonatomic, nullable, copy)   id createUser;
@property (nonatomic, nullable, strong) NSNumber *isDelete;
@end

NS_ASSUME_NONNULL_END
