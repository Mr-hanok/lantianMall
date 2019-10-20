//
//  StoreOrderModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StoreOrderModel.h"

@implementation StoreOrderModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"storeCartID":@"id"
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsCarts":@"GoodsOrderModel"};
}
@end
