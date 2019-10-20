//
//  ShopGoodsModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShopGoodsModel.h"

@implementation ShopGoodsModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"goodsID" :@"id",
             };
}
@end
