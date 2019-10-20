//
//  HomeClassVCModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeClassVCModel.h"

@implementation HomeClassVCModel


+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"ClassGoodsID" : @"id",
             @"ClassGoodsName" : @"className",
             };
}

@end
