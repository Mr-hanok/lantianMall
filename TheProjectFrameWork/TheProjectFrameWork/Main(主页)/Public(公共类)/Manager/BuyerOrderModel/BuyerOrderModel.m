//
//  BuyerOrderModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyerOrderModel.h"

@implementation BuyerOrderModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"buyoderid" :@"id",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"gcpList":@"OrderGoodsModel"};
}
@end
