
//
//  IntegralHomeModel.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "IntegralHomeModel.h"

@implementation IntegralHomeModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"goodsId" : @"id",
             };
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (oldValue == nil) return @"";
    if (oldValue == NULL) return @"";
    if ([oldValue isKindOfClass:[NSNull class]]) return @"";
    return oldValue;
}

@end
