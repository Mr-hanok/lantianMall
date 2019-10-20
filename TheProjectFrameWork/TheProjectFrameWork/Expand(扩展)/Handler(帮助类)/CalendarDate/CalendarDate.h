//
//  CalendarDate.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDate : NSObject
/**
 *  获取当前的时间组成
 */
+ (NSDateComponents *)currentDate;
/**
 *  根据年份以及月份获取当月天数
 */
+ (NSInteger)dateWithYear:(NSInteger)year month:(NSInteger)month;
/**
 *  根据年份以及月份获取当月天数数组
 */
+ (NSArray *)daysWithYear:(NSInteger)year month:(NSInteger)month;
/**
 *  获取月份数组
 */
+ (NSArray *)monthWithYear:(NSInteger)year month:(NSInteger)month;
/**
 *  获取年份数组
 */
+ (NSArray *)yearWithYear:(NSInteger)year;
/**
 *  根据年月日获取对于时间字符串
 */
+ (NSString *)year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 *  获取未来一周日期以及星期
 *
 *  @return <#return value description#>
 */
+ (NSArray *)nextWeeksDate;

@end
