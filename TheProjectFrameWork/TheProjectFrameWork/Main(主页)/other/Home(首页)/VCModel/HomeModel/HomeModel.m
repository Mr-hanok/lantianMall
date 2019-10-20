//
//  HomeModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"homeid" :@"id",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"childs":@"HomeFloorModel"};
}
@end
