//
//  NSString+ShopRefundWay.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/10/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSString+ShopRefundWay.h"

@implementation NSString (ShopRefundWay)
+ (NSString *)shopRefundWayType:(NSString *)type
{
    NSString * typeString = nil;
    NSInteger wayType = [type integerValue];
    switch (wayType) {
        case 1:
            typeString = @"支付宝";
            break;
        case 2:
            typeString = @"微信";
            break;
        case 3:
            typeString = @"账户余额";
            break;
        case 4:
            typeString = @"线下付款";
            break;
        case 5:
            typeString = @"返利";
            break;
        case 6:
            typeString = @"余额+网银";
            break;
        case 7:
            typeString = @"余额+银行卡";
            break;
        case 8:
            typeString = @"余额+返利";
            break;
        default:
            break;
    }
    return LaguageControl(typeString);
}
@end
