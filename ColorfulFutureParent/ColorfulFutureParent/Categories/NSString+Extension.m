//
//  NSString+Extension.m
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

#pragma Hash
- (NSString *)MD5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    const char *bytes = [self UTF8String];
    CC_MD5(bytes, (CC_LONG)strlen(bytes), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7], result[8], result[9],
            result[10], result[11], result[12], result[13], result[14], result[15]];
}

#pragma Utils
- (NSString *)stringByTrimming {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isNotNilOrWhiteSpaceString {
    return [self stringByTrimming].length > 0;
}
#pragma mark富文本
- (NSMutableAttributedString *)stringwith:(UIColor *)color whith:(UIFont *)font with:(NSRange)range {
    NSMutableAttributedString *attriutedStr = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color != nil) {
        [dic addEntriesFromDictionary:@{NSForegroundColorAttributeName: color }];
    }
    if (font != nil) {
        [dic addEntriesFromDictionary:@{NSFontAttributeName: font }];
    }
    [attriutedStr addAttributes:dic range:range];
    return attriutedStr;
}

#pragma mark匿名
- (NSString *)isNiMingString {
    if (self.length == 0 || [self isEqual:[NSNull null]] || [self isEqualToString:@""] || [self isEqualToString: @"(null)"]) {
        return @"****";
    }else if (self.length == 1) {
        return @"****";
    } else if (self.length == 2 ) {
        return [[self substringToIndex:1] stringByAppendingString:@"****"];
    } else if (self.length == 11) {
        return [[[self substringToIndex:3] stringByAppendingString:@"****"] stringByAppendingString:[self substringFromIndex:7]];
    } else {
        return [[[self substringToIndex:1] stringByAppendingString:@"****"] stringByAppendingString:[self substringFromIndex:self.length - 1]];
    }
}
- (BOOL)isValidEmail {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isIDCard {
//    NSString *regex = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    NSString *regex = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSString *)gooodsListImageUrlWithString {
    NSArray *arr = [self componentsSeparatedByString:@"!"];
    return [NSString stringWithFormat:@"%@!352.jpg", arr.firstObject];
}

- (BOOL)isGSName {
    NSString *regex = @"^([\u4e00-\u9fa5])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isBlankCard {
    NSString *regex = @"^([1-9]{1})(\\d{15}|\\d{18})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isQMDHNumber {
    NSString *regex = @"^[A-Za-z0-9]{16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
- (BOOL)isPriceNumber {
    NSString *regex = @"^([1-9]\\d{0,9}|0)([.]?|(\\.\\d{1,2})?)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSString *)timeChangeType {
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [fmt dateFromString:[self substringToIndex:19]];
    NSDateFormatter *fmt2 = [[NSDateFormatter alloc]init];
    fmt2.dateFormat = @"yyyy.MM.dd-HH:mm:ss";
    return [fmt2 stringFromDate:date];
}

#pragma mark根据字符串返回宽度
- (CGFloat)fanhuikuaifont: (NSInteger)font {
    UILabel *lable = [[UILabel alloc]init];
    lable.font = [UIFont systemFontOfSize:font];
    lable.text = self;
    CGSize lableCG = [lable sizeThatFits:CGSizeMake(lable.frame.size.width, MAXFLOAT)];
    return lableCG.width;
}
- (BOOL)isWordAndNumber {
    NSString *regex = @"^(([A-Za-z]+[0-9]+)|([0-9]+[A-Za-z]+))[A-Za-z0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isSpecialChars {
    NSString *regex = @"^([\u4e00-\u9fa5]|[a-zA-Z0-9]|[%’,（）\r\n\\s-_^；：”"";=?。、.!$\x22])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isSpecial {
    NSString *regex = @"^([\u4e00-\u9fa5]|[a-zA-Z0-9])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isSpecialName {
    NSString *regex = @"^([\u4e00-\u9fa5]|[a-zA-Z]|[·])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isBillNumber {
    NSString *regex = @"^[0-9-A-Z]{18}$|^[0-9-A-Z]{15}$|^[0-9A-Z]{20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@" SELF MATCHES%@  ", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isLPKPassword {
    NSString *regex = @"^(([A-Za-z]+[0-9]+)|([0-9]+[A-Za-z]+)|([A-Za-z]+)|([0-9]+))[A-Za-z0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@" SELF MATCHES%@  ", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isChineseCellPhoneNumber {
    NSString *regex = @"1[2|3|4|5|6|7|8|9|][0-9]{9}"; //only keep the basic rule on local client
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


//英文字母开头
- (BOOL)isEnglishBegin{
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//网址链接
- (BOOL)isLink{
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//护照
- (BOOL)isPassport{
    NSString *regex =  @"^1[45][0-9]{7}|([P|p|S|s]\\d{7})|([S|s|G|g]\\d{8})|([Gg|Tt|Ss|Ll|Qq|Dd|Aa|Ff]\\d{8})|([H|h|M|m]\\d{8，10})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//汽车车牌号
- (BOOL)isCarLicense{
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//用户名
- (BOOL)isUserName{
    NSString *regex = @"^[A-Za-z0-9]{4,20}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//密码
- (BOOL)isAvalblePassword{
    NSString *regex =  @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//密码强度
-(BOOL)passwordStrength{
    NSString *regex = @"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//昵称
-(BOOL)isAvalbleNickname{
    NSString *regex =  @"([\u4e00-\u9fa5]{2,5})(&middot;[\u4e00-\u9fa5]{2,5})*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//全英文字母
- (BOOL)isAllEnglish{
    NSString *regex =  @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//全英文小写字母
- (BOOL)isAllEnglishLower{
    NSString *regex =  @"^[a-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//全英文大写字母
- (BOOL)isAllEnglishLarger{
    NSString *regex =  @"^[A-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
//全英文字母数字
- (BOOL)isAllEnglishNumber{
    NSString *regex =  @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


#pragma mark - URL
- (NSString *)URLEncodeString {
    static CFStringRef charset = CFSTR("!@#$%&*()+'\";:=,/?[] ");
    CFStringRef str = (__bridge CFStringRef)self;
    CFStringEncoding encoding = kCFStringEncodingUTF8;
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, str, NULL, charset, encoding));
}

- (NSString *)urlQueryStringValueEncodeUsingUTF8Encoding {
    return [self urlQueryStringValueEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlQueryStringValueEncodeUsingEncoding:(NSStringEncoding)encoding {
    CFStringEncoding stringEncoding = CFStringConvertNSStringEncodingToEncoding(encoding);
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                    (CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                    stringEncoding);
    return (NSString *)CFBridgingRelease(stringRef);
}

- (NSString *)urlQueryStringValueDecodeUsingUTF8Encoding {
    return [self urlQueryStringValueDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlQueryStringValueDecodeUsingEncoding:(NSStringEncoding)encoding {
    CFStringEncoding stringEncoding = CFStringConvertNSStringEncodingToEncoding(encoding);
    CFStringRef stringRef = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                    (CFStringRef)self,
                                                                                    CFSTR(""),
                                                                                    stringEncoding);
    return (NSString *)CFBridgingRelease(stringRef);
}

- (NSString *)appendQueryStringKey:(NSString *)key withValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return [self appendQueryStringKey:key withStringValue:[(NSNumber *)value stringValue]];
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        return [self appendQueryStringKey:key withStringValue:value];
    }
    
    return nil;
}

- (NSString *)appendQueryStringKey:(NSString *)key withStringValue:(NSString *)value {
    if ([self rangeOfString:@"?"].length == 0) {
        return [NSString stringWithFormat:@"%@?%@=%@", [self stringByTrimming], key, [value urlQueryStringValueEncodeUsingUTF8Encoding]];
    }
    else {
        if ([self rangeOfString:@"&"].location == (self.length - 1)) {
            return [NSString stringWithFormat:@"%@%@=%@", [self stringByTrimming], key, [value urlQueryStringValueEncodeUsingUTF8Encoding]];
        }
        else {
            return [NSString stringWithFormat:@"%@&%@=%@", [self stringByTrimming], key, [value urlQueryStringValueEncodeUsingUTF8Encoding]];
        }
    }
}

- (NSDictionary *)queryStringToDictionary {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [self componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) {
            continue;
        }
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    
    return params;
}

+ (NSString *)getSecrectMobileString:(NSString *)mobile{
    NSMutableString *newStr;
    if ([mobile isChineseCellPhoneNumber] && mobile.length == 11) {
        newStr = [NSMutableString stringWithString:mobile];
        NSRange range = NSMakeRange(3, 4);
        [newStr replaceCharactersInRange:range withString:@"****"];
    }
    return newStr;
}

@end
