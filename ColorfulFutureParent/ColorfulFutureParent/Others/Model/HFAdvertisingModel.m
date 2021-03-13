#import "HFAdvertisingModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFAdvertisingModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFAdvertising (JSONConversion)
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

HFAdvertisingModel *_Nullable HFAdvertisingModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [HFAdvertisingModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFAdvertisingModel *_Nullable HFAdvertisingModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFAdvertisingModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFAdvertisingModelToData(HFAdvertisingModel *advertisingModel, NSError **error)
{
    @try {
        id json = [advertisingModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFAdvertisingModelToJSON(HFAdvertisingModel *advertisingModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFAdvertisingModelToData(advertisingModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFAdvertisingModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"success": @"isSuccess",
        @"errorMessage": @"errorMessage",
        @"errorCode": @"errorCode",
        @"advertising": @"advertising",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return HFAdvertisingModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFAdvertisingModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFAdvertisingModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _advertising = map(_advertising, λ(id x, [HFAdvertising fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFAdvertisingModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFAdvertisingModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFAdvertisingModel.properties) {
        id propertyName = HFAdvertisingModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"success": _isSuccess ? @YES : @NO,
        @"advertising": map(_advertising, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return HFAdvertisingModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFAdvertisingModelToJSON(self, encoding, error);
}
@end

@implementation HFAdvertising
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"imageUrl": @"imageURL",
        @"imageTitle": @"imageTitle",
        @"imageDesc": @"imageDesc",
        @"imageSort": @"imageSort",
        @"isParentDisplay": @"isParentDisplay",
        @"isTeacherDisplay": @"isTeacherDisplay",
        @"isGartenDisplay": @"isGartenDisplay",
        @"isDeleted": @"isDeleted",
        @"isEnable": @"isEnable",
        @"createUser": @"createUser",
        @"updateUser": @"updateUser",
        @"createDate": @"createDate",
        @"updateDate": @"updateDate",
        @"linkType": @"linkType",
        @"linkUrl": @"linkURL",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFAdvertising alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = HFAdvertising.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFAdvertising.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFAdvertising.properties) {
        id propertyName = HFAdvertising.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
