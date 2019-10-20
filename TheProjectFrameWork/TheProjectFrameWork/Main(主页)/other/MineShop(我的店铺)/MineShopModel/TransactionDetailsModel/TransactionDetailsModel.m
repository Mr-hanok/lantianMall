//
//  TransactionDetailsModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "TransactionDetailsModel.h"

@implementation TransactionDetailsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"amount":@"pd_log_amount",@"type":@"pd_type",@"describe":@"pd_log_info",@"date":@"addTime"};
}
@end
