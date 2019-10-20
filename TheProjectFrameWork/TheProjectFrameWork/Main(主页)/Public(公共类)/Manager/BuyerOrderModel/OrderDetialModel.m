//
//  OrderDetialModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderDetialModel.h"
@implementation OrderDetialModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"invoice":@"invoices"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"gcs":@"DetialOrderGoodsModel"};
}
@end
