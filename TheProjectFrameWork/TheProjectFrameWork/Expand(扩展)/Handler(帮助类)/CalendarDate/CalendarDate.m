//
//  CalendarDate.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "CalendarDate.h"

@implementation CalendarDate
+ (NSDateComponents *)currentDate
{
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    
    return components;
//    NSInteger iCurYear = [components year];  //当前的年份
//    
//    
//    NSInteger iCurMonth = [components month];  //当前的月份
//    
//    
//    NSInteger iCurDay = [components day];  // 当前的号数
}
+ (NSInteger)dateWithYear:(NSInteger)year month:(NSInteger)month
{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    
    format.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    NSString * times = [NSString stringWithFormat:@"%ld-%ld-01 00:00:00",(long)year,(long)month];

    NSDate * date = [format dateFromString:times];
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *dateNow = [date dateByAddingTimeInterval:time];
    return [self daysWithDate:dateNow];
    
}
+ (NSInteger)daysWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return range.length;
}
+ (NSArray *)daysWithYear:(NSInteger)year month:(NSInteger)month
{
    NSInteger days = [self dateWithYear:year month:month];
    NSMutableArray * array = [@[] mutableCopy];
    for (NSInteger i = 1; i <= days; i++) {
        [array addObject:[NSString stringWithFormat:@"%02ld",(long)i]];
    }
    
    return [array copy];
}
+ (NSArray *)monthWithYear:(NSInteger)year month:(NSInteger)month
{
    NSMutableArray * array = [@[] mutableCopy];

    for (NSInteger i = 1; i <= 12; i++) {
        [array addObject:[NSString stringWithFormat:@"%02ld",(long)i]];
    }
    return [array copy];
}
+ (NSArray *)yearWithYear:(NSInteger)year
{
    NSMutableArray * array = [@[] mutableCopy];
    
    for (NSInteger i = 0; i <= 167; i++) {
        [array addObject:[NSString stringWithFormat:@"%ld",(long)year - i ]];
    }
    return [array copy];
}
+ (NSString *)year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
}
+ (NSArray *)nextWeeksDate
{
    NSMutableArray * mutable = [@[] mutableCopy];
    NSDate * nowDate = [NSDate date];
    NSDate * theDate;
    /**
     *  未来一周
     */
    NSInteger days = 7;
    for (NSInteger i = 0; i < days; i++) {
        NSTimeInterval oneDay = 24 * 60 * 60 * 1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow:+oneDay * i];
//        if(i == 0)
//        {
//        [mutable addObject:[NSString stringWithFormat:@"%@(%@)",[self stringFromDate:theDate],LaguageControl(@"今天")]];
//            continue;
//        }
        [mutable addObject:[NSString stringWithFormat:@"%@(%@)",[self stringFromDate:theDate],[self weekdayStringFromDate:theDate]]];
    }
    return [mutable copy];
}
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], LaguageControl(@"周日"), LaguageControl(@"周一"), LaguageControl(@"周二"), LaguageControl(@"周三"), LaguageControl(@"周四"), LaguageControl(@"周五"), LaguageControl(@"周六"), nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
+ (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}
@end
