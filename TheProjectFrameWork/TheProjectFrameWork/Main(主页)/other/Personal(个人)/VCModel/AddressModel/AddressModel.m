//
//  AddressModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"adressId" : @"id",
             @"name" : @"trueName",
             @"address" : @"area_info",
             @"telePhone" : @"telephone",
             @"phone" : @"mobile",
             @"marea" :@"area",
            };
}
@end


@implementation AdressDetailModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"marea" :@"area",
             };
}


@end
