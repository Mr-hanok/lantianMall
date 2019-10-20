//
//  HomeClassModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeClassModel.h"

@implementation HomeClassModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
        return @{
                 @"goodsID" : @"id",
                 @"goodsName" : @"className",
                 @"childrens" : @"childs",
                 };
}
+(NSDictionary *)mj_objectClassInArray{
    return @{@"childrens":@"HomeClassModel"};
}
@end
