//
//  DetialOrderGoodsModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DetialOrderGoodsModel.h"

@implementation DetialOrderGoodsModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"goodsgcsID":@"id",
             @"goodsID":@"goods.id",
             @"goods_name":@"goods.goods_name",
             @"goodstax_rate":@"goods.tax_rate",
             };
}
@end
