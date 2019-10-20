//
//  RechargeManagerModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RechargeManagerModel.h"

@implementation RechargeManagerModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"date":@"addTime",@"payMode":@"payTypeStr",@"sum":@"pd_log_amount"};
}
@end
