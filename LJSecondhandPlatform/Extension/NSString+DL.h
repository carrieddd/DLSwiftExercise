//
//  NSString+DL.h
//  YMShareBike
//
//  Created by 董樑 on 2017/1/22.
//  Copyright © 2017年 董樑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DL)

/*
 * 判断字符串是否为空
 */
+ (BOOL)isEmpty:(NSString*)str;
/*
 *  判断密码 6-20位数字和字母组成
 */
+ (BOOL)checkPassWord:(NSString *)passWords;
/*
 * 判断字符串是否为电话号码
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/*
 * 判断是否是email
 */
+(BOOL)validateEmail:(NSString*)email;
/*
 * 千米转换
 */
+ (NSString*)distance:(NSString*)distance;

/*
 * 判断字符串是否为身份证
 */
+ (BOOL)isCorrect:(NSString *)IDNumber;

/**
 *  转换时间为距离现在多久
 */
+ (NSString *)formattedDate:(NSString*)date
                      style:(NSString*)formatStyle;

+ (NSString *)formattedTimeInterval:(NSTimeInterval)timeInterval;

// 十六进制转换成字符串
+(NSString*)dataToHexString:(NSData*)data;

+(NSString*)encodeStr:(NSString*)unencodedString;
//是否是银行卡号
+(BOOL)isBankCard:(NSString *)cardNumber;

+ (NSDictionary *)md5Parameters:(NSDictionary*)parameter;

+ (void)clearWebCache;
+(NSString *)numberSuitScanf:(NSString*)number;

@end
