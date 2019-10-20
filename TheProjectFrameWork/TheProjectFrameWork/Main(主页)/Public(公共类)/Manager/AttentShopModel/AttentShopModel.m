//
//  AttentShopModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AttentShopModel.h"

@implementation AttentShopModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"attentshopID" :@"store_id",
             @"storeSlideArray":@"storeSlide",
             @"goodsInfoArray":@"goodsInfo",
             };
}
@end
