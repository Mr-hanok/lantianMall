//
//  ComplaintDetailedModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintDetailedModel.h"

@implementation ComplaintDetailedModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"complaintID":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsList":[ComplaintGoods class]};
}

@end
@implementation ComplaintGoods

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goodsID":@"id"};
}

@end

@implementation ComplaintAppeal



@end
@implementation Arbitration



@end