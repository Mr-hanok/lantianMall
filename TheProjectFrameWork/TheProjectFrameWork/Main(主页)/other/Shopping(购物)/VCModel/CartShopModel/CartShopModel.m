//
//  CartShopModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "CartShopModel.h"

@implementation CartShopModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"cartShopId" :@"id",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsCarts":@"CartGoodsModel"};
}
@end
