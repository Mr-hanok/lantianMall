//
//  ClassGoodsModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassGoodsModel.h"

@implementation ClassGoodsModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"classModelID" : @"id",
             @"classModelName" : @"goods_name",
             @"storePrice":@"vip_price",
             @"goodsPrice":@"goods_price"
             };
}

@end
