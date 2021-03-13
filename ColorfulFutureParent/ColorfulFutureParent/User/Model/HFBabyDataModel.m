#import "HFBabyDataModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFBabyDataModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

//@interface HFBabyModel (JSONConversion)
//+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
//- (NSDictionary *)JSONDictionary;
//@end

@interface HFParentsInfoVO (JSONConversion)
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

HFBabyDataModel *_Nullable HFBabyDataModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [HFBabyDataModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFBabyDataModel *_Nullable HFBabyDataModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFBabyDataModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFBabyDataModelToData(HFBabyDataModel *babyDataModel, NSError **error)
{
    @try {
        id json = [babyDataModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFBabyDataModelToJSON(HFBabyDataModel *babyDataModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFBabyDataModelToData(babyDataModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFBabyDataModel
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
    return HFBabyDataModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFBabyDataModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFBabyDataModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
//        _model = [HFBabyModel fromJSONDictionary:(id)_model];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFBabyDataModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFBabyDataModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFBabyDataModel.properties) {
        id propertyName = HFBabyDataModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"success": _isSuccess ? @YES : @NO,
//        @"model": [_model JSONDictionary],
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return HFBabyDataModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFBabyDataModelToJSON(self, encoding, error);
}
@end

//@implementation HFBabyModel
//+ (NSDictionary<NSString *, NSString *> *)properties
//{
//    static NSDictionary<NSString *, NSString *> *properties;
//    return properties = properties ? properties : @{
//        @"id": @"identifier",
//        @"name": @"name",
//        @"photo": @"photo",
//        @"birth": @"birth",
//        @"sex": @"sex",
//        @"classId": @"classID",
//        @"className": @"className",
//        @"parentsInfoVOS": @"parentsInfoVOS",
//        @"kindergartenId": @"kindergartenID",
//        @"kindergartenName": @"kindergartenName",
//    };
//}
//
//+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
//{
//    return dict ? [[HFBabyModel alloc] initWithJSONDictionary:dict] : nil;
//}
//
//- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//        _parentsInfoVOS = map(_parentsInfoVOS, λ(id x, [HFParentsInfoVO fromJSONDictionary:x]));
//    }
//    return self;
//}
//
//- (void)setValue:(nullable id)value forKey:(NSString *)key
//{
//    id resolved = HFBabyModel.properties[key];
//    if (resolved) [super setValue:value forKey:resolved];
//}
//
//- (NSDictionary *)JSONDictionary
//{
//    id dict = [[self dictionaryWithValuesForKeys:HFBabyModel.properties.allValues] mutableCopy];
//
//    // Rewrite property names that differ in JSON
//    for (id jsonName in HFBabyModel.properties) {
//        id propertyName = HFBabyModel.properties[jsonName];
//        if (![jsonName isEqualToString:propertyName]) {
//            dict[jsonName] = dict[propertyName];
//            [dict removeObjectForKey:propertyName];
//        }
//    }
//
//    // Map values that need translation
//    [dict addEntriesFromDictionary:@{
//        @"parentsInfoVOS": map(_parentsInfoVOS, λ(id x, [x JSONDictionary])),
//    }];
//
//    return dict;
//}
//@end

@implementation HFParentsInfoVO
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"parentsType": @"parentsType",
        @"phone": @"phone",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFParentsInfoVO alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = HFParentsInfoVO.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFParentsInfoVO.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFParentsInfoVO.properties) {
        id propertyName = HFParentsInfoVO.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
