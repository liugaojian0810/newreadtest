#import "HFPayTheFeesHistoryListModel.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface HFPayTheFeesHistoryListModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFPayTheFeesHistoryModel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HFPaymentInfoVOList (JSONConversion)
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

HFPayTheFeesHistoryListModel *_Nullable HFPayTheFeesHistoryListModelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [HFPayTheFeesHistoryListModel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HFPayTheFeesHistoryListModel *_Nullable HFPayTheFeesHistoryListModelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HFPayTheFeesHistoryListModelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HFPayTheFeesHistoryListModelToData(HFPayTheFeesHistoryListModel *payTheFeesHistoryListModel, NSError **error)
{
    @try {
        id json = [payTheFeesHistoryListModel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HFPayTheFeesHistoryListModelToJSON(HFPayTheFeesHistoryListModel *payTheFeesHistoryListModel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HFPayTheFeesHistoryListModelToData(payTheFeesHistoryListModel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HFPayTheFeesHistoryListModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"errorCode": @"errorCode",
        @"errorMessage": @"errorMessage",
        @"model": @"model",
        @"success": @"isSuccess",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return HFPayTheFeesHistoryListModelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFPayTheFeesHistoryListModelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFPayTheFeesHistoryListModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _model = map(_model, λ(id x, [HFPayTheFeesHistoryModel fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFPayTheFeesHistoryListModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFPayTheFeesHistoryListModel.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in HFPayTheFeesHistoryListModel.properties) {
        id propertyName = HFPayTheFeesHistoryListModel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"model": map(_model, λ(id x, [x JSONDictionary])),
        @"success": _isSuccess ? @YES : @NO,
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return HFPayTheFeesHistoryListModelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return HFPayTheFeesHistoryListModelToJSON(self, encoding, error);
}
@end

@implementation HFPayTheFeesHistoryModel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"couponAmount": @"couponAmount",
        @"money": @"money",
        @"payAmount": @"payAmount",
        @"paymentCycle": @"paymentCycle",
        @"paymentInfoVOList": @"paymentInfoVOList",
        @"paymentProjectName": @"paymentProjectName",
        @"paymentTime": @"paymentTime",
        @"paymentType": @"paymentType",
        @"total": @"total",
        @"totalAmount": @"totalAmount",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFPayTheFeesHistoryModel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _paymentInfoVOList = map(_paymentInfoVOList, λ(id x, [HFPaymentInfoVOList fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HFPayTheFeesHistoryModel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HFPayTheFeesHistoryModel.properties.allValues] mutableCopy];

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"paymentInfoVOList": map(_paymentInfoVOList, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation HFPaymentInfoVOList
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"money": @"money",
        @"paymentCycle": @"paymentCycle",
        @"paymentProjectName": @"paymentProjectName",
        @"paymentType": @"paymentType",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HFPaymentInfoVOList alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = HFPaymentInfoVOList.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:HFPaymentInfoVOList.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
