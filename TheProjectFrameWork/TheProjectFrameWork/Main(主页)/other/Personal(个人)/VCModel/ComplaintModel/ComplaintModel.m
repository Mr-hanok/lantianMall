//
//  ComplaintModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  投诉管理数据模型

#import "ComplaintModel.h"

@implementation ComplaintModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"complaintID":@"id"};
}
@end
