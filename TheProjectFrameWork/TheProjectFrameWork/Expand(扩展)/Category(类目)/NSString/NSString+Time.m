//
//  NSString+Time.m
//  DoctorYL
//
//  Created by Lisa on 16/9/6.
//  Copyright © 2016年 yuntai. All rights reserved.
//

#import "NSString+Time.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (Time)


/**
 *  时间转化为yyyyMMddHHmmss 的字符串
 *
 *
 *  @return 字符串
 */
+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+ (NSString *)dateTimeDifferenceWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    NSLog(@"startDate = %@,endDate = %@",startDate,endDate);
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [endDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"%d秒",second];
    }
    return str;
}

+(NSString *)dateToOld:(NSString *)bornDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *born = [formatter dateFromString:bornDate];
    
    //获得当前系统时间
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [formatter dateFromString:currentDateStr];
    
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:born];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}
+(NSString *)YYYYMMDDTOYYYYMMDD:(NSString *)bornDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([bornDate containsString:@":"]) {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    }else{
        formatter.dateFormat = @"yyyy-MM-dd";
 
    }
    NSDate *born = [formatter dateFromString:bornDate];
    
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *strTime = [dateFormatter stringFromDate:born];
    //获得当前系统时间
    
    return strTime;
}



+ (NSString *)stingUrl:(NSString *)urlStr oss:(OSSYS)type{
    if (urlStr.length==0) {
        return @"";
    }
    NSString *ossTypeStr ;
    switch (type) {
        case OSSYS21720:
            ossTypeStr = @"?x-oss-process=style/YS21720";
            break;
        case OSSYS53720:
            ossTypeStr = @"?x-oss-process=style/YS53720";
            break;
        case OSSYS32720:
            ossTypeStr = @"?x-oss-process=style/YS32720";
            break;
        case OSSYS11720:
            ossTypeStr = @"?x-oss-process=style/YS11720";
            break;
        case OSSYS21360:
            ossTypeStr = @"?x-oss-process=style/YS21360";
            break;
        case OSSYS32360:
            ossTypeStr = @"?x-oss-process=style/YS32360";
            break;
        case OSSYS53360:
            ossTypeStr = @"?x-oss-process=style/YS53360";
            break;
        case OSSYS11360:
            ossTypeStr = @"?x-oss-process=style/YS11360";
            break;
        case OSSYS43200:
            ossTypeStr = @"?x-oss-process=style/YS43200";
            break;
        case OSSYS53200:
            ossTypeStr = @"?x-oss-process=style/YS53200";
            break;
        default:
            ossTypeStr = @"";
            break;
    }
    
    if ([urlStr containsString:@"?x-oss-process=style/YS"]) {
        urlStr = [[urlStr componentsSeparatedByString:@"?x-oss-process=style/YS"] firstObject];
    }
        
//    if ([urlStr containsString:@"http://"]||[urlStr containsString:@"https://"]) {
//        
//        return [urlStr stringByAppendingString:ossTypeStr];
//        }
//    else{
//        urlStr = [kAliOSSRootURL stringByAppendingString:urlStr];
//        urlStr = [urlStr stringByAppendingString:ossTypeStr];
//        return urlStr;
//        }
    return [urlStr stringByAppendingString:ossTypeStr];


}
+ (NSString *)stingPloseHoldeUrlOss:(OSSYS)type{
    
    NSString *ossTypeStr ;
    switch (type) {
        case OSSYS21720:
            ossTypeStr = @"Default_Life21";
            break;
        case OSSYS53720:
            ossTypeStr = @"Default_Life53";
            break;
        case OSSYS32720:
            ossTypeStr = @"Default_Life32";
            break;
        case OSSYS11720:
            ossTypeStr = @"Default_Life11";
            break;
        case OSSYS21360:
            ossTypeStr = @"Default_Life21";
            break;
        case OSSYS32360:
            ossTypeStr = @"Default_Life32";
            break;
        case OSSYS53360:
            ossTypeStr = @"Default_Life53";
            break;
        case OSSYS11360:
            ossTypeStr = @"Default_Life11";
            break;
        case OSSYS43200:
            ossTypeStr = @"Default_Life43";
            break;
        case OSSYS53200:
            ossTypeStr = @"Default_Life53";
            break;
        default:
            ossTypeStr = @"Default_Life";
            break;
    }
    
    return ossTypeStr;
}

+(BOOL)compareTimeWithStartTime:(NSString *)time endTime:(NSString *)endtime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *startD = [date dateFromString:time ];
    
    NSDate *endD = [date dateFromString:endtime ];;
    
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    if (value>=0) {
        return YES;
    }
    
    return NO;
}


+(BOOL)compareNowWithTime:(NSString *)time{
    
    NSTimeZone *sourceTimeZone = [NSTimeZone systemTimeZone];

    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    date.timeZone = sourceTimeZone;

    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endD = [date dateFromString:time];
    NSTimeInterval end = [endD timeIntervalSince1970]*1+60*60*24;

    NSDate *startD = [NSDate date];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    if (value>0) {
        return YES;
    }
    
    return NO;
}
+ (NSString *)showTime:(NSString *)msglastTime{
    if (msglastTime== nil || [msglastTime isEqualToString:@""]) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[msglastTime doubleValue]/ 1000.0];;
    NSString *time = [dateFormatter stringFromDate:timeDate];
    return time;
}

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSDate *endD = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/ 1000.0];//[date dateFromString:startTime];
    NSDate *startD = [NSDate date];// [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    if (value<0) {
        return @"";
    }
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 *3600)%3600;
    int day = (int)value / (24 *3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"剩余%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house !=0) {
        str = [NSString stringWithFormat:@"剩余%d小时%d分%d秒",house,minute,second];
    }else if (day==0 && house==0 && minute!=0) {
        str = [NSString stringWithFormat:@"剩余%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"剩余%d秒",second];
    }
    return str;
}

+(NSString*)getTimeAndRandom{
    int iRandom=arc4random();
    if (iRandom<0) {
        iRandom=-iRandom;
    }
    
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d",[tFormat stringFromDate:[NSDate date]],iRandom];
    return tResult;
}
+(NSString*)getNowTime{
    
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *tResult=[NSString stringWithFormat:@"%@",[tFormat stringFromDate:[NSDate date]]];
    return tResult;
}

+ (NSString *)getUuidString

{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    
    CFRelease(uuid_ref);
    
    CFRelease(uuid_string_ref);
    NSString *tempstr = [uuid lowercaseString];
    
    
    return [tempstr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

+(NSString *)getStringWithNsTimerIntervall:(NSTimeInterval )interval{
    NSInteger min = interval/60;
    NSInteger sec = (NSInteger)interval%60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
}

+ (NSString *)creatMD5StringWithString:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
@end
