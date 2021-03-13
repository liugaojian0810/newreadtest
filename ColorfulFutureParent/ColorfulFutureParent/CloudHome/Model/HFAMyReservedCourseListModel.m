#import "HFAMyReservedCourseListModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFAMyReservedCourseListModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFAModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFAList (JSONConversion)
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

HFAMyReservedCourseListModel *_Nullable HFAMyReservedCourseListModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [HFAMyReservedCourseListModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFAMyReservedCourseListModel *_Nullable HFAMyReservedCourseListModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFAMyReservedCourseListModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFAMyReservedCourseListModelToData(HFAMyReservedCourseListModel *myReservedCourseListModel, NSError **error)
{
    @try {
        id json = [myReservedCourseListModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFAMyReservedCourseListModelToJSON(HFAMyReservedCourseListModel *myReservedCourseListModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFAMyReservedCourseListModelToData(myReservedCourseListModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFAMyReservedCourseListModel
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
    return HFAMyReservedCourseListModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFAMyReservedCourseListModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFAMyReservedCourseListModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _model = map(_model, λ(id x, [HFAModel fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFAMyReservedCourseListModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFAMyReservedCourseListModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFAMyReservedCourseListModel.properties) {
        id propertyName = HFAMyReservedCourseListModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"success": _isSuccess ? @YES : @NO,
        @"model": map(_model, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return HFAMyReservedCourseListModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFAMyReservedCourseListModelToJSON(self, encoding, error);
}
@end

@implementation HFAModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"appointmentDate": @"appointmentDate",
        @"lists": @"lists",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFAModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _lists = map(_lists, λ(id x, [HFAList fromJSONDictionary:x]));
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFAModel.properties.allValues] mutableCopy];

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"lists": map(_lists, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation HFAList
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"courseName": @"courseName",
        @"coursePhoto": @"coursePhoto",
        @"courseUrl": @"courseURL",
        @"teacherId": @"teacherID",
        @"teacherName": @"teacherName",
        @"courseType": @"courseType",
        @"startTime": @"startTime",
        @"endTime": @"endTime",
        @"appointmentDate": @"appointmentDate",
        @"number": @"number",
        @"numberMax": @"numberMax",
        @"hfAppointmentChildenId": @"hfAppointmentChildenId",
        @"roomNo": @"roomNo",

    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFAList alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = HFAList.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFAList.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFAList.properties) {
        id propertyName = HFAList.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
