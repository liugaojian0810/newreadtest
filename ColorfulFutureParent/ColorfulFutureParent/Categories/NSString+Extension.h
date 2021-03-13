//
//  NSString+Extension.h
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
#pragma Hash
- (NSString *)MD5String;


#pragma Utils
- (NSString *)stringByTrimming;
- (BOOL)isNotNilOrWhiteSpaceString;
- (BOOL)isValidEmail;//邮箱
- (BOOL)isChineseCellPhoneNumber;//手机号
- (BOOL)isSpecial;//昵称
- (BOOL)isIDCard;//身份证号
- (BOOL)isBlankCard;//银行卡号
- (BOOL)isWordAndNumber;//数字字母组合
- (BOOL)isSpecialChars; //过滤特殊字符
- (BOOL)isPriceNumber;//价格输入
- (BOOL)isBillNumber;//发票税号识别
- (NSString *)gooodsListImageUrlWithString;//商品列表图片地址替换；
- (BOOL)isGSName;//公司名称
- (NSMutableAttributedString *)stringwith: (UIColor *)color whith:(UIFont *)font with:(NSRange)range;//富文本

- (NSString *)isNiMingString;//匿名
- (BOOL)isQMDHNumber;//券码兑换
- (BOOL)isLPKPassword;
- (NSString *)timeChangeType;
- (BOOL)isSpecialName;

//英文字母开头
- (BOOL)isEnglishBegin;
//网址链接
- (BOOL)isLink;
//护照
- (BOOL)isPassport;
//汽车车牌号
- (BOOL)isCarLicense;
//用户名
- (BOOL)isUserName;
//密码
- (BOOL)isAvalblePassword;
//密码强度
-(BOOL)passwordStrength;
//昵称
-(BOOL)isAvalbleNickname;
//全英文字母
- (BOOL)isAllEnglish;
//全英文小写字母
- (BOOL)isAllEnglishLower;
//全英文大写字母
- (BOOL)isAllEnglishLarger;
//全英文字母数字
- (BOOL)isAllEnglishNumber;

#pragma mark - URL
- (NSString *)URLEncodeString;

- (NSString *)urlQueryStringValueEncodeUsingUTF8Encoding;
- (NSString *)urlQueryStringValueEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)urlQueryStringValueDecodeUsingUTF8Encoding;
- (NSString *)urlQueryStringValueDecodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)appendQueryStringKey:(NSString *)key withValue:(id)value;
- (NSString *)appendQueryStringKey:(NSString *)key withStringValue:(NSString *)value;

- (NSDictionary *)queryStringToDictionary;
- (CGFloat)fanhuikuaifont: (NSInteger)font;


+ (NSString *)getSecrectMobileString:(NSString *)mobile;
@end
