//
//  SearchModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"storeID" : @"id",
             @"storename" : @"store_name",
             @"goodsArray" : @"goods_list",
             };
}
@end
