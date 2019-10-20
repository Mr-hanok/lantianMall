//
//  AttentGoodsModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AttentGoodsModel.h"

@implementation AttentGoodsModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"attentsId" :@"id",
             @"attentstype":@"type",
             @"attentgoodsID":@"goods.id",
             @"attentgoods_name":@"goods.goods_name",
             @"attentgoods_main_photo":@"goods.goods_main_photo.path",
             @"attentgoods_collect":@"goods.goods_collect",
             @"attentgoodsdescription_evaluate":@"goods.description_evaluate",
             @"attentgoods_price":@"goods.goods_price",
             @"attentstore_price":@"goods.vip_price",
             @"attentstoreID":@"store.id",
             @"attentstore_name":@"store.store_name",
             @"attentstore_credit":@"store.storeCredit",
             @"attentstore_logo":@"store.store_logo.path",
             @"activity_price":@"goods.activity_price",
             @"activity_title":@"goods.activity_title",
             };
}
@end
