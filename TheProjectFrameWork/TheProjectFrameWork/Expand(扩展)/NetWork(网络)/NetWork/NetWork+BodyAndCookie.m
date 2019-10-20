//
//  NetWork+BodyAndCookie.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NetWork+BodyAndCookie.h"

@implementation NetWork (BodyAndCookie)

/**
 *  设置请求头
 *
 *  @param request 
 */
+(void)setHttpBody:(AFHTTPRequestSerializer *)request
{
    [request setValue:@"iOS" forHTTPHeaderField:@"from"];
    [request setValue:KVersion  forHTTPHeaderField:@"version"];
    switch ([LaguageControl shareControl].type)
    {
        case LanguageTypesChinese:
            [request setValue:@"zh" forHTTPHeaderField:@"language"];
            break;
        case LanguageTypesEnglish:
            [request setValue:@"en" forHTTPHeaderField:@"language"];
            break;
        case LanguageTypesMalas:
            [request setValue:@"ms-MY" forHTTPHeaderField:@"language"];
            break;
        default:
            [request setValue:@"en" forHTTPHeaderField:@"language"];
            break;
    }

    /*

    [request setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"version"];
    [request setValue:[NSString stringWithFormat:@"%@", @([[[UIDevice currentDevice] systemVersion] floatValue])] forHTTPHeaderField:@"sdk"];
    [request setValue:[NSString stringWithFormat:@"%@", @([NSDate date].timeIntervalSince1970)] forHTTPHeaderField:@"time"];
    [request setValue:@"1" forHTTPHeaderField:@"md5-check"];
    [request setValue:@"4" forHTTPHeaderField:@"model"];
    [request setValue:@"v1" forHTTPHeaderField:@"app"];
    [request setValue:@"2" forHTTPHeaderField:@"platform"];
 */
    
}
/**
 *  设置cookie
 */
+(void)setHttpCookie{
    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    if (cookies) {
        NSLog(@"有cookie");
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    //打印cookie，检测是否成功设置了cookie
    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookiesA) {
        NSLog(@"setCookie: %@", cookie);
    }
    NSLog(@"\n");
}
/**
 *  删除cookie
 */
+(void)deleteHttpCookic{
    NSLog(@"============删除cookie===============");
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    //把cookie打印出来，检测是否已经删除
    NSArray *cookiesAfterDelete = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookiesAfterDelete) {
        NSLog(@"cookieAfterDelete: %@", tempCookie);
    }
    NSLog(@"\n");
}
/**
 *  获取cookie
 */
+(void)getHttpCookie{
    //获取cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookies) {
        //打印获得的cookie
        NSLog(@"getCookie: %@", tempCookie);
    }
    /*
     * 把cookie进行归档并转换为NSData类型
     * 注意：cookie不能直接转换为NSData类型，否则会引起崩溃。
     * 所以先进行归档处理，再转换为Data
     */
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    
    //存储归档后的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: cookiesData forKey: @"cookie"];
    [NetWork deleteHttpCookic];
    [NetWork setHttpCookie];
}
@end
