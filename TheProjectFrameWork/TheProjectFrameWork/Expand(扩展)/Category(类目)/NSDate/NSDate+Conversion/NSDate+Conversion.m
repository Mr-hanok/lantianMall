//
//  NSDate+Conversion.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSDate+Conversion.h"

@implementation NSDate (Conversion)
+ (NSString *)conversionFacebookDate:(NSString *)dateStr
{
    NSDateFormatter * outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate * facebookDate = [outputFormatter dateFromString:dateStr];
     NSDateFormatter * localFormatter = [[NSDateFormatter alloc] init];
    [localFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * localStr = [localFormatter stringFromDate:facebookDate];

    return localStr;
}

+ (BOOL )conversionToDate:(NSString *)dateStr limitType:(NSString *)limetype
{
    if (![limetype isEqualToString:@"1"]) {
        return YES;
    }
    NSDateFormatter * outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * limitdate = [outputFormatter dateFromString:dateStr];
    
    NSDate *curdate = [NSDate date];
    
    NSComparisonResult result = [limitdate compare:curdate];

    switch (result)
    {
            //curdate比limitdate大
        case NSOrderedAscending:
            return NO;
            break;
            //curdate比limitdate小
        case NSOrderedDescending:
            return  YES;
            break;
            //curdate=limitdate
        case NSOrderedSame:
            return YES;
            break;
        default:
            return YES;
            break;
    }
    return YES;
}

@end
