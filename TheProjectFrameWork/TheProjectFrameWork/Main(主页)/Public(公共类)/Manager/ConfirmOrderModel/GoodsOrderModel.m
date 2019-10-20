//
//  GoodsOrderModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsOrderModel.h"

@implementation GoodsOrderModel


+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"goodsCartID":@"id",
             @"goodsid":@"goods.id",
             @"goods_name":@"goods.goods_name",
             @"goodstax_rate":@"goods.tax_rate",
             @"goodstaxes":@"goods.taxes",
             @"goods_price":@"goods.goods_price",
             @"goods_choice_type":@"goods.goods_choice_type",
             };
}
@end
