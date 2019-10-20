//
//  UserModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"userId":@"id",@"iconUrl":@"url",@"accountBalance":@"availablebalance",@"isPayPassWord":@"pay"};
}
@end
