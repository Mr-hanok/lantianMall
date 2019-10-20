//
//  NSDate+Conversion.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Conversion)
/**
 *  将Facebook返回的日期转化为后台需要的日期
 *
 *  @param dateStr <#dateStr description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)conversionFacebookDate:(NSString *)dateStr;
/**返回date*/
+ (BOOL )conversionToDate:(NSString *)dateStr limitType:(NSString *)limetype;
@end
