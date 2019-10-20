//
//  NSString+Time.h
//  DoctorYL
//
//  Created by Lisa on 16/9/6.
//  Copyright © 2016年 yuntai. All rights reserved.
//
/**ossys*/
typedef NS_ENUM (NSInteger, OSSYS){
    OSSYS21720 = 10 ,
    OSSYS53720 = 11,
    OSSYS32720 = 12,
    OSSYS11720 = 13,
    OSSYS21360 = 14,
    OSSYS32360 = 15,
    OSSYS53360 = 16,
    OSSYS11360 = 17,
    OSSYS43200 = 18,
    OSSYS53200 = 19,

    
};

#import <Foundation/Foundation.h>
/**
 *  时间戳转化之类
 */
@interface NSString (Time)


/**
 *  时间转化为yyyyMMddHHmmss 的字符串
 *
 *  @param date 传入的日期
 *
 *  @return 字符串
 */
+(NSString *)stringFromDate:(NSDate *)date;

/**
 *  计算两个时间的时间差
 *
 *  @param startDate 开始的日期
 *  @param endDate 结束的日期
 *
 *  @return 时间差
 */
+ (NSString *)dateTimeDifferenceWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

/**计算年龄*/
+(NSString *)dateToOld:(NSString *)bornDate;
+(NSString *)YYYYMMDDTOYYYYMMDD:(NSString *)bornDate;
/**返回全图片路径待OSS样式*/
+ (NSString *)stingUrl:(NSString *)urlStr oss:(OSSYS)type;
/**返回plosehodelname*/
+ (NSString *)stingPloseHoldeUrlOss:(OSSYS)type;
/**yyyy.MM.dd hh:mm*/
+ (NSString *)showTime:(NSString *)msglastTime;
/**时间差*/
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime;
/**比较时间*/
+(BOOL)compareTimeWithStartTime:(NSString *)time endTime:(NSString *)endtime;
+(BOOL)compareNowWithTime:(NSString *)time;
/**生成随机时间随机数*/
+(NSString*)getTimeAndRandom;
/**获取当前时间yyyy-mm-dd hh:mm:ss*/
+(NSString*)getNowTime;
/**获取uuid*/
+ (NSString *)getUuidString;
/**NSTimeIntervall 转换为分秒*/
+(NSString *)getStringWithNsTimerIntervall:(NSTimeInterval )interval;

+ (NSString *)creatMD5StringWithString:(NSString *)string;
@end
