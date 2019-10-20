//
//  GoodsDetialModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsDetialModel.h"

@implementation GoodsDetialModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"activity_price":@"goods.activity_price",
             @"activity_title":@"goods.activity_title",
             @"activity_desc":@"goods.activity_desc",

             @"goodsID" : @"goods.id",
             @"goods_name" : @"goods.goods_name",
             @"goods_Store_ID":@"goods.goods_store.id",
             @"goods_Store_Name":@"goods.goods_store.store_name",
             @"store_price":@"goods.store_price",
             @"goods_price":@"goods.goods_price",
             @"goods_inventory":@"goods.goods_inventory",
             @"goods_details":@"goods.goods_details",
             @"goods_click":@"goods.goods_click",
             @"goods_collect":@"goods.goods_collect",
             @"parameterArray":@"gsf",
             @"goodsImageUrl":@"min_url",
             @"favorite":@"goods.favorite",
             @"store_userId":@"goods.goods_store.store_userId",
             @"store_userName":@"goods.goods_store.store_userName",

             @"showPrice":@"goods.show_price",

             @"goods_serial":@"goods.goods_serial",
             @"goods_weight":@"goods.goods_weight",
             @"goods_brand_name":@"goods.goods_brand.name",
             @"goods_length":@"goods.goods_length",
             @"goods_width":@"goods.goods_width",
             @"goods_height":@"goods.goods_height",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"parameterArray":@"GoodsParameterModel",@"gsf1":@"GoodsParameterModel"};
}
@end
