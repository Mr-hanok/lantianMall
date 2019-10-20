//
//  HomeFloorModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeFloorModel.h"

@implementation HomeFloorModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"floorid" :@"id",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"gf_list_goods":@"HomeGoodsDetial"};
}
@end
