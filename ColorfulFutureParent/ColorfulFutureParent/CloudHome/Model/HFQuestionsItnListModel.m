#import "HFQuestionsItnListModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFQuestionsItnListModelElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFList (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

HFQuestionsItnListModel *_Nullable HFQuestionsItnListModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : map(json, λ(id x, [HFQuestionsItnListModelElement fromJSONDictionary:x]));
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFQuestionsItnListModel *_Nullable HFQuestionsItnListModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFQuestionsItnListModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFQuestionsItnListModelToData(HFQuestionsItnListModel *questionsItnListModel, NSError **error)
{
    @try {
        id json = map(questionsItnListModel, λ(id x, [x JSONDictionary]));
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFQuestionsItnListModelToJSON(HFQuestionsItnListModel *questionsItnListModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFQuestionsItnListModelToData(questionsItnListModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFQuestionsItnListModelElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"categoryId": @"categoryID",
        @"stage": @"stage",
        @"types": @"types",
        @"isDelete": @"isDelete",
        @"interactType": @"interactType",
        @"answerCorrect": @"answerCorrect",
        @"answerError": @"answerError",
        @"creatDate": @"creatDate",
        @"creatUser": @"creatUser",
        @"coucreCategoryNameList": @"coucreCategoryNameList",
        @"numberOf": @"numberOf",
        @"minute": @"minute",
        @"second": @"second",
        @"waitingTime": @"waitingTime",
        @"list": @"list",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFQuestionsItnListModelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _list = map(_list, λ(id x, [HFList fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFQuestionsItnListModelElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFQuestionsItnListModelElement.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFQuestionsItnListModelElement.properties) {
        id propertyName = HFQuestionsItnListModelElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"list": NSNullify(map(_list, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation HFList
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"questionsId": @"questionsID",
        @"title": @"title",
        @"types": @"types",
        @"isRealanswer": @"isRealanswer",
        @"createDate": @"createDate",
        @"createUser": @"createUser",
        @"isDelete": @"isDelete",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFList alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFList.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFList.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFList.properties) {
        id propertyName = HFList.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
