//
//  NSString+Validation.h
//  FaBestCare
//
//  Created by CallMe周琦 on 14/12/12.
//  Copyright (c) 2014年 CallMe周琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

+ (BOOL)validateAccount:(NSString* )account;
+ (BOOL)validatePassWord:(NSString* )password;
/**
*  验证手机号
*
*  @param mobileNumber 手机号码
*
*  @return
*/
+(BOOL)validateMobile:(NSString* )mobileNumber;
/**
 *  验证纯英文
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) textFieldEnglish:(NSString*) string;
/**
 *  验证纯数字
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)textFieldreplacementString:(NSString *)string;
/**
 *  验证用户名是否合法
 *
 *  @param _userName <#_userName description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)verifyUserName:(NSString*) _userName;
/**
 *  验证QQ
 *
 *  @param BOOL <#BOOL description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateQQ:(NSString *)qq;
/**
 *  验证邮箱
 *
 *  @param email <#email description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateEmail:(NSString *)email;
/**
 *  输入判断
 *
 *  @param password <#password description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)verifyPassword:(NSString*) password;

/**
 *  判断是否是数字和字母的组合
 *
 *  @param pass <#pass description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)judgePassWordLegal:(NSString *)pass;


/**
 *  判断不同国家的手机号
 *
 *  @param code  <#code description#>
 *  @param phone <#phone description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)verifyPhoneWithAreaCode:(NSString *)code phone:(NSString *)phone;

+ (BOOL)verifyPhoneWithPhone:(NSString *)phone;
+(BOOL) textFieldNOChinese:(NSString*) string;

/**
 *  @brief  简单手机号验证
 *
 *  @param mobileNum 手机号字符串
 *
 *  @return 是手机号YES
 */
+ (BOOL)tf_isSimpleMobileNumber:(NSString *)mobileNum;

/**
 *  @brief  简单身份证
 *
 *  @param mobileNum 身份证
 *
 *  @return 是身份证 YES
 */
+ (BOOL)tf_isValidateShenFenZheng:(NSString *)shenFenZheng;


+ (BOOL)validateZhongYingShu:(NSString* )account;

+ (BOOL)validateYingShu:(NSString* )account;

/**
 *  验证数字字母1-30
 *
 *  @param mobileNumber
 *
 *  @return
 */
+ (BOOL)validateYingYeZhiZhao:(NSString* )account;
@end
