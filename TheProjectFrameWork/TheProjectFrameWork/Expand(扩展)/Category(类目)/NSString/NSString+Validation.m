//
//  NSString+Validation.m
//  FaBestCare
//
//  Created by CallMe周琦 on 14/12/12.
//  Copyright (c) 2014年 CallMe周琦. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSString+Validation.h"
#define NUMBERS @"0123456789\n"

@implementation NSString (Validation)
/**
 *  验证手机号
 *
 *  @param mobileNumber 手机号码
 *
 *  @return
 */
+(BOOL)validateMobile:(NSString* )mobileNumber
{
    if ([mobileNumber length] == 0) {
        return NO;
    }
    NSString *regex = @"(^[0-9]{5,15}$)";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNumber];
    if (!isMatch) {
      
        return NO;
    }
    return YES;
}
+ (BOOL)validatePassWord:(NSString* )password
{
    if ([password length] == 0) {
        return NO;
    }
    NSString *regex = @"^(?![\\d]+$)(?![a-zA-Z]+$)(?![!#$%^&!@#$%&.*]+$)[\\da-zA-Z!#$%^&!@#$%&.*]{6,20}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}
/**
 *  验证用户名
 *
 *  @param mobileNumber 手机号码
 *
 *  @return
 */
+ (BOOL)validateAccount:(NSString* )account
{
    if ([account length] == 0) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9]{4,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:account];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}
/**
 *  验证中文数字字母
 *
 *  @param mobileNumber
 *
 *  @return
 */
+ (BOOL)validateZhongYingShu:(NSString* )account
{
    if ([account length] == 0) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9\u4e00-\u9fa5]{2,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:account];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}
/**
 *  验证数字字母1-30
 *
 *  @param mobileNumber
 *
 *  @return
 */
+ (BOOL)validateYingShu:(NSString* )account
{
    if ([account length] == 0) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9]{1,30}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:account];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}
/**
 *  验证数字字母1-30
 *
 *  @param mobileNumber
 *
 *  @return
 */
+ (BOOL)validateYingYeZhiZhao:(NSString* )account
{
    if ([account length] == 0) {
        return NO;
    }
    NSString *regex = @"^[A-Za-z0-9]{15,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:account];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}

/**
 *  验证纯英文
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) textFieldEnglish:(NSString*) string
{
    NSString * regex = @"^[a-zA-Z]*[a-zA-Z\\s?]*[a-zA-Z]$";
    
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    
    return isMatch;
}
/**
 *  不包含中文
 *
 *  @param string string /^((?![\u4e00-\u9fa5]).)*$/is
 *
 *  @return <#return value description#>
 */
+(BOOL) textFieldNOChinese:(NSString*) string
{
    NSString * regex = @".*[\\u4e00-\\u9faf].*";
    
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if(isMatch){
        return NO;
    }else{
        return YES;
    }
}

/**
 *  验证纯数字
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)textFieldreplacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
        return NO;
    }
    return YES;
}

/**
 *  验证用户名是否合法
 *
 *  @param _userName <#_userName description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)verifyUserName:(NSString*) _userName
{
    
    NSString * chinaSring = @"^[\u4e00-\u9fa5]+$";
    
    NSPredicate * preString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chinaSring];
    
    
    if ([preString evaluateWithObject:_userName]) {
        return NO;
    }
    
    return YES;
    
}
/**
 *  验证QQ
 *
 *  @param BOOL <#BOOL description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateQQ:(NSString *)qq
{
    NSString *qqRegex = @"[1-9][0-9]{4,}";
    NSPredicate *QQTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [QQTest evaluateWithObject:qq];
}
/**
 *  验证邮箱
 *
 *  @param email <#email description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
/**
 *  输入判断
 *
 *  @param password <#password description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)verifyPassword:(NSString*) password
{
    NSInteger length = password.length;
    
    if (length<6 || length>18) {
        
        return NO;
    }
    
    return YES;
}

/**
 *  验证是否是数字和字母组合
 *
 *  @param pass <#pass description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if( [pass length] > 20) return NO;
    if ([pass length] >= 6){
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

+ (BOOL)verifyPhoneWithAreaCode:(NSString *)code phone:(NSString *)phone
{
    NSString * predicateStr = @"^-?[1-9]\\d*$";
    NSPredicate * regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    if(![regextestcm evaluateWithObject:phone])
    {
        return NO;
    }

    if([code isEqualToString:@"+60"])
    {// 后面跟着数字 5 － 15位
        if(phone.length >= 5 && phone.length <= 15)
        {
            return YES;
        }else
        {
            return NO;
        }
    }
    if([code isEqualToString:@"+65"])
    {// 后面跟着8 9 加7位数字  ^(9|8)\d{7}$
        predicateStr = @"^(9|8)\\d{7}$";
    }
    if([code isEqualToString:@"+673"])
    {// 文莱 后面跟着2 7 8 加六位数字 ^(2|7|8)\d{6}$
        predicateStr = @"^(2|7|8)\\d{6}$";
    }
    regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    return [regextestcm evaluateWithObject:phone];
}
+ (BOOL)verifyPhoneWithPhone:(NSString *)phone
{
//    if([phone hasPrefix:@"+60"])
//    {
//        if(phone.length > 8 && phone.length <= 18)
//        {
//            return YES;
//        }
//    }
//    if([phone hasPrefix:@"+65"] || [phone hasPrefix:@"+673"])
//    {
//        if(phone.length == 11)
//        {
//            return YES;
//        }
//    }
//    return NO;

    if (phone.length == 11 ) {
        return YES;
    } else {
        return NO;
    }

}


+ (BOOL)tf_isSimpleMobileNumber:(NSString *)mobileNum {
    if (mobileNum.length == 11 ) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)tf_isValidateShenFenZheng:(NSString *)shenFenZheng
{
    NSString *emailRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:shenFenZheng];
    
}
@end
