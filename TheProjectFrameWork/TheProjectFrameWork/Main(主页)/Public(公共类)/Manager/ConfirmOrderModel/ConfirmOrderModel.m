//
//  ConfirmOrderModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ConfirmOrderModel.h"

@implementation ConfirmOrderModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"dateInfo":@"StoreOrderModel"};
}
@end
