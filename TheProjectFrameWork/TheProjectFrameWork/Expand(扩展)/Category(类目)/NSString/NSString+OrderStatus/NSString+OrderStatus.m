//
//  NSString+OrderStatus.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/11/9.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NSString+OrderStatus.h"

@implementation NSString (OrderStatus)
+ (NSString *)orderStatus:(NSInteger)status
{
    NSString * statusString = nil;
    switch (status) {
        case 1:
            statusString = @"支付中";
            break;
        case 2:
            statusString = @"成功";
            break;
        case 3:
            statusString = @"支付失败";
            break;
        case 4:
            statusString = @"申请退款";
            break;
        case 5:
            statusString = @"退款完成";
            break;
        case 6:
            statusString = @"退款失败";
            break;
        default:
            statusString = @"退款失败";
            break;
    }
    return LaguageControl(statusString);
}
+ (NSString *)balanceStatus:(NSInteger)status
{
    NSString * statusString = nil;
    switch (status) {
        case 1:
            statusString = @"支付中";
            break;
        case 2:
            statusString = @"成功";
            break;
        case 3:
            statusString = @"支付失败";
            break;
        case 4:
            statusString = @"申请退款";
            break;
        case 5:
            statusString = @"退款完成";
            break;
        case 6:
            statusString = @"退款失败";
            break;
        default:
            statusString = @"提现~";
            break;
    }
    return LaguageControl(statusString);
}
@end
