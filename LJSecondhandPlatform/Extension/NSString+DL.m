//
//  NSString+DL.m
//  YMShareBike
//
//  Created by 董樑 on 2017/1/22.
//  Copyright © 2017年 董樑. All rights reserved.
//

#import "NSString+DL.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (DL)
+ (BOOL)isEmpty:(NSString*)str {
    return (([str isKindOfClass:[NSNull class]]) || (str.length == 0) || (str == nil) ||  ([str isEqual:[NSNull null]]) ||([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) || ([str isEqualToString:@"(null)"])||([str isEqualToString:@"null"]));
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    return mobileNum.length == 11;
    
//    if ([NSString isEmpty:mobileNum]) {
//        return NO;
//    }
//    //    电信号段:133/153/180/181/189/177
//    //    联通号段:130/131/132/155/156/185/186/145/176
//    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
//    //    虚拟运营商:170
//
//    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//
//    return [regextestmobile evaluateWithObject:mobileNum];
}


+ (BOOL)isCorrect:(NSString *)identityString
{
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;}

+(BOOL)isChinese:(NSString*)string{
    for(int i=0; i< [string length];i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)formattedTimeInterval:(NSTimeInterval)timeInterval{
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval createTime = timeInterval;
    // 时间差
    return [self timeDistance:currentTime - createTime];

}

+ (NSString *)formattedDate:(NSString*)date
                      style:(NSString*)formatStyle{
    
    NSString *dateStr = [date stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDateFormatter *dataFormant = [[NSDateFormatter alloc] init];
    [dataFormant setDateFormat:formatStyle];
    
    NSDate *timeDate = [dataFormant dateFromString:dateStr];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval createTime = timeDate.timeIntervalSince1970;
    // 时间差
    return [self timeDistance:currentTime - createTime];
}

+(NSString *)timeDistance:(NSTimeInterval)time{
    // 秒
    NSInteger second = time;
    if (second<60 && second >= 0) {
        if(second == 0) return @"刚刚";
        else
            return [NSString stringWithFormat:@"%ld秒前",(long)second];
    }
    // 秒转分钟
    NSInteger minute = time/60;
    if (minute<60 && minute > 0) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)minute];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24 && hours > 0) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30 && days > 0) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12 && months > 0) {
        return [NSString stringWithFormat:@"%ld月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    if (years > 0) {
        return [NSString stringWithFormat:@"%ld年前",(long)years];
    }
    return @"";
}

+ (NSString*)distance:(NSString*)distance{
    
    if ([NSString isEmpty:distance]) {
        return @"0米";
    }
    
    NSString *str = distance;
    double dis = str.doubleValue;
    if (dis>0) {
        str = [NSString stringWithFormat:@"%.2f公里",dis];
    }
    
    if (dis <= 0) {
        NSInteger inte = dis*1000;
        str = [NSString stringWithFormat:@"%ld米",(long)inte];
    }
    
    return str;
}


//判断邮箱是否合法的代码
+(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy];
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        //使用compare option 来设定比较规则，如
        //NSCaseInsensitiveSearch是不区分大小写
        //NSLiteralSearch 进行完全比较,区分大小写
        //NSNumericSearch 只比较定符串的个数，而不比较字符串的字面值
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}


// 十六进制转换成字符串
+(NSString*)dataToHexString:(NSData*)data {
    if (data == nil) {
        return @"";
    }
    
    Byte *dateByte = (Byte *)[data bytes];
    
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",dateByte[i]&0xff]; ///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


+(BOOL)checkPassWord:(NSString *)passWords

{
    //6-20位数字和字母组成
    
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([pred evaluateWithObject:passWords]) {
        
        return YES ;
        
    }else
        
        return NO;
}

+(BOOL)isBankCard:(NSString *)cardNumber{
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+(NSString*)encodeStr:(NSString*)unencodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}

#define MD5key  @"eiVFACtNeIYY408HZO0iKHCard"

+ (NSDictionary *)md5Parameters:(NSMutableDictionary*)parameter
{
    NSMutableDictionary *parameters = parameter.mutableCopy;
    if ([[parameters allKeys] containsObject:@"_s"] || [[parameters allKeys] containsObject:@"_t"]){
        //        NSLog(@"方法构建通用 REST 接口 Url 时，不能使用 _s, _t 此保留字作为参数名。");
        return nil;
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    [parameters setValue:strDate forKey:@"_t"];
    
    
    NSArray *parameterNames = [parameters allKeys];
    parameterNames = [parameterNames sortedArrayUsingSelector:@selector(compare:)];// 字符串编码升序排序
    NSString *signData = @"";
    
    for (int i = 0; i < [parameters count]; i++) {
        NSString *_key = parameterNames[i];
        NSString * _value = parameters[_key];
        
        signData = [NSString stringWithFormat:@"%@%@=%@", signData, _key, _value];
        
        if (i < ([parameters count] - 1)) {
            signData = [signData stringByAppendingString:@"&"];
        }
    }
    
    NSString * md5Str = [self md5:[signData stringByAppendingString:MD5key]];
    [parameters setValue:md5Str forKey:@"_s"];
    return parameters.copy;
}

+ (NSString*)md5:(NSString*)str
{
    const char *ptr = [str UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}


+ (void)clearWebCache {
    /* 取得Library文件夹的位置*/
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    /* 取得bundle id，用作文件拼接用*/
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    /*
     * 拼接缓存地址，具体目录为App/Library/Caches/你的APPBundleID/fsCachedData
     */
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* 取得目录下所有的文件，取得文件数组*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    /* 遍历文件组成的数组*/
    for(NSString * fileName in fileList){
        /* 定位每个文件的位置*/
        NSString * path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:@""];
        /* 将文件转换为NSData类型的数据*/
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        /* 如果FileData的长度大于2，说明FileData不为空*/
        if(fileData.length >2){
            /* 创建两个用于显示文件类型的变量*/
            int char1 =0;
            int char2 =0;
            
            [fileData getBytes:&char1 range:NSMakeRange(0,1)];
            [fileData getBytes:&char2 range:NSMakeRange(1,1)];
            /* 拼接两个变量*/
            NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
            /* 如果该文件前四个字符是6033，说明是Html文件，删除掉本地的缓存*/
            if([numStr isEqualToString:@"6033"]){
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",webKitFolderInCachesfs,fileName]error:&error];
                continue;
            }
        }
    }
}


+(NSString *)numberSuitScanf:(NSString*)number{
    
    
        NSString *numberString = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
    
    
}

@end
