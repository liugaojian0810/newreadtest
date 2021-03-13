#import "HFTodayTaskListModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFTodayTaskListModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFTodayTaskListModelElement (JSONConversion)
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

HFTodayTaskListModel *_Nullable HFTodayTaskListModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [HFTodayTaskListModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFTodayTaskListModel *_Nullable HFTodayTaskListModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFTodayTaskListModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFTodayTaskListModelToData(HFTodayTaskListModel *todayTaskListModel, NSError **error)
{
    @try {
        id json = [todayTaskListModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFTodayTaskListModelToJSON(HFTodayTaskListModel *todayTaskListModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFTodayTaskListModelToData(todayTaskListModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFTodayTaskListModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"success": @"isSuccess",
        @"errorMessage": @"errorMessage",
        @"errorCode": @"errorCode",
        @"model": @"model",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return HFTodayTaskListModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFTodayTaskListModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFTodayTaskListModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _model = map(_model, λ(id x, [HFTodayTaskListModelElement fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFTodayTaskListModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFTodayTaskListModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFTodayTaskListModel.properties) {
        id propertyName = HFTodayTaskListModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"success": _isSuccess ? @YES : @NO,
        @"HFTodayTaskListModel": map(_model, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return HFTodayTaskListModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFTodayTaskListModelToJSON(self, encoding, error);
}
@end

@implementation HFTodayTaskListModelElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"teacherId": @"teacherID",
        @"courseId": @"courseID",
        @"startDate": @"startDate",
        @"endDate": @"endDate",
        @"courceName": @"courceName",
        @"courceSystem": @"courceSystem",
        @"teacherName": @"teacherName",
        @"courseImg": @"courseImg",
        @"courseUrl": @"courseUrl",
        @"roomNo": @"roomNo",
        @"teacherPwd": @"teacherPwd",
        @"weekDetailId":@"weekDetailId"
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFTodayTaskListModelElement alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = HFTodayTaskListModelElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFTodayTaskListModelElement.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFTodayTaskListModelElement.properties) {
        id propertyName = HFTodayTaskListModelElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
