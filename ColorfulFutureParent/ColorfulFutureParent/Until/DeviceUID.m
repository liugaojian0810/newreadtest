//
//  DeviceUID.m
//  UidDemo
//
//  Created by 123 on 16/8/25.
//  Copyright © 2016年 yipinbaike. All rights reserved.
//

#import "DeviceUID.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>

@interface DeviceUID ()

@property(nonatomic, strong, readonly) NSString *uidKey;
@property(nonatomic, strong, readonly) NSString *uid;

@end

@implementation DeviceUID
@synthesize uid = _uid;

+ (NSString *)uid {
    return [[[DeviceUID alloc] initWithKey:@"deviceUID"] uid];
}

#pragma mark - Instance methods
- (id)initWithKey:(NSString *)key {
    if (self = [super init]) {
        _uidKey = key;
        _uid = nil;
    }
    return self;
}

/*! Returns the Device UID.
 The UID is obtained in a chain of fallbacks:
 - Keychain
 - NSUserDefaults
 - Apple IFV (Identifier for Vendor)
 - Generate a random UUID if everything else is unavailable
 At last, the UID is persisted if needed to.
 */
- (NSString *)uid {
    // 应运营要求，只需要IDFA，如果为一串0也直接传，所以去除存储设计，不再判断是否为一串0
    if (!_uid) _uid = [[self class] valueForKeychainKey:_uidKey service:_uidKey];
    if (!_uid) _uid = [[self class] valueForUserDefaultsKey:_uidKey];
    if (!_uid) _uid = [[self class] appleIFA];
    if (!_uid || [_uid isEqualToString:@"00000000-0000-0000-0000-000000000000"]) _uid = [[self class] appleIFV];
    if (!_uid || [_uid isEqualToString:@"00000000-0000-0000-0000-000000000000"]) _uid = [[self class] randomUUID];
    [self save];
    return _uid;
}

/*! Persist UID to NSUserDefaults and Keychain, if not yet saved
 */
- (void)save {
    if (![DeviceUID valueForUserDefaultsKey:_uidKey]) {
        [DeviceUID setValue:_uid forUserDefaultsKey:_uidKey];
    }
    if (![DeviceUID valueForKeychainKey:_uidKey service:_uidKey]) {
        [DeviceUID setValue:_uid forKeychainKey:_uidKey inService:_uidKey];
    }
}

#pragma mark - Keychain methods

/*! Create as generic NSDictionary to be used to query and update Keychain items.
 *  param1
 *  param2
 */
+ (NSMutableDictionary *)keychainItemForKey:(NSString *)key service:(NSString *)service {
    NSMutableDictionary *keychainItem = [[NSMutableDictionary alloc] init];
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleAlways;
    keychainItem[(__bridge id)kSecAttrAccount] = key;
    keychainItem[(__bridge id)kSecAttrService] = service;
    return keychainItem;
}

/*! Sets
 *  param1
 *  param2
 */
+ (OSStatus)setValue:(NSString *)value forKeychainKey:(NSString *)key inService:(NSString *)service {
    NSMutableDictionary *keychainItem = [[self class] keychainItemForKey:key service:service];
    keychainItem[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
    return SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
}

+ (NSString *)valueForKeychainKey:(NSString *)key service:(NSString *)service {
    OSStatus status;
    NSMutableDictionary *keychainItem = [[self class] keychainItemForKey:key service:service];
    keychainItem[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    keychainItem[(__bridge id)kSecReturnAttributes] = (__bridge id)kCFBooleanTrue;
    CFDictionaryRef result = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, (CFTypeRef *)&result);
    if (status != noErr) {
        return nil;
    }
    NSDictionary *resultDict = (__bridge_transfer NSDictionary *)result;
    NSData *data = resultDict[(__bridge id)kSecValueData];
    if (!data) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - NSUserDefaults methods

+ (BOOL)setValue:(NSString *)value forUserDefaultsKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)valueForUserDefaultsKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - UID Generation methods
// IFDA：广告标识符
/*
 在iOS10之前，即使用户打开限制广告追踪功能，商家一样可以获取IDFA，只不过与之前的不一样了，每次切换这个开关与点击“还原广告标识符”的效果一样。
 而iOS10就不一样了，当用户打开这个功能后，商家只能获取到一连串无意义的0
 */
+ (NSString *)appleIFA {
    NSString *ifa = nil;
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    if (ASIdentifierManagerClass) { // a dynamic way of checking if AdSupport.framework is available
        SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
        id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
        SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
        NSUUID *advertisingIdentifier = ((NSUUID* (*)(id, SEL))[sharedManager methodForSelector:advertisingIdentifierSelector])(sharedManager, advertisingIdentifierSelector);
        ifa = [advertisingIdentifier UUIDString];
    }
    return ifa;
}

// IDFV：用于唯一标示设备的字母数字字符串，每一个供应商都不同
+ (NSString *)appleIFV {
    if(NSClassFromString(@"UIDevice") && [UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        // only available in iOS >= 6.0
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return nil;
}

// UUID：通用唯一标识符
+ (NSString *)randomUUID {
    if(NSClassFromString(@"NSUUID")) {
        return [[NSUUID UUID] UUIDString];
    }
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef cfuuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [((__bridge NSString *) cfuuid) copy];
    CFRelease(cfuuid);
    return uuid;
}

@end
