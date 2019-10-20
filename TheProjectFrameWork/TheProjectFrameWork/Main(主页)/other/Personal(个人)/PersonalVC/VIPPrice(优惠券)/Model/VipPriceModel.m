//
//  VipPriceModel.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "VipPriceModel.h"

@implementation VipPriceModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"modelId":@"id"};
}
@end



@implementation VipPriceShopModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"modelId":@"id",
             @"vipPriceId":@"coupon.id",
             @"coupon_name":@"coupon.coupon_name",
             
             @"coupon_end_time":@"coupon.coupon_end_time",
             @"coupon_begin_time":@"coupon.coupon_begin_time",
             @"coupon_order_amountss":@"coupon.coupon_order_amount",
             @"coupon_count":@"coupon.coupon_count",
             @"coupon_amount":@"coupon.coupon_amount",
             @"couponTypetype":@"coupon.couponType"
             };
}

@end
