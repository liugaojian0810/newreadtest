#import "HFCouldHomedidDotModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFCouldHomedidDotModelElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFCouldHomedidDotModelList (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFTeacher (JSONConversion)
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

HFCouldHomedidDotModel *_Nullable HFCouldHomedidDotModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : map(json, λ(id x, [HFCouldHomedidDotModelElement fromJSONDictionary:x]));
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFCouldHomedidDotModel *_Nullable HFCouldHomedidDotModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFCouldHomedidDotModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFCouldHomedidDotModelToData(HFCouldHomedidDotModel *couldHomedidDotModel, NSError **error)
{
    @try {
        id json = map(couldHomedidDotModel, λ(id x, [x JSONDictionary]));
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFCouldHomedidDotModelToJSON(HFCouldHomedidDotModel *couldHomedidDotModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFCouldHomedidDotModelToData(couldHomedidDotModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFCouldHomedidDotModelElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"appointmentDate": @"appointmentDate",
        @"CouldHomedidDotModelLists": @"couldHomedidDotModelLists",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFCouldHomedidDotModelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _couldHomedidDotModelLists = map(_couldHomedidDotModelLists, λ(id x, [HFCouldHomedidDotModelList fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFCouldHomedidDotModelElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFCouldHomedidDotModelElement.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFCouldHomedidDotModelElement.properties) {
        id propertyName = HFCouldHomedidDotModelElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"CouldHomedidDotModelLists": map(_couldHomedidDotModelLists, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation HFCouldHomedidDotModelList
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"courseName": @"courseName",
        @"appointmentDate": @"appointmentDate",
        @"coursePhoto": @"coursePhoto",
        @"teachers": @"teachers",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFCouldHomedidDotModelList alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _teachers = map(_teachers, λ(id x, [HFTeacher fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFCouldHomedidDotModelList.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFCouldHomedidDotModelList.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFCouldHomedidDotModelList.properties) {
        id propertyName = HFCouldHomedidDotModelList.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"teachers": map(_teachers, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation HFTeacher
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"teacherName": @"teacherName",
        @"startTime": @"startTime",
        @"endTime": @"endTime",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFTeacher alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = HFTeacher.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFTeacher.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFTeacher.properties) {
        id propertyName = HFTeacher.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
