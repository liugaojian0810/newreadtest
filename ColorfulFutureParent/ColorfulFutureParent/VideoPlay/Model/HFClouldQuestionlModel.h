// To parse this JSON:
//
//   NSError *error;
//   HFClouldQuestionlModel *clouldQuestionlModel = [HFClouldQuestionlModel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class HFClouldQuestionlModel;
@class HFRequestionList;
@class HFQequestModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HFClouldQuestionlModel : NSObject
@property (nonatomic, assign)         BOOL isSuccess;
@property (nonatomic, nullable, copy) id errorMessage;
@property (nonatomic, assign)         NSInteger errorCode;
@property (nonatomic, copy)           NSArray<HFRequestionList *> *model;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface HFRequestionList : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, assign)         NSInteger categoryID;
@property (nonatomic, assign)         NSInteger stage;
@property (nonatomic, nullable, copy) id types;
@property (nonatomic, nullable, copy) id isDelete;
@property (nonatomic, assign)         NSInteger interactType;
@property (nonatomic, nullable, copy) id answerCorrect;
@property (nonatomic, nullable, copy) id answerError;
@property (nonatomic, copy)           NSString *creatDate;
@property (nonatomic, assign)         NSInteger creatUser;
@property (nonatomic, nullable, copy) id coucreCategoryNameList;
@property (nonatomic, assign)         NSInteger rowNo;
@property (nonatomic, nullable, copy) id numberOf;
@property (nonatomic, nullable, copy) id dualDate;
@property (nonatomic, assign)         NSInteger waitingTime;
@property (nonatomic, nullable, copy) id minute;
@property (nonatomic, nullable, copy) id second;
@property (nonatomic, copy)           NSArray<HFQequestModel *> *list;
@end

@interface HFQequestModel : NSObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         NSInteger questionsID;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, assign)         NSInteger types;
@property (nonatomic, assign)         NSInteger isRealanswer;
@property (nonatomic, copy)           NSString *createDate;
@property (nonatomic, nullable, copy) id createUser;
@property (nonatomic, assign)         NSInteger isDelete;
@end

NS_ASSUME_NONNULL_END
