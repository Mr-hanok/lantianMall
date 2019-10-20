//
//  AccountBalanceModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AccountBalanceModel.h"

@implementation AccountBalanceModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"status":@"mobile_pay_status"};
}
@end
