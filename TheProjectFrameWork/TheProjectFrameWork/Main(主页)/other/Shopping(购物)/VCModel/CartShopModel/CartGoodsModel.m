//
//  CartGoodsModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "CartGoodsModel.h"

@implementation CartGoodsModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"goodsCartId" :@"id",
             @"goodsId":@"goods.id",
             @"goods_name":@"goods.goods_name",
             @"goods_inventory":@"goods.goods_inventory",
             @"goods_status":@"goods.goods_status",
             };
}

@end
