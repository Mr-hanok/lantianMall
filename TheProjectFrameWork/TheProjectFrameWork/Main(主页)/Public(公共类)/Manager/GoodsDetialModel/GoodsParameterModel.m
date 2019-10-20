//
//  GoodsParameterModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsParameterModel.h"

@implementation GoodsParameterModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"parameterID" : @"id",
             @"parameterName" : @"name",
             @"parameterDataArray":@"properties",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"parameterDataArray":@"ParameterDetialModel"};
}
@end


@implementation SkuModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"modelId" : @"id",
            };
}

@end
