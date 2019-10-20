//
//  HomeSlideModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeSlideModel.h"

@implementation HomeSlideModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"slideID" :@"id",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"advs":@"DetialSlideModel"};
}
@end
